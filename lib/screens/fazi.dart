import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

import '../domain/project.dart';

class FaziBack {
  Future<ProjectEvaluation> loadProject(String projectName) async {
    final prefs = await SharedPreferences.getInstance();
    final projectData = prefs.getString(projectName);
    if (projectData != null) {
      return ProjectEvaluation.fromJson(jsonDecode(projectData));
    }
    throw Exception('Project data not found');
  }

  double calculateMembership(double value, double a1, double a5) {
    if (value <= a1) {
      return 0;
    } else if (value > a1 && value <= (a1 + a5) / 2) {
      return 2 * ((value - a1) / (a5 - a1)) * ((value - a1) / (a5 - a1));
    } else if (value > (a1 + a5) / 2 && value < a5) {
      return 1 - 2 * ((a5 - value) / (a5 - a1)) * ((a5 - value) / (a5 - a1));
    } else {
      return 1;
    }
  }

  Future<void> processProjects() async {
    final projects = ['P1', 'P2', 'P3', 'P4', 'P5'];
    final results = <String, Map<String, double>>{};

    for (final projectName in projects) {
      try {
        final project = await loadProject(projectName);
        final projectResults = <String, double>{};

        for (final criterion in project.criteria) {
          double value;
          switch (criterion.selectedOption) {
            case 0: // H
              value = 0.2;
              break;
            case 1: // HC
              value = 0.4;
              break;
            case 2: // C
              value = 0.6;
              break;
            case 3: // B
              value = 0.8;
              break;
            default:
              value = 0.0;
          }

          final membership = calculateMembership(value, 0.0, 1.0);
          projectResults[criterion.name] = membership;
        }

        results[project.projectName] = projectResults;
      } catch (e) {
        print('Error loading project $projectName: $e');
      }
    }

    // Print results
    results.forEach((projectName, projectResults) {
      print('Results for $projectName:');
      projectResults.forEach((criterionName, membership) {
        print('$membership');
      });
    });
  }
}

class NeuralNetworkCalculator {
  Future<Map<String, Map<String, double>>> loadProjects() async {
    final prefs = await SharedPreferences.getInstance();
    Map<String, Map<String, double>> projects = {};

    for (var p in ['P1', 'P2', 'P3', 'P4', 'P5']) {
      String? data = prefs.getString(p);
      if (data != null) {
        final decoded = jsonDecode(data) as Map<String, dynamic>;
        projects[p] =
            decoded.map((key, value) => MapEntry(key, value.toDouble()));
      }
    }
    return projects;
  }

  List<double> calculateZ(
      Map<String, Map<String, double>> data, List<double> weights) {
    List<double> zResults = [];

    for (var p in ['P1', 'P2', 'P3', 'P4', 'P5']) {
      final projectData = data[p]!;

      // Weights for individual criteria
      List<double> wGroup1 = weights.sublist(0, 2); // K_11, K_12
      List<double> wGroup2 = weights.sublist(2, 7); // K_21 to K_25
      List<double> wGroup3 = weights.sublist(7, 11); // K_31 to K_34

      // Calculate Z1, Z2, Z3
      double z1 = _calculateZ(projectData, ['K_11', 'K_12'], wGroup1);
      double z2 = _calculateZ(
          projectData, ['K_21', 'K_22', 'K_23', 'K_24', 'K_25'], wGroup2);
      double z3 =
          _calculateZ(projectData, ['K_31', 'K_32', 'K_33', 'K_34'], wGroup3);

      zResults.addAll([z1, z2, z3]);
    }
    return zResults;
  }

  List<double> calculateW(List<double> zResults, List<double> groupWeights) {
    List<double> wResults = [];
    double weightSum = groupWeights.reduce((value, element) => value + element);

    for (int i = 0; i < zResults.length; i += 3) {
      double w1 = groupWeights[0] / weightSum * zResults[i];
      double w2 = groupWeights[1] / weightSum * zResults[i + 1];
      double w3 = groupWeights[2] / weightSum * zResults[i + 2];
      wResults.addAll([w1, w2, w3]);
    }
    return wResults;
  }

  double _calculateZ(Map<String, double> projectData, List<String> keys,
      List<double> weights) {
    double numerator = 0.0;
    double denominator = weights.reduce((value, element) => value + element);

    for (int i = 0; i < keys.length; i++) {
      numerator += (projectData[keys[i]] ?? 0.0) * weights[i];
    }

    return numerator / denominator;
  }
}

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
        print('$criterionName: $membership');
      });
    });
  }
}

import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

import '../project.dart';

class SharedPref {
  static Future<void> saveProject(ProjectEvaluation project, String key) async {
    final prefs = await SharedPreferences.getInstance();

    String projectJson = jsonEncode(project.toJson());

    await prefs.setString(key, projectJson);
  }

  static Future<ProjectEvaluation?> loadProject(String key) async {
    final prefs = await SharedPreferences.getInstance();

    String? projectJson = prefs.getString(key);

    if (projectJson != null) {
      Map<String, dynamic> jsonData = jsonDecode(projectJson);
      return ProjectEvaluation.fromJson(jsonData);
    }

    return null;
  }

  static Future<void> clearAll() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.clear();
  }
}

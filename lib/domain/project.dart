import 'criterion.dart';

class ProjectEvaluation {
  String projectName; // Назва проєкту
  List<Criterion> criteria; // Список критеріїв для цього проєкту

  ProjectEvaluation({
    required this.projectName,
    required this.criteria,
  });

  Map<String, dynamic> toJson() => {
        'projectName': projectName,
        'criteria': criteria.map((c) => c.toJson()).toList(),
      };

  static ProjectEvaluation fromJson(Map<String, dynamic> json) =>
      ProjectEvaluation(
        projectName: json['projectName'],
        criteria: (json['criteria'] as List)
            .map((c) => Criterion.fromJson(c))
            .toList(),
      );
}

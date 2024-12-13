class Criterion {
  String id; // Ідентифікатор критерію (наприклад, "K_11")
  String name; // Назва критерію
  int selectedOption; // Обрана відповідь (індекс варіанту відповіді)
  double confidence; // Коефіцієнт впевненості

  Criterion({
    required this.id,
    required this.name,
    this.selectedOption = 0,
    this.confidence = 0.0,
  });

  // Метод для серіалізації в JSON (для збереження в базі)
  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'selectedOption': selectedOption,
        'confidence': confidence,
      };

  // Метод для десеріалізації з JSON
  static Criterion fromJson(Map<String, dynamic> json) => Criterion(
        id: json['id'],
        name: json['name'],
        selectedOption: json['selectedOption'],
        confidence: json['confidence'],
      );
}

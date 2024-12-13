import 'package:flutter/material.dart';

class Dadatok extends StatefulWidget {
  const Dadatok({super.key});

  @override
  State<Dadatok> createState() => _DadatokState();
}

class _DadatokState extends State<Dadatok> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Додаток'),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 40),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                  " Шкалу вихідної змінної Y={y_1,y_2,y_3,y_4,y_5} запропонуємо наступну:  y_1 = «рейтинг команди розробників стартап проекту – високий». Найвищий рівень рейтингу стартап команди. Дуже низькі очікування по ризиках невиконання зобов’язань по розробці проекту. Дуже висока здатність своєчасно реагувати та вирішувати поточні або стратегічні проблеми реалізації проекту y_2 = «рейтинг команди розробників стартап проекту – вище середнього». Високий рівень рейтингу стартап команди. Низькі очікування по ризикам невиконання зобов’язань по розробці проекту. Здатність вчасно реагувати та вирішувати поточні або стратегічні проблеми реалізації проекту, однак негативні зміни обставин і економічної кон’юнктури з більшою ймовірністю можуть знизити цю здатність; y_3 = «рейтинг команди розробників стартап проекту – середній». Спекулятивний рівень рейтингу стартап команди. Існує можливість розвитку проектних ризиків або ризиків конфліктів у середині команди, особливо в результаті негативних економічних змін, які можуть статися з часом; y_4 = «рейтинг команди розробників стартап проекту – низький». Рейтинг говорить, що реалізувати вчасно проект видається не реальною можливістю. Здатність виконувати проектні зобов’язання команди цілком залежать від сприятливої ділової та економічної кон’юнктури; y_5 = «рейтинг команди розробників стартап проекту – дуже низький». Дуже високі ризики невиконання зобов’язань по розробці проекту. Сформована стартап команда не здатна працювати над проектом. "),
            ],
          ),
        ),
      ),
    );
  }
}
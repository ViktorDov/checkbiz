import 'package:flutter/material.dart';

import '../constants/questions.dart';
import '../domain/criterion.dart';
import '../domain/data_provider/shared_pref.dart';
import '../domain/project.dart';
import 'quiz_four.dart';

class QuestionProjectThree extends StatefulWidget {
  const QuestionProjectThree({super.key});

  @override
  State<QuestionProjectThree> createState() => _QuestionProjectThreeState();
}

class _QuestionProjectThreeState extends State<QuestionProjectThree> {
  int _currentQuestionIndex = 0;
  int? _selectedOption;
  final List<int?> _selectedAnswers = [];
  final List<Map<String, dynamic>> _questions = Questions.questions;
  final List<Criterion> _criteria = [];

  Future<void> saveProjectData() async {
    final projectEvaluation = ProjectEvaluation(
      projectName: 'P3',
      criteria: _criteria,
    );

    await SharedPref.saveProject(projectEvaluation, 'P3');
    print('saved');
  }

  void _nextQuestion() {
    if (_selectedOption != null) {
      _criteria.add(
        Criterion(
          id: _currentQuestionIndex.toString(),
          name: _questions[_currentQuestionIndex]['question'],
          selectedOption: _selectedOption!,
          confidence: .5,
        ),
      );
      setState(
        () {
          if (_currentQuestionIndex < _questions.length - 1) {
            _currentQuestionIndex++;
            _selectedAnswers.add(_selectedOption);
            print(_selectedAnswers);
            _selectedOption = null;
          } else {
            showDialog(
              context: context,
              builder: (context) => AlertDialog(
                title: const Text('Дякуємо!'),
                content: const Text('Ви завершили опитування для Р3!'),
                actions: [
                  TextButton(
                    onPressed: () {
                      saveProjectData();
                      setState(() {
                        _currentQuestionIndex = 0;
                        _selectedOption = null;
                      });
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const QuestionProjectFour(),
                        ),
                      );
                    },
                    child: const Text('ОК'),
                  ),
                ],
              ),
            );
          }
        },
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Будь ласка, оберіть варіант відповіді.'),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final currentQuestion = _questions[_currentQuestionIndex];
    return Scaffold(
      appBar: AppBar(
        title: const Text('Опитування'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              currentQuestion['question'],
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            ...List.generate(currentQuestion['options'].length, (index) {
              return RadioListTile<int>(
                title: Text(currentQuestion['options'][index]),
                value: index,
                groupValue: _selectedOption,
                onChanged: (value) {
                  setState(() {
                    _selectedOption = value;
                  });
                },
              );
            }),
            const Spacer(),
            ElevatedButton(
              onPressed: _nextQuestion,
              child: const Text('Наступне'),
            ),
          ],
        ),
      ),
    );
  }
}

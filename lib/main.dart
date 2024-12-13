import 'package:flutter/material.dart';
import 'package:flutter_checkbiz/domain/data_provider/shared_pref.dart';
import 'screens/dodatok.dart';
import 'screens/quiz.dart';
import 'setings.dart';

void main() {
  runApp(const QuestionnaireApp());
}

class QuestionnaireApp extends StatelessWidget {
  const QuestionnaireApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: MainMenuScreen(),
    );
  }
}

class MainMenuScreen extends StatefulWidget {
  const MainMenuScreen({super.key});

  @override
  State<MainMenuScreen> createState() => _MainMenuScreenState();
}

class _MainMenuScreenState extends State<MainMenuScreen> {
  Future<void> _onStartPressButton() async {
    await SharedPref.clearAll();
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const QuestionnaireScreen(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Головне меню'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () {
                _onStartPressButton();
              },
              child: const Text('Опитування'),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const SettingsScreen(),
                  ),
                );
              },
              child: const Text('Налаштування'),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const Dadatok(),
                  ),
                );
              },
              child: const Text('Додаткова інформація'),
            ),
          ],
        ),
      ),
    );
  }
}

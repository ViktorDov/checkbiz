import 'package:flutter/material.dart';
import 'package:flutter_checkbiz/domain/data_provider/shared_pref.dart';
import 'package:flutter_checkbiz/screens/fazi.dart';

class FazificationData extends StatefulWidget {
  const FazificationData({super.key});

  @override
  State<FazificationData> createState() => _FazificationDataState();
}

class _FazificationDataState extends State<FazificationData> {
  Future<void> loadData() async {
    final p1 = await SharedPref.loadProject('P1'); // P1 is the project name
    final p2 = await SharedPref.loadProject('P2');
    final p3 = await SharedPref.loadProject('P3');
    final p4 = await SharedPref.loadProject('P4');
    final p5 = await SharedPref.loadProject('P5');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Дані фазифікації'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () {
                FaziBack().processProjects();
              },
              child: const Text('Вивести дані'),
            ),
          ],
        ),
      ),
    );
  }
}

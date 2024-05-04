import 'package:flutter/material.dart';
import 'package:tldr/Screens/CategoryPicker.dart';
import 'package:tldr/Screens/time_picker_page.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  DateTime time = DateTime.now();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Text(
          widget.title,
          style: TextStyle(
            fontSize: 32,
            fontWeight: FontWeight.bold,
            foreground: Paint()
              ..shader = const LinearGradient(
                colors: [
                  Color(0xFF31302B),
                  Color(0xFFB12496),
                  Color(0xFFF47D65)
                ],
              ).createShader(const Rect.fromLTWH(10.0, 0.0, 80.0, 70.0)),
          ),
        ),
      ),
      // body: CategoryPicker(),
      body: TimePickerPage({}),
      backgroundColor: Colors.black,
    );
  }
}

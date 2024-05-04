import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

class TimePickerPage extends StatefulWidget {
  Set<String> selectedCategories = {};

  TimePickerPage(this.selectedCategories, {super.key});

  @override
  State<TimePickerPage> createState() => _TimePickerPageState();
}

class _TimePickerPageState extends State<TimePickerPage> {
  late DateTime time;

  @override
  void initState() {
    super.initState();
    time = DateTime.now();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Center(
          child: CupertinoTheme(
        data: const CupertinoThemeData(
          textTheme: CupertinoTextThemeData(
            dateTimePickerTextStyle: TextStyle(
              color: Colors.white,
              fontSize: 24,
            ),
          ),
        ),
        child: CupertinoDatePicker(
          mode: CupertinoDatePickerMode.time,
          initialDateTime: time,
          onDateTimeChanged: (DateTime newTime) {
            setState(() {
              time = newTime;
            });
          },
        ),
      )),
    );
  }
}

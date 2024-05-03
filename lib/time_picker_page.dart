import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class TimePickerPage extends StatefulWidget {
  @override
  _TimePickerPageState createState() => _TimePickerPageState();
}

class _TimePickerPageState extends State<TimePickerPage> {
  DateTime time = DateTime.now();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Set Time'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Container(
              height: 200,
              child: CupertinoDatePicker(
                mode: CupertinoDatePickerMode.time,
                use24hFormat: false,
                initialDateTime: time,
                onDateTimeChanged: (DateTime newTime) {
                  HapticFeedback.lightImpact(); // Provides physical feedback on scroll
                  setState(() {
                    time = newTime;
                  });
                },
              ),
            ),
            SizedBox(height: 20),
            Text('You shall be notified at: ${time.hour % 12}:${time.minute} ${time.hour >= 12 ? 'PM' : 'AM'}'),
          ],
        ),
      ),
    );
  }
}

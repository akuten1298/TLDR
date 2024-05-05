import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:tldr/Screens/NewsPage.dart';
import 'package:tldr/Widgets/CustomAppBar.dart';

class TimePickerPage extends StatefulWidget {
  Set<String> selectedCategories = {};

  TimePickerPage(this.selectedCategories, {Key? key}) : super(key: key);

  @override
  State<TimePickerPage> createState() => _TimePickerPageState();
}

class _TimePickerPageState extends State<TimePickerPage> {
  late DateTime time;

  Set<String> get selectedCategories => widget.selectedCategories;

  @override
  void initState() {
    super.initState();
    time = DateTime.now();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(),
      backgroundColor: Colors.transparent,
      body: Column(
        children: <Widget>[
          Expanded(
            child: Center(
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
              ),
            ),
          ),
          GestureDetector(
            onTap: () {
              Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(builder: (context) {
                  return NewsPage(selectedCategories, time);
                }),
                (Route<dynamic> route) => false,
              );
            },
            child: Container(
              width: double.infinity,
              height: 50,
              margin: const EdgeInsets.all(13),
              decoration: BoxDecoration(
                shape: BoxShape.rectangle,
                borderRadius: BorderRadius.circular(100),
                gradient: const LinearGradient(
                  colors: [
                    // Color(0xFF31302B),
                    Color(0xFFB12496),
                    Color(0xFFF47D65)
                  ],
                ),
              ),
              child: const Center(
                child: Text(
                  "Next",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

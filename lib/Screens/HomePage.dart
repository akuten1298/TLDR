import 'package:flutter/material.dart';
import 'package:tldr/Screens/FavCategoryPicker.dart';
import 'package:tldr/Widgets/CustomAppBar.dart';

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
      appBar: CustomAppBar(),
      body: CategoryPicker(),
      backgroundColor: Colors.black,
    );
  }
}

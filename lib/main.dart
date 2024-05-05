import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:tldr/Screens/FavCategoryPicker.dart';

import 'Screens/HomePage.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: MyHomePage(title: 'TLDR'),
      debugShowCheckedModeBanner: false,
    );
  }
}

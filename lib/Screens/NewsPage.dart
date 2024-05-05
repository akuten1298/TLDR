import 'package:flutter/material.dart';
import 'package:category_navigator/category_navigator.dart';
import 'package:tldr/Widgets/CustomAppBar.dart';

class NewsPage extends StatefulWidget {
  final Set<String> selectedCategories;
  final DateTime time;

  NewsPage(this.selectedCategories, this.time, {Key? key}) : super(key: key);

  @override
  State<NewsPage> createState() => _NewsPageState();
}

class _NewsPageState extends State<NewsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(),
      backgroundColor: Colors.transparent,
      body: ListView(
        children: <Widget>[
          CategoryNavigator(
              labels: widget.selectedCategories.toList(),
              // highlightBackgroundColor: [Color(0xFFB12496), Color(0xFFF47D65)],
              onChange: (value) {})
        ],
      ),
    );
  }
}

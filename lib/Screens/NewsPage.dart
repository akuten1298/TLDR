import 'dart:convert';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:category_navigator/category_navigator.dart';
import 'package:tldr/Widgets/CustomAppBar.dart';
import 'package:flutter/services.dart';
import 'package:tldr/Screens/playlist.dart';

class NewsPage extends StatefulWidget {
  final Set<String> selectedCategories;
  final DateTime time;
  
// 8076a1e6bbfe9867f65cb33eb684aa11f5f60fca

  const NewsPage(this.selectedCategories, this.time, {super.key});

  @override
  State<NewsPage> createState() => _NewsPageState();
}

class _NewsPageState extends State<NewsPage> {

  var _current = 0;

  Future<Map<String, dynamic>> getNews() async {
    final String jsonString =
        await rootBundle.loadString('lib/Assets/SampleJSON.json');
    final Map<String, dynamic> newsData = jsonDecode(jsonString);
    return newsData;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(),
      backgroundColor: Colors.transparent,
      body: ListView(
        children: <Widget>[
          CategoryNavigator(
              labels: widget.selectedCategories.toList(), 
              defaultActiveItem: 0,
              onChange: (value) {
                print(value);
                _current = value;
              }),
          FutureBuilder(
            future: getNews(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                final Map<String, dynamic> newsData =
                    snapshot.data as Map<String, dynamic>;
                return Column(
                  children: <Widget>[
                    Text("data"),
                  ],
                );
              } else {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
            },
          ),
          GestureDetector(
            onTap: () {
              Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(builder: (context) {
                  return MyApp();
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
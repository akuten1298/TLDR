import 'dart:convert';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:category_navigator/category_navigator.dart';
import 'package:tldr/Widgets/CustomAppBar.dart';
import 'package:http/http.dart' as http;
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
  var _currentNews = 0;
  List<String> get selectedCategories => widget.selectedCategories.toList();

  Future<List<dynamic>> getNews() async {
    final response = await http.get(Uri.parse(
        'https://ed88-2601-602-867e-2e00-597-4f65-e76c-1a3d.ngrok-free.app/all'));
    List<dynamic> newsData = jsonDecode(response.body);
    return newsData;
  }

  // Future<void> getMP3() async {}

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
                setState(() {
                  _current = value;
                });
              }),
          FutureBuilder(
            future: getNews(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                final List<dynamic> newsData = snapshot.data as List<dynamic>;
                List<dynamic>? categoryNews;

                for (var category in newsData) {
                  if (category['category'] == selectedCategories[_current]) {
                    categoryNews = category['value'];
                    break;
                  }
                }

                final List<Card> newsCards = categoryNews!
                    .map((news) => Card(
                          color: Colors.transparent,
                          child: Column(
                            children: <Widget>[
                              Image.network(
                                news['thumbnail'],
                                fit: BoxFit.cover,
                              ),
                              // Text(
                              //   news['title'],
                              //   style: const TextStyle(
                              //       fontSize: 18,
                              //       fontWeight: FontWeight.bold,
                              //       color: Colors.white),
                              // ),
                            ],
                          ),
                        ))
                    .toList();

                return Column(
                  children: <Widget>[
                    CarouselSlider(
                      items: newsCards,
                      options: CarouselOptions(
                          height: MediaQuery.of(context).size.height * 0.4,
                          aspectRatio: 16 / 9,
                          viewportFraction: 0.8,
                          initialPage: 0,
                          enableInfiniteScroll: true,
                          reverse: false,
                          autoPlay: false,
                          enlargeCenterPage: true,
                          scrollDirection: Axis.horizontal,
                          onPageChanged: (index, res) {
                            setState(() {
                              _currentNews = index;
                            });
                          }),
                    ),
                    Text(
                      categoryNews[_currentNews]['title'],
                      style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.white),
                    ),
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

// 8076a1e6bbfe9867f65cb33eb684aa11f5f60fca

import 'dart:convert';
import 'dart:io';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:category_navigator/category_navigator.dart';
import 'package:just_audio/just_audio.dart';
import 'package:tldr/Widgets/CustomAppBar.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/services.dart';
import 'package:tldr/Screens/playlist.dart';
import 'package:path_provider/path_provider.dart';

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

  Future<String> get _localPath async {
    final directory = await getApplicationDocumentsDirectory();
    return directory.path;
  }

  Future<File> getTextToSpeech(String text, String newsNo) async {
    final url = "https://api.deepgram.com/v1/speak?model=aura-asteria-en";
    const apiKey = "8076a1e6bbfe9867f65cb33eb684aa11f5f60fca";
    final data = jsonEncode({
      "text": text,
    });

    final headers = {
      HttpHeaders.authorizationHeader: "Token $apiKey",
      HttpHeaders.contentTypeHeader: "application/json",
    };

    final response =
        await http.post(Uri.parse(url), headers: headers, body: data);

    // Check if the response is successful
    if (response.statusCode != 200) {
      throw Exception("HTTP error! Status: ${response.statusCode}");
    }

    final path = await _localPath;
    final file = File('$path/audio$newsNo.mp3');
    await file.writeAsBytes(response.bodyBytes);
    return file;
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

                final List<SizedBox> newsCards = categoryNews!
                    .map((news) => SizedBox(
                          width: MediaQuery.of(context).size.width,
                          child: Card(
                            margin: const EdgeInsets.only(top: 10),
                            color: Colors.white,
                            child: Column(
                              children: <Widget>[
                                Expanded(
                                  // Wrap the Image.network with an Expanded widget
                                  child: Image.network(
                                    news['thumbnail'],
                                    fit: BoxFit.cover,
                                    width: MediaQuery.of(context).size.width,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ))
                    .toList();

                return Column(
                  children: <Widget>[
                    CarouselSlider(
                      items: newsCards,
                      options: CarouselOptions(
                          aspectRatio: 16 / 9,
                          viewportFraction: 0.9,
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
                    FutureBuilder(
                        future: getTextToSpeech(
                            categoryNews[_currentNews]['short_response'],
                            _currentNews.toString()),
                        builder: (context, snapshot) {
                          if (snapshot.hasData) {
                            final player = AudioPlayer();
                            player.setFilePath(snapshot.data!.path);
                            player.load();
                            return Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                IconButton(
                                  icon: const Icon(Icons.play_arrow),
                                  onPressed: () {
                                    player.play();
                                  },
                                ),
                                IconButton(
                                  icon: const Icon(Icons.pause),
                                  onPressed: () {
                                    player.pause();
                                  },
                                ),
                              ],
                            );
                          } else if (snapshot.hasError) {
                            return Text(
                              "${snapshot.error}",
                              style: TextStyle(color: Colors.white),
                            );
                          } else {
                            return const Center(
                              child: CircularProgressIndicator(),
                            );
                          }
                        }),
                  ],
                );
              } else {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
            },
          )
        ],
      ),
    );
  }
}

// 8076a1e6bbfe9867f65cb33eb684aa11f5f60fca

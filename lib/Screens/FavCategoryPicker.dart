import 'package:flutter/material.dart';
import 'package:tldr/Screens/time_picker_page.dart';

class CategoryPicker extends StatefulWidget {
  @override
  State<CategoryPicker> createState() => _CircularCategoricalPickerState();
}

class _CircularCategoricalPickerState extends State<CategoryPicker> {
  final List<String> categories = [
    "Local",
    "Sports",
    "Politics",
    "Technology",
    "Entertainment",
    "Science",
    "Health",
    "Business",
    "Education",
    "Travel",
    "Fashion",
    "Food",
    "Music",
    "Movies",
    "Books",
    "Art",
    "History",
    "Environment",
    "Lifestyle",
    "Fitness",
    "Gaming",
  ];

  Set<String> selectedCategories = {};

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Column(
        children: [
          Expanded(
            child: GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                mainAxisSpacing: 10,
                childAspectRatio: 1.5,
              ),
              itemCount: categories.length,
              itemBuilder: (BuildContext context, int index) {
                final category = categories[index];
                final isSelected = selectedCategories.contains(category);
                return GestureDetector(
                  onTap: () {
                    setState(() {
                      if (isSelected) {
                        selectedCategories.remove(category);
                      } else {
                        selectedCategories.add(category);
                      }
                    });
                  },
                  child: Container(
                    margin: const EdgeInsets.all(13),
                    decoration: BoxDecoration(
                      shape: BoxShape.rectangle,
                      borderRadius: BorderRadius.circular(100),
                      gradient: LinearGradient(
                        colors: isSelected
                            ? [Color(0xFFB12496), Color(0xFFF47D65)]
                            : [
                                const Color(0xFF31302B),
                                const Color(0xFF31302B),
                              ],
                      ),
                    ),
                    child: Center(
                      child: Text(
                        category,
                        style: TextStyle(
                          color: isSelected ? Colors.black : Colors.white,
                          fontSize: 18,
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
          Builder(
            builder: (BuildContext context) {
              return IgnorePointer(
                ignoring: selectedCategories.length < 3,
                child: GestureDetector(
                  onTap: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) {
                      return TimePickerPage(selectedCategories);
                    }));
                  },
                  child: Container(
                    margin: const EdgeInsets.all(13),
                    padding: const EdgeInsets.all(13),
                    decoration: BoxDecoration(
                      shape: BoxShape.rectangle,
                      borderRadius: BorderRadius.circular(100),
                      gradient: LinearGradient(
                        colors: selectedCategories.length >= 3
                            ? [
                                const Color(0xFFB12496),
                                const Color(0xFFF47D65),
                              ]
                            : [
                                const Color(0xFF31302B),
                                const Color(0xFF31302B),
                              ],
                      ),
                    ),
                    child: const Center(
                      child: Text(
                        "Next",
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 18,
                        ),
                      ),
                    ),
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}

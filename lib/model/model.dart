import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class Category {
  final String imagePath;
  final String categoryTitle;
  final String categoryIDNumber;
  final Color? titleColor;
  final Color backgroundCardColor;

  Category({
    required this.categoryIDNumber,
    required this.imagePath,
    required this.categoryTitle,
    this.titleColor,
    required this.backgroundCardColor,
  });
}

List<Category> categories = [
  Category(
    categoryIDNumber: '23',
    imagePath: 'assets/castle.png',
    categoryTitle: 'History',
    titleColor: Colors.pink,
    backgroundCardColor: Colors.pink[100]!, 
  ),
  Category(
    categoryIDNumber: '22',
    imagePath: 'assets/world.png',
    categoryTitle: 'Geography',
    titleColor: Colors.blue[900]!,
    backgroundCardColor: Colors.blue[300]!, 
  ),
  Category(
    categoryIDNumber: '21',
    imagePath: 'assets/sports.png',
    categoryTitle: 'Sports',
    titleColor: Colors.brown,
    backgroundCardColor: Colors.brown[100]!, 
  ),
  Category(
    categoryIDNumber: '28',
    imagePath: 'assets/vehicles.png',
    categoryTitle: 'Vehicles',
    titleColor: Colors.orange[700],
    backgroundCardColor: Colors.orange[100]!, 
  ),
  Category(
    categoryIDNumber: '24',
    imagePath: 'assets/speech.png',
    categoryTitle: 'Politics',
    titleColor: Colors.brown,
    backgroundCardColor: Colors.brown[100]!, 
  ),
  Category(
    categoryIDNumber: '10',
    imagePath: 'assets/book.png',
    categoryTitle: 'Books',
    titleColor: Colors.purple,
    backgroundCardColor: Colors.purple[100]!, 
  ),
  Category(
    categoryIDNumber: '15',
    imagePath: 'assets/joystick.png',
    categoryTitle: 'Video Games',
    titleColor: Colors.yellow[900]!,
    backgroundCardColor: Colors.yellow[100]!, 
  ),
  Category(
    categoryIDNumber: '25',
    imagePath: 'assets/paint-palette.png',
    categoryTitle: 'Art',
    titleColor: Colors.brown,
    backgroundCardColor: const Color.fromARGB(255, 229, 214, 107), 
  ),
  Category(
    categoryIDNumber: '27',
    imagePath: 'assets/lion.png',
    categoryTitle: 'Animals',
    titleColor: Colors.brown,
    backgroundCardColor: Colors.brown[100]!, 
  ),
  Category(
    categoryIDNumber: '17',
    imagePath: 'assets/science.png',
    categoryTitle: 'Science',
    titleColor:  Colors.pink,
    backgroundCardColor: const Color.fromARGB(255, 103, 243, 194),
  ),
];



// retuns 10 mutliple choice questions from the api
Future<List> get10QuestionsData(String categoryID) async {
  final response = await http.get(Uri.parse(
      'https://opentdb.com/api.php?amount=10&category=$categoryID&type=multiple&encode=base64'));
  if (response.statusCode == 200) {
    var decodedResponse = jsonDecode(response.body);
    return List<Map<String, dynamic>>.from(decodedResponse['results']);
  } else {
    throw Exception('Failed to load questions');
  }
}

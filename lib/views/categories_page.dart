import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:myapp/model/model.dart';

class CategoriesPage extends StatelessWidget {
  const CategoriesPage({super.key});

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return SafeArea(
      child: Scaffold(
        body: Stack(
          children: [
            Image.asset(
              'assets/cool-background.png',
              fit: BoxFit.cover,
              width: double.infinity,
            ),
            // Row of cateogies and a back button
            Positioned(
              top: height * 0.1,
              left: width * 0.07,
              child: Row(
                children: [
                  Text('Pick Category',
                      style: TextStyle(
                          fontSize: width * 0.06,
                          color: const Color.fromARGB(255, 255, 255, 255),
                          fontWeight: FontWeight.bold)),
                  SizedBox(
                    width: width * 0.3,
                  ),
                  ElevatedButton.icon(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    label: Icon(FontAwesomeIcons.arrowLeft,
                        size: width * 0.05, color: Colors.white),
                    style: ButtonStyle(
                        fixedSize: WidgetStateProperty.all<Size>(
                            Size(width * 0.05, height * 0.04)),
                        backgroundColor: WidgetStateProperty.all<Color>(
                            const Color.fromARGB(255, 6, 71, 124))),
                  )
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 120.0),
              child: GridView.count(
                padding: EdgeInsets.all(14),
                crossAxisCount: 2,
                children: List.generate(10, (index) {
                  final category = categories[index];
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: CategoryCard(
                        imagePath: category.imagePath,
                        categoryTitle: category.categoryTitle,
                        backgroundColor: category.backgroundCardColor,
                        categoryTitleColor: category.titleColor,
                        ),
                  );
                }),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class CategoryCard extends StatelessWidget {
  final String imagePath;
  final String categoryTitle;
  final Color backgroundColor;
  final Color? categoryTitleColor;

  const CategoryCard(
      {super.key,
      required this.imagePath,
      required this.categoryTitle,
      required this.backgroundColor,
      required this.categoryTitleColor});

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return Card(
      color: backgroundColor?? Colors.white,
      elevation: 5,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16.0), // make it adaptive
      ),
      child: Padding(
        padding: const EdgeInsets.all(6.0),
        child: Column(
          children: [
            Image.asset(
              imagePath,
              width: width * 0.2,
              height: width * 0.3,
            ),
            Text(
              categoryTitle,
              style: TextStyle(
                color: categoryTitleColor?? Colors.brown,
                fontSize: width * 0.05,
                fontWeight: FontWeight.bold,
              ),
            )
          ],
        ),
      ),
    );
  }
}

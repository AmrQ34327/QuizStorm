import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return Scaffold(
        body: Stack(
      children: [
        Image.asset(
          'assets/cool-background.png',
          fit: BoxFit.cover,
          width: double.infinity,
        ),
        Positioned(
            bottom: height * 0.2,
            left: width * 0.35,
            child: ElevatedButton(
                style: ButtonStyle(
                    side: WidgetStateProperty.all<BorderSide>(const BorderSide(
                      color: Colors.white,
                      width: 2.5,
                    )),
                    backgroundColor: WidgetStateProperty.all<Color>(
                        const Color.fromARGB(255, 238, 18, 84)),
                    fixedSize: WidgetStateProperty.all<Size>(
                        Size(width * 0.35, height * 0.1))),
                onPressed: () {
                  // to navigate user to categories of quizez
                },
                child: Text(
                  'Play!',
                  style: GoogleFonts.kanit(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: width * 0.09),
                ))),
        Positioned(
            top: height * 0.2,
            left: width * 0.35,
            child: const SizedBox(
              width: 150,
              height: 100,
              child: Card(
                color: Colors.white,
                child: Text(
                  'Daily Challenge',
                  style: TextStyle(fontSize: 22),
                ),
              ),
            )),
        Positioned(
            top: height * 0.4,
            left: width * 0.35,
            child: const SizedBox(
              width: 150,
              height: 100,
              child: Card(
                color: Colors.white,
                child: Text(
                  'Random Category',
                  style: TextStyle(fontSize: 25),
                ),
              ),
            ))
      ],
    ));
  }
}

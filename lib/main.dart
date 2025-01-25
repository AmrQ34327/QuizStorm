import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:myapp/views/categories_page.dart';

void main() => runApp(const GetMaterialApp(home: MyApp()));

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        initialRoute: '/home',
        routes: {
          '/home': (context) => const MyHomePage(),
        });
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return Scaffold(
        body: SafeArea(
      child: Stack(
        children: [
          Image.asset(
            'assets/cool-background.png',
            fit: BoxFit.cover,
            width: double.infinity,
            height: double.infinity,
          ),
          Positioned(
              bottom: height * 0.2,
              left: width * 0.35,
              child: ElevatedButton(
                  style: ButtonStyle(
                      side:
                          WidgetStateProperty.all<BorderSide>(const BorderSide(
                        color: Colors.white,
                        width: 2.5,
                      )),
                      backgroundColor: WidgetStateProperty.all<Color>(
                          const Color.fromARGB(255, 238, 18, 84)),
                      fixedSize: WidgetStateProperty.all<Size>(
                          Size(width * 0.35, height * 0.1))),
                  onPressed: () {
                    Get.to(() => const CategoriesPage());
                  },
                  child: Text(
                    'Play!',
                    style: GoogleFonts.kanit(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: width * 0.09),
                  ))),
          Positioned(
              top: height * 0.3,
              left: width * 0.16,
              child: Text(
                'QuizStorm',
                style: GoogleFonts.kanit(
                    fontSize: width * 0.14,
                    color: const Color.fromARGB(255, 238, 18, 84),
                    fontWeight: FontWeight.w900,
                    shadows: [
                      Shadow(
                        offset: const Offset(2.0, 2.0),
                        blurRadius: 3.0,
                        color: Colors.black.withOpacity(0.5),
                      ),
                    ]),
              )),
        ],
      ),
    ));
  }
}

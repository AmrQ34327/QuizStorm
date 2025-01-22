import 'package:flutter/material.dart';

class ScorePage extends StatefulWidget {
  const ScorePage({super.key});

  @override
  State<ScorePage> createState() => _ScorePageState();
}

class _ScorePageState extends State<ScorePage> {
  late final int finalScore;
  late final List falseAnswers;
  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
    final passedList = ModalRoute.of(context)!.settings.arguments as List;
    falseAnswers = passedList[0];
    finalScore = passedList[1];
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return Scaffold(
      body: SafeArea(
          child: Stack(
        children: [
          // background
          Image.asset(
            'assets/cool-background3.png',
            fit: BoxFit.cover,
            width: double.infinity,
            height: double.infinity,
          ),
          Positioned(
              top: height * 0.03,
              left: 5,
              child: IconButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: const Icon(Icons.arrow_back_ios, color: Colors.white))),
          Positioned(
            top: height * 0.1,
            left: width * 0.35,
            child: Text('Score \n $finalScore / 10',
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: width * 0.08,
                )),
          ),
          falseAnswers.isNotEmpty
              ? Positioned(
                  top: height * 0.3,
                  left: width * 0.2,
                  child: Text(
                    'Here are the questions you missed',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: width * 0.04,
                    ),
                  ),
                )
              : const SizedBox(),
          falseAnswers.isEmpty
              ? Positioned(
                top: height * 0.5,
                left : width * 0.25,
                child: Text(
                  'Good Job!'
                  ,style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: width * 0.11,
                  ),
                )
                  )
              : const SizedBox(),
          falseAnswers.isNotEmpty
              ? Padding(
                  padding: EdgeInsets.only(top: height * 0.4),
                  child: ListView.builder(
                    itemCount: falseAnswers.length,
                    itemBuilder: (context, index) {
                      final width = MediaQuery.of(context).size.width;
                      final falseAnswer = falseAnswers[index];
                      return Padding(
                        padding: EdgeInsets.all(width * 0.04),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            // question number
                            Text(
                              'Question ${falseAnswer[0]}',
                              style: const TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold),
                            ),
                            const SizedBox(height: 10),
                            // question itself
                            Padding(
                              padding: EdgeInsets.symmetric(
                                  horizontal: width * 0.05),
                              child: Text(falseAnswer[1],
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: width * 0.05,
                                    fontWeight: FontWeight.bold,
                                  )),
                            ),
                            const SizedBox(height: 15),
                            // the correct answer
                            Text('Correct Answer: ${falseAnswer[2]}',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: width * 0.04,
                                )),
                          ],
                        ),
                      );
                    },
                  ),
                )
              : const SizedBox(),
        ],
      )),
    );
  }
}

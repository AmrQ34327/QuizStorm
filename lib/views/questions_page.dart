import 'package:flutter/material.dart';
import 'package:myapp/model/model.dart';
import 'dart:convert';

class QuestionsPage extends StatefulWidget {
  QuestionsPage({super.key});

  @override
  State<QuestionsPage> createState() => _QuestionsPageState();
}

class _QuestionsPageState extends State<QuestionsPage> {
  late String categoryID;
  bool dataLoaded = false;
  late List questions;
  late List answers;
  int questionsCount = 1;
  late String question;
  int finalScore = 0;
  Color _backgroundColor = Colors.white;
  Color correctAnswerBackgroundColor = Colors.green;
  List<List> falseAnswers = [];

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      categoryID = ModalRoute.of(context)!.settings.arguments as String;
      var fetchedQuestions = await get10QuestionsData(categoryID);
      setState(() {
        questions = fetchedQuestions;
        dataLoaded = true;
        answers = questions[0]['incorrect_answers'];
        answers.add(questions[0]['correct_answer']);
        answers.shuffle();
      });
    });
  }

  void changeAnswers(int currentQuestionCount) {
    answers.clear();
    answers = questions[currentQuestionCount]['incorrect_answers'];
    answers.add(questions[currentQuestionCount]['correct_answer']);
    answers.shuffle();
    questionsCount++;
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return SafeArea(
      child: Scaffold(
          body: dataLoaded
              ? SafeArea(
                child: Stack(
                    children: [
                      Image.asset(
                        'assets/cool-background2.png',
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
                              icon: const Icon(Icons.arrow_back_ios,
                                  color: Colors.white))
                                  ),
                      // questions count
                      Positioned(
                          top: height * 0.15,
                          left: width * 0.06,
                          child: Text(
                            'Question $questionsCount',
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: width * 0.05),
                          )),
                      // the questions itself
                      Positioned(
                          top: height * 0.26,
                          left: width * 0.06,
                          child: SizedBox(
                            width: width * 0.9,
                            child: Text(
                                utf8.decode(base64Decode(
                                    questions[questionsCount - 1]['question'])),
                                style: TextStyle(
                                    fontSize: width * 0.055,
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold)),
                          )),
                      // answers
                      Padding(
                        padding: EdgeInsets.only(top: height * 0.51),
                        child: ListView.builder(
                            itemCount: 4,
                            itemBuilder: (context, index) {
                              for (var answer in answers) {
                                answer = utf8.decode(base64Decode(answer));
                              }
                              var correctAnswer = utf8.decode(base64Decode(
                                  questions[questionsCount - 1]
                                      ['correct_answer']));
                              final answer =
                                  utf8.decode(base64Decode(answers[index]));
                              return AnswerCard(
                                answer: answer,
                                isCorrectAnswer: answer == correctAnswer,
                                answerChosen: () {
                                  // if question count 11 push replacmnet named to score page
                                   if (questionsCount == 10) {
                                    Navigator.pushReplacementNamed(context, '/score',
                                        arguments: [falseAnswers,finalScore]);
                                  }
                                  if (answer == correctAnswer) {
                                    // correct answer chosen
                                    finalScore++;
                                  } else if (answer != correctAnswer) {
                                    // answer is false
                                    // add it to a list above called false answers
                                    // list has question no. , question, chosen answer , correct answer
                                    falseAnswers.add([
                                      questionsCount.toString(),
                                      utf8.decode(base64Decode(
                                          questions[questionsCount - 1]
                                              ['question'])),
                                      answer,
                                      correctAnswer
                                    ]);
                                  }
                                  if (answer == correctAnswer){
                                    Future.delayed(const Duration(seconds: 2), () {
                                    setState(() {
                                      changeAnswers(questionsCount);
                                    });
                                  });
                                  }
                                 
                                },
                              );
                            }),
                      )
                    ],
                  ),
              )
              : SafeArea(
                child: Stack(
                    children: [
                      // background
                      Image.asset(
                        'assets/cool-background2.png',
                        fit: BoxFit.cover,
                        width: double.infinity,
                      ),
                      const Center(
                        child: CircularProgressIndicator(
                          valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                        ),
                      )
                    ],
                  ),
              )),
    );
  }
}

class AnswerCard extends StatefulWidget {
  final String answer;
  final VoidCallback answerChosen;

  bool isCorrectAnswer;

  AnswerCard({
    super.key,
    required this.answer,
    required this.answerChosen,
    this.isCorrectAnswer = false,
  });

  @override
  State<AnswerCard> createState() => _AnswerCardState();
}

class _AnswerCardState extends State<AnswerCard> {
  bool backgroundchanged = false;

  void changeBackgroundColor() {
    setState(() {
      if (widget.isCorrectAnswer) {
        backgroundchanged = true;
      }
    });
  }

  void resetBackgroundColor() {
    backgroundchanged = false;
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    return SizedBox(
      width: width * 0.3,
      height: height * 0.09,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: width * 0.03),
        child: GestureDetector(
          onTap: () {
            setState(() {
              widget.answerChosen();
              changeBackgroundColor();
              Future.delayed(const Duration(seconds: 2), () {
                setState(() {
                  resetBackgroundColor();
                });
              });
            });
          },
          child: Card(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10)),
              color: backgroundchanged ? const Color.fromARGB(255, 12, 241, 20) : Colors.white,
              child: Center(
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Text(widget.answer,
                      style:
                          const TextStyle(color: Color.fromARGB(255, 4, 14, 70))),
                ),
              )),
        ),
      ),
    );
  }
}

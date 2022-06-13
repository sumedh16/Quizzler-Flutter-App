// ignore_for_file: prefer_const_constructors, sort_child_properties_last

import 'package:flutter/material.dart';
import 'quizbrain.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

void main() {
  runApp(Quiz());
}

class Quiz extends StatelessWidget {
  const Quiz({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: Colors.grey.shade900,
        body: SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 10.0),
            child: Quizzler(),
          ),
        ),
      ),
    );
  }
}

class Quizzler extends StatefulWidget {
  const Quizzler({Key? key}) : super(key: key);

  @override
  State<Quizzler> createState() => _QuizzlerState();
}

class _QuizzlerState extends State<Quizzler> {
  QuizBrain quizBrain = QuizBrain();
  List<Widget> symbols = [];

  void check(bool userSelectedAnswer) {
    if (quizBrain.getQuestionAns() == userSelectedAnswer) {
      symbols.add(Icon(
        Icons.check,
        color: Colors.green,
      ));
      quizBrain.incrementScore();
    } else {
      symbols.add(Icon(
        Icons.close,
        color: Colors.red,
      ));
    }
  }

  void checkAnswer(bool userSelectedAnswer, context) {
    setState(() {
      if (quizBrain.quizEnd() == true) {
        check(userSelectedAnswer);
        int userScore = quizBrain.getScore();
        int totalQuestions = quizBrain.getTotalQuestions();
        Alert(
          context: context,
          title: 'Finished!',
          desc:
              'You\'ve finished the quiz with the score of $userScore out of $totalQuestions.',
        ).show();
        quizBrain.reset();
        symbols = [];
      } else {
        check(userSelectedAnswer);
        quizBrain.nextQuestion();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      // ignore: prefer_const_literals_to_create_immutables
      children: <Widget>[
        Expanded(
          flex: 5,
          child: Padding(
            child: Center(
              child: Text(
                quizBrain.getQuestionText(),
                textAlign: TextAlign.center,
                style: TextStyle(
                    color: Colors.white, fontSize: 30.0, fontFamily: 'Oswald'),
              ),
            ),
            padding: EdgeInsets.all(12.0),
          ),
        ),
        Expanded(
          child: Padding(
            padding: EdgeInsets.all(12.0),
            child: TextButton(
              onPressed: () {
                checkAnswer(true, context);
              },
              child: Text(
                'True',
                style: TextStyle(
                    fontSize: 22.0, fontFamily: 'Lobster', color: Colors.white),
              ),
              style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(Colors.red)),
            ),
          ),
        ),
        Expanded(
          child: Padding(
            padding: EdgeInsets.all(12.0),
            child: TextButton(
              onPressed: () {
                checkAnswer(false, context);
              },
              child: Text(
                'False',
                style: TextStyle(
                    fontSize: 22.0, fontFamily: 'Lobster', color: Colors.white),
              ),
              style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(Colors.green)),
            ),
          ),
        ),
        Row(
          children: symbols,
        )
      ],
    );
  }
}

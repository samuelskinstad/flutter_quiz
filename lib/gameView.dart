// ignore_for_file: camel_case_types, file_names, unnecessary_new

import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:property_change_notifier/property_change_notifier.dart';

int index = 0;
bool done = false;
int answerindex = 0;
int score = 0;

class gameView extends StatefulWidget {
  List qList;
  gameView({Key? key, required this.qList}) : super(key: key);
  @override
  State<gameView> createState() => gameViewState(questionList: qList);
}

String correctAnswer = '';

class gameViewState extends State<gameView> {
  ValueNotifier<bool> rightOrWrong = ValueNotifier(false);
  List questionList;
  gameViewState({required this.questionList});
  @override
  Widget build(BuildContext context) {
    //Bygger om hela skiten varje gång den settar state...
    String question = '';
    String correctAnswer = '';
    String incorrectAnswer1 = '';
    String incorrectAnswer2 = '';
    String incorrectAnswer3 = '';
    List<String> allAnswers = [];
    try {
      question = questionList[index]['question'];
      if (questionList[index]['type'] == 'boolean') {
        correctAnswer = questionList[index]['correct_answer'];
        incorrectAnswer1 =
            questionList[index]['incorrect_answers'][answerindex];
        allAnswers.add(correctAnswer);
        allAnswers.add(incorrectAnswer1);
        allAnswers.shuffle();
      } else if (questionList[index]['type'] == 'multiple') {
        correctAnswer = questionList[index]['correct_answer'];
        incorrectAnswer1 =
            questionList[index]['incorrect_answers'][answerindex];
        incorrectAnswer2 =
            questionList[index]['incorrect_answers'][answerindex + 1];
        incorrectAnswer3 =
            questionList[index]['incorrect_answers'][answerindex + 2];
        allAnswers.add(correctAnswer);
        allAnswers.add(incorrectAnswer1);
        allAnswers.add(incorrectAnswer2);
        allAnswers.add(incorrectAnswer3);
        allAnswers.shuffle();
      }
    } on RangeError {
      print('Exception caught');
    }
    return Scaffold(
      appBar: AppBar(
        title: Text('Trivia App'),
        centerTitle: true,
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Text('Score: ' + score.toString()),
              Container(
                height: MediaQuery.of(context).size.height / 12,
              ),
              TextButton(
                onPressed: () {
                  index++;
                  // print('ALL ANSWERS IN LIST: ' + allAnswers.toString());
                  // print('A ANSWER IN LIST: ' + allAnswers[0]);
                  // print('Correct answer: ' +
                  //     questionList[index]['correct_answer']);
                  // print('INDEX: ' + index.toString());
                  // print('TYPE of question: ' + questionList[index]['type']);
                  // if (questionList[index]['type'] == 'boolean') {
                  //   String correctAnswer =
                  //       questionList[index]['correct_answer'];
                  //   String incorrectAnswer1 =
                  //       questionList[index]['incorrect_answers'][answerindex];
                  //   score = score;
                  // } else if (questionList[index]['type'] ==
                  //     'multiple'.toString()) {
                  //   String correctAnswer =
                  //       questionList[index]['correct_answer'];
                  //   String incorrectAnswer1 =
                  //       questionList[index]['incorrect_answers'][answerindex];
                  //   String incorrectAnswer2 = questionList[index]
                  //       ['incorrect_answers'][answerindex + 1];
                  //   String incorrectAnswer3 = questionList[index]
                  //       ['incorrect_answers'][answerindex + 2];
                  //   score = score;
                  // }
                  setState(() {});
                },
                child: const Text('Skippa fråga!'),
              ),
              Container(
                height: MediaQuery.of(context).size.height / 5,
                width: MediaQuery.of(context).size.width / 1.2,
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.white70.withOpacity(0.5),
                    ),
                  ],
                ),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    question,
                    style: TextStyle(
                      fontSize: 16,
                    ),
                  ),
                ),
              ),
              ListView(
                shrinkWrap: true,
                children: new List.generate(
                  allAnswers.length,
                  (index) => displayAllCards((allAnswers[index])),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  displayAllCards(String answer) {
    bool colorBool = true;
    return Card(
      elevation: 4,
      child: ValueListenableBuilder(
        valueListenable: rightOrWrong,
        builder: (context, value, child) => InkWell(
          onTap: () async {
            print(colorBool);
            updateValue(colorBool);
            if (answer == questionList[index]['correct_answer']) {
              colorBool = false;
              print('CORRECT!!');
              score++;
              await Future.delayed(Duration(seconds: 0), () {
                setState(() {
                  colorBool = true;
                });
              });
              index++;
              // if (done) {
              //   print('DETTA ÄR I POP');
              //   Navigator.pop(context);
              // }
            } else {
              print('INCORRECT');
              colorBool = true;
              await Future.delayed(Duration(seconds: 0));
              setState(() {
                colorBool = true;
              });
              index++;
              // if (done) {
              //   print('DETTA ÄR I POP');
              //   Navigator.pop(context);
              // }
            }
          },
          child: ListTile(
            title: Center(
              child: StatefulBuilder(
                builder: (context, setState) => Text(
                  answer,
                  style: TextStyle(
                      color: colorBool ? Colors.black : Colors.green[400]),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  updateValue(bool val) {
    var result = (val == true || val == false);
    rightOrWrong.value = result;
  }
}

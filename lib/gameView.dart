// ignore_for_file: file_names

import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'question.dart';

class GameView extends StatefulWidget {
  const GameView({Key? key}) : super(key: key);

  @override
  _gameViewState createState() => _gameViewState();
}

// ignore: camel_case_types
class _gameViewState extends State<GameView> {
  ValueNotifier<bool> rightOrWrong = ValueNotifier(false);
  int questionIndex = 0;
  int score = 0;
  int noOfQuestion = 0;
  @override
  Widget build(BuildContext context) {
    var state = MyState();
    List<String> allAnswers = [];
    const int answerIndex = 0;
    try {
      if (state.qList[questionIndex].type == 'boolean') {
        allAnswers.add(state.qList[questionIndex].correct_answer);
        allAnswers
            .add(state.qList[questionIndex].incorrect_answers[answerIndex]);
      } else {
        allAnswers.add(state.qList[questionIndex].correct_answer);
        allAnswers
            .add(state.qList[questionIndex].incorrect_answers[answerIndex]);
        allAnswers
            .add(state.qList[questionIndex].incorrect_answers[answerIndex + 1]);
        allAnswers
            .add(state.qList[questionIndex].incorrect_answers[answerIndex + 2]);
      }
    allAnswers.shuffle();
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 76, 79, 77),
        appBar: AppBar(
          title: const Text('Trivia App', style: TextStyle(color: Color.fromARGB(255, 201, 171, 0)),),
          centerTitle: true,
          backgroundColor: const Color.fromARGB(255, 66, 69, 67),
        ),
        body: Center(
          child: Column(
            children: [
              Container(
                height: MediaQuery.of(context).size.height / 80,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Text('SCORE: ' + score.toString(), style: const TextStyle(color: Color.fromARGB(255, 201, 171, 0)),),
                  Text('Question: ' + (noOfQuestion +1).toString(), style: const TextStyle(color: Color.fromARGB(255, 201, 171, 0)),),
                ],
              ),
              Container(
                height: MediaQuery.of(context).size.height / 24,
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  decoration:
                      BoxDecoration(color: const Color.fromARGB(255, 86, 89, 87), boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.5),
                      spreadRadius: 2,
                      blurRadius: 2,
                     // offset: Offset(2, 2),
                    ),
                  ]),
                  height: MediaQuery.of(context).size.height / 4,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      state.qList[questionIndex].question,
                      style: const TextStyle(fontSize: 24, color: Color.fromARGB(255, 201, 171, 0)),
                    ),
                  ),
                ),
              ),
              //Göra en metod där alla svar skickas med istället för att generara ett svar i taget?
              listAnswers(allAnswers),
              // ListView(
              //   shrinkWrap: true,
              //   children: List.generate(
              //     allAnswers.length,
              //     (index) => displayAllCards((allAnswers[index])),
              //   ),
              // ),
              Container(
                height: MediaQuery.of(context).size.height / 25,
              ),
              TextButton(
                  onPressed: () {
                    questionIndex++;
                    setState(() {
                      noOfQuestion++;
                    });
                  },
                  child: const Text('Skippa fråga', style: TextStyle(color: Color.fromARGB(255, 201, 171, 0)),)),
            ],
          ),
        ));
  } on RangeError {
      return AlertDialog(
        title: const Text('Slut på frågor'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text('Du fick $score poäng')
          ],
        ),
        actions: <Widget>[
          ElevatedButton(onPressed: (){
            state.getQuestions();
              questionIndex = 0;
              score = 0;
              noOfQuestion = 0;
              Navigator.pop(context);
          }, child: const Text('Starta om')),
          ElevatedButton(onPressed: (){
            exit(0);
          }, child: const Text('Avsluta')),
        ],
      );
    }
  } 

  // displayAllCards(String answer) {
  //   var state = MyState();
  //   bool correct = false;
  //   rightOrWrong.value = false;
  //   return Padding(
  //     padding: const EdgeInsets.all(2.0),
  //     child: Card(
  //       color: Colors.blue[100],
  //       elevation: 4,
  //       child: ValueListenableBuilder(
          
  //         valueListenable: rightOrWrong,
  //         builder: (context, value, child) => InkWell(
  //           onTap: () async {
  //             if (answer == state.qList[questionIndex].correct_answer) {
  //               correct = true;
  //               rightAnswer(correct);
  //               score++;
  //               questionIndex++;
  //               noOfQuestion++;
  //             } else {
  //               questionIndex++;
  //               noOfQuestion++;
  //             }
  //             await Future.delayed(Duration(seconds: 2), () {
  //               setState(() {});
  //             });
  //           },
  //           child: ListTile(
  //             title: Center(
  //               child: StatefulBuilder(
  //                 builder: (context, setState) => Text(
  //                   answer,
  //                   style:
  //                       TextStyle(color: correct ? Colors.green : Colors.black),
  //                 ),
  //               ),
  //             ),
  //           ),
  //         ),
  //       ),
  //     ),
  //   );
  // }

  listAnswers(List<String> answers){
    bool correct = false;
    rightOrWrong.value = correct;
    var state = MyState();
    return ListView.builder(
      shrinkWrap: true,
      itemCount: answers.length,
      itemBuilder: (BuildContext context, int index){
        if(state.qList[questionIndex].correct_answer == answers[index]){
          return Padding(
            padding: const EdgeInsets.only(left: 8, right: 8, top: 2),
            child: Card(
              color: const Color.fromARGB(255, 86, 89, 87),
              elevation: 4,
              child: ValueListenableBuilder(valueListenable: rightOrWrong,
              builder: (context, value, child) => InkWell(
                onTap: () async{
                  correct = true;
                    rightOrWrong.value = correct;
                    noOfQuestion++;
                    score++;
                    questionIndex++;
                                  await Future.delayed(const Duration(seconds: 2), () {
                  setState(() {});
                });
                },
                child: ListTile(title: Center(child: Text(answers[index], style: TextStyle(color: correct ? Colors.green : const Color.fromARGB(255, 201, 171, 0)),),),),
              ),),
            ),
          );
        }
        return Padding(
          padding: const EdgeInsets.only(left: 8, right: 8, top: 2),
          child: Card(
            color: const Color.fromARGB(255, 86, 89, 87), 
            elevation: 8,
            child: ValueListenableBuilder(
              valueListenable: rightOrWrong,
              builder: (context, value, child) => InkWell(
                onTap: ()async{
                  correct = true;
                    rightOrWrong.value = correct;
                    noOfQuestion++;
                    questionIndex++;
                                  await Future.delayed(const Duration(seconds: 2), () {
                  setState(() {});
                });
                },
                child: ListTile(
                title: Center(child: Text(answers[index], style: TextStyle(color: correct ? Colors.red : const Color.fromARGB(255, 201, 171, 0)),),),
              )),
            ),
          ),
        );
      });
  }

  rightAnswer(bool correct) {
    rightOrWrong.value = correct;
  }
}
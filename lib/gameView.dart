import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:quiz_final/questions.dart';

class GameView extends StatefulWidget {
  GameView({Key? key}) : super(key: key);

  @override
  _gameViewState createState() => _gameViewState();
}

class _gameViewState extends State<GameView> {
  // Set<Question> qList = {};
  // void onGameCreated()  {
  //   setState(() async {
  //     for (int i = 0; i < 10; i++) {
  //       qList.add(await MyState().getQuestions2(i));
  //     }
  //   });
  // }
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
    } on RangeError {
      print('out of range..');
    }
    allAnswers.shuffle();
    return Scaffold(
        appBar: AppBar(
          title: Text('Trivia App'),
          centerTitle: true,
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
                  Container(
                    child: Text('SCORE: ' + score.toString()),
                  ),
                  Container(
                    child: Text('No Of Questions: ' + noOfQuestion.toString()),
                  ),
                ],
              ),
              Container(
                height: MediaQuery.of(context).size.height / 24,
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  //color: Colors.blue[100],
                  decoration:
                      BoxDecoration(color: Colors.blue[100], boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.5),
                      spreadRadius: 5,
                      blurRadius: 2,
                      offset: Offset(2, 4),
                    ),
                  ]),
                  height: MediaQuery.of(context).size.height / 4,
                  //width: MediaQuery.of(context).size.width / 1.2,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      state.qList[questionIndex].question,
                      style: TextStyle(fontSize: 24),
                    ),
                  ),
                ),
              ),
              ListView(
                shrinkWrap: true,
                children: List.generate(
                  allAnswers.length,
                  (index) => displayAllCards((allAnswers[index])),
                ),
              ),
              Container(
                height: MediaQuery.of(context).size.height / 25,
              ),
              Container(
                child: TextButton(
                    onPressed: () {
                      questionIndex++;
                      setState(() {});
                    },
                    child: const Text('Skippa fråga')),
              ),
            ],
          ),
        ));
  }

  displayAllCards(String answer) {
    var state = MyState();
    bool correct = false;
    rightOrWrong.value = false;
    return Padding(
      padding: const EdgeInsets.all(2.0),
      child: Card(
        color: Colors.blue[100],
        elevation: 4,
        child: ValueListenableBuilder(
          valueListenable: rightOrWrong,
          builder: (context, value, child) => InkWell(
            onTap: () async {
              if (answer == state.qList[questionIndex].correct_answer) {
                correct = true;
                rightAnswer(correct);
                score++;
                questionIndex++;
                noOfQuestion++;
              } else {
                questionIndex++;
                noOfQuestion++;
              }
              await Future.delayed(Duration(seconds: 2), () {
                setState(() {});
              });
            },
            child: ListTile(
              title: Center(
                child: StatefulBuilder(
                  builder: (context, setState) => Text(
                    answer,
                    style:
                        TextStyle(color: correct ? Colors.green : Colors.black),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  rightAnswer(bool correct) {
    rightOrWrong.value = correct;
  }
}
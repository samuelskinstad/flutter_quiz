// ignore_for_file: non_constant_identifier_names

import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

class Question {
  String type;
  String question;
  String correct_answer;
  List<dynamic> incorrect_answers;

  Question(
      {required this.type,
      required this.question,
      required this.correct_answer,
      required this.incorrect_answers});
}

List<Question> _allQuestions = [];

class MyState extends ChangeNotifier {
  List<Question> get qList => _allQuestions;

  Future getQuestions() async {
    print('getQuestions körs....');
    List<Question> allQuestions = [];
    final respone =
        await http.get(Uri.parse('https://opentdb.com/api.php?amount=10'));
    Map<String, dynamic> map = json.decode(respone.body);
    List<dynamic> data = map["results"];
    for (var element in data) {
      allQuestions.add(Question(
          type: element['type'],
          question: element['question'],
          correct_answer: element['correct_answer'],
          incorrect_answers: element['incorrect_answers']));
    }
    _allQuestions = allQuestions;
    print('Fråga ett från qList --> ' + qList[4].question);
    print('Fråga ett från _allQuestions --> ' + _allQuestions[0].question);
    notifyListeners();
  }

  void checkAnswer(context, String answer, int index) {
    if (answer == qList[index].correct_answer) {
      Provider.of<Question>(context, listen: false);
    } else {
      Provider.of<Question>(context, listen: false);
    }
  }
}

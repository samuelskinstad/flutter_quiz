import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'gameView.dart';

// Future<List<Question>> fetchQuestions(http.Client client) async {
//   final respone =
//       await client.get(Uri.parse('https://opentdb.com/api.php?amount=10'));
//   return compute(parseQuestion, respone.body);
// }

// List<Question> parseQuestion(String responsebody) {
//   print(responsebody.toString());
//   // final parsed = jsonDecode(responsebody).cast<Map<String, dynamic>>();
//   //final Map<String, dynamic> parsed = jsonDecode(responsebody);
//   final parsed = json.decode(responsebody).cast<Map<String, dynamic>>();
//   return parsed.map<Question>((json) => Question.fromJson(json)).toList();
// }

// class Question {
//   String response_code;
//   String results;
//   String category = '';
//   String type = '';
//   String difficulty = '';
//   String question;
//   String correct;
//   List incorrect;
//   Question(
//       {required this.response_code, required this.results,
//       required this.category,
//       required this.type,
//       required this.difficulty,
//       required this.question,
//       required this.correct,
//       required this.incorrect});

//   factory Question.fromJson(Map<String, dynamic> json) {
//     return Question(
//         respone_code = json['response_code'],
//         results = json['results'],
//         category: json['category'],
//         type: json['type'],
//         difficulty: json['difficulty'],
//         question: json['question'],
//         correct: json['correct_answer'],
//         incorrect: json['incorrect_answers']);
//   }
// }

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      debugShowCheckedModeBanner: false,
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    List questions;
    //Future List<dynamic> questions = checkRespons();
    //Future<List> questionsList = checkRespons();
    return Scaffold(
      appBar: AppBar(
        title: Text('TRIVIA'),
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                height: MediaQuery.of(context).size.height / 2,
                width: MediaQuery.of(context).size.width / 1.2,
                color: Colors.blue,
                child: Text('Välkommen till Trivia App av SamuelSkinstad'),
              ),
            ),
            Container(
              height: MediaQuery.of(context).size.height / 8,
            ),
            TextButton(
                style: ButtonStyle(
                  elevation: MaterialStateProperty.all(3),
                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                    RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(18),
                        side: BorderSide(color: Colors.amber)),
                  ),
                ),
                onPressed: () async {
                  questions = await checkRespons();
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => gameView(
                        qList: questions,
                      ),
                    ),
                  );
                },
                child: Text(
                  'New Game!',
                  style: TextStyle(fontSize: 24),
                )),
          ],
        ),
      ),
    );
  }

  Future<List> checkRespons() async {
    final respone =
        await http.get(Uri.parse('https://opentdb.com/api.php?amount=10'));
    // var parsed = respone.body;
    // List<String> qList = parsed.split("}");
    Map<String, dynamic> map = json.decode(respone.body);
    List<dynamic> data = map["results"];
    return data;
  }

  List<Question> parseQuestion(String responsebody) {
    var json = jsonDecode(responsebody);
    return json.map<Question>((data) {
      return Question.fromJson(data);
    }).toList();
  }
}

class Question {
  int responseCode;
  List results;
  String category;
  Null type;
  Null difficulty;
  Null question;
  Null correct;
  Null incorrect;
  Question(
      {required this.responseCode,
      required this.results,
      required this.category,
      required this.type,
      required this.difficulty,
      required this.question,
      required this.correct,
      required this.incorrect});

  factory Question.fromJson(Map<String, dynamic> json) {
    return Question(
        responseCode: json['response_code'],
        results: json['results'],
        category: json['category'],
        type: json['type'],
        difficulty: json['difficulty'],
        question: json['question'],
        correct: json['correct_answer'],
        incorrect: json['incorrect_answers']);
  }
}

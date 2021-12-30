import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'gameView.dart';
import 'question.dart';

void main() {
  var state = MyState();
  state.getQuestions();
  runApp(
    ChangeNotifierProvider(create: (context) => state, child: const MyApp()),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      // theme: ThemeData(
      //   primarySwatch: Colors.grey,
      // ),
      title: 'Flutter Demo',
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  // ignore: use_key_in_widget_constructors
  const MyHomePage();

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 76, 79, 77),
      appBar: AppBar(
        title: const Text('Trivia App', style: TextStyle(color: Color.fromARGB(255, 201, 171, 0)),),
        backgroundColor: const Color.fromARGB(255, 66, 69, 67),
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          children: [
            const Text('Trivia App av SamuelSkinstad'),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: SizedBox(
                height: MediaQuery.of(context).size.height / 2,
                width: MediaQuery.of(context).size.width / 1.2,
                //color: Colors.white24,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Image.asset('assets/images/TriviaText.png'),
                ),
              ),
            ),
            Container(
              height: MediaQuery.of(context).size.height / 8,
            ),
            TextButton(
              
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all<Color>(const Color.fromARGB(255, 66, 69, 67)),
                  elevation: MaterialStateProperty.all(1),
                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                    RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(18),
                        side: const BorderSide(color: Color.fromARGB(255, 66, 69, 67))),
                  ),
                ),
                onPressed: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => const GameView(),
                    ),
                  );
                },
                child: const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text(
                    'New Game!',
                    style: TextStyle(fontSize: 24, color: Color.fromARGB(255, 201, 171, 0)),
                  ),
                )),
          ],
        ),
      ),
    );
  }
}
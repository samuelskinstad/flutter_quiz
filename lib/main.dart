import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:quiz_final/questions.dart';

import 'game_view.dart';

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
    return MaterialApp(
      title: 'Flutter Demo',
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage();

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('TRIVIA'),
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          children: [
            Container(
              child: Text('Trivia App av SamuelSkinstad'),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                height: MediaQuery.of(context).size.height / 2,
                width: MediaQuery.of(context).size.width / 1.2,
                color: Colors.white24,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Image.asset('assets/images/trivia.png'),
                ),
              ),
            ),
            Container(
              height: MediaQuery.of(context).size.height / 8,
            ),
            TextButton(
                style: ButtonStyle(
                  elevation: MaterialStateProperty.all(1),
                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                    RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(18),
                        side: const BorderSide(color: Colors.amber)),
                  ),
                ),
                onPressed: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => GameView(),
                    ),
                  );
                },
                child: const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text(
                    'New Game!',
                    style: TextStyle(fontSize: 24),
                  ),
                )),
          ],
        ),
      ),
    );
  }
}
import 'package:deaf_app/Login/login.dart';
import 'package:deaf_app/Screen/Screen1.dart';
import 'package:deaf_app/quizType/quizType1.dart';
import 'package:deaf_app/quizType/quizType2.dart';
import 'package:deaf_app/quizType/quizType3.dart';
import 'package:deaf_app/quizType/quizType4.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Deaf APP',
      theme: ThemeData(),
      home: Screen1(),
    );
  }
}

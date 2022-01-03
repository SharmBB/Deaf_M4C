import 'package:deaf_app/Login/login.dart';
import 'package:deaf_app/Screen/Screen1.dart';
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
      home: LoginPage(),
    );
  }
}

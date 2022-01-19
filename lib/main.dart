import 'package:assistive_app/Login/login.dart';
import 'package:assistive_app/Screen/Screen1.dart';
import 'package:assistive_app/Subject/subject.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'assistive APP',
      theme: ThemeData(),
      home: CheckAuth(),
    );
  }
}

class CheckAuth extends StatefulWidget {
  @override
  _CheckAuthState createState() => _CheckAuthState();
}

class _CheckAuthState extends State<CheckAuth> {
  bool isAuth = false;
  @override
  void initState() {
    _checkIfLoggedIn();
    super.initState();
  }

  void _checkIfLoggedIn() async {
    SharedPreferences localStorage = await SharedPreferences.getInstance();
    var token = localStorage.getString('userName');
    var userId = localStorage.getInt('userId');

    if (token != null) {
      setState(() {
        isAuth = true;
        print(localStorage.getString('userName'));
        print(localStorage.getInt('userId'));
        print(userId);
        print("Successfuly loggedin");
      });
    } else {
      print(localStorage.getString('token'));
      print("Successfuly loggedin");
    }
  }

  @override
  Widget build(BuildContext context) {
    Widget child;
    if (isAuth) {
      child = SubjectPage();
    } else {
      child = LoginPage();
    }
    return Scaffold(
      body: child,
    );
  }
}

import 'package:assistive_app/Login/login.dart';
import 'package:assistive_app/Subject/subject.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';

int? loggedIn;
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
  WidgetsFlutterBinding.ensureInitialized();
  SharedPreferences localStorage = await SharedPreferences.getInstance();

  loggedIn = await localStorage.getInt('userId');

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Assistive APP',
        theme: ThemeData(),
        initialRoute:
            loggedIn == 0 || loggedIn == null ? 'Login' : 'SubjectPage',
        routes: {
          'Login': (context) => LoginPage(),
          'SubjectPage': (context) => SubjectPage(),
        });
  }
}

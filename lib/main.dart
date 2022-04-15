import 'dart:io';

import 'package:assistive_app/Login/login.dart';
import 'package:assistive_app/Subject/subject.dart';
import 'package:assistive_app/questionLock/QuestionLock.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';

int? loggedIn;
int? id;
int? level;
int? subid;
int? initScreen;
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
  WidgetsFlutterBinding.ensureInitialized();
  SharedPreferences localStorage = await SharedPreferences.getInstance();

  loggedIn = await localStorage.getInt('userId');
  id = await localStorage.getInt('gradeid');
  level = await localStorage.getInt('level');
  subid = await localStorage.getInt('subjectId');
  initScreen = await localStorage.getInt('initScreen');
  HttpOverrides.global = MyHttpOverrides();
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
          //    'SubjectPage': (context) => SubjectPage(),
          'SubjectPage': (context) => QuestionLockPage(
                gradeid: id!,
                level: level!,
                subjectId: subid!,
              ),
        });
  }
}

class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
  }
}

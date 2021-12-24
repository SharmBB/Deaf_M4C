import 'dart:convert';

import 'package:deaf_app/api/api.dart';
import 'package:deaf_app/quizType/quizType1.dart';
import 'package:deaf_app/quizType/quizType2.dart';
import 'package:deaf_app/quizType/quizType3.dart';
import 'package:deaf_app/quizType/quizType4.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';

class Quiz1Page extends StatefulWidget {
  Quiz1Page({Key? key, required this.title, required this.gradeid})
      : super(key: key);

  final String title;
  final int gradeid;

  @override
  _Quiz1PageState createState() => _Quiz1PageState();
}

class _Quiz1PageState extends State<Quiz1Page> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  late int gradeid;

  String? _question;

  //initialize list for add questions from API
  List<dynamic> _foundQuestions = [];
  List _QuestionsFromDB = [];

// loader
  bool _isLoading = false;

  @override
  void initState() {
    gradeid = widget.gradeid;
    print(gradeid);
    _apiGetQuestions();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;

    return Scaffold(
        key: _scaffoldKey,
        appBar: AppBar(
          leading: Padding(
              padding: const EdgeInsets.only(
                top: 20.0,
                left: 10,
              ),
              child: Row(mainAxisAlignment: MainAxisAlignment.start, children: [
                IconButton(
                  icon: Icon(Icons.arrow_back, color: Colors.black),
                  onPressed: () {
                    Navigator.pop(
                      context,
                    );
                  },
                ),
                Padding(
                    padding: const EdgeInsets.only(
                      top: 5.0,
                    ),
                    child: new Text('திரும்பி செல்',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 10.0,
                        ))),
              ])),
          leadingWidth: width * 1,
          titleSpacing: 0.00,
          actions: [
            Padding(
                padding: const EdgeInsets.only(
                  top: 30.0,
                  right: 10,
                ),
                child: new Text('நிக்கி.',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 16.0,
                    ))),
            Container(
                margin: const EdgeInsets.only(right: 30.0, top: 10.0),
                child: GestureDetector(
                  onTap: () {},
                  child: new SvgPicture.asset(
                    'assets/svg/Group 86.svg',
                    width: 50.0,
                    height: 50.0,
                    allowDrawingOutsideViewBox: true,
                  ),
                )),
          ],
          backgroundColor: Colors.transparent,
          elevation: 0,
        ),
        body: Stack(children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(
              left: 30,
              right: 20.0,
              top: 20,
            ),
            child: Visibility(
              visible: _question == null ? true : false,
              child: Text(
                'நிலை 1',
                style: GoogleFonts.muktaMalar(
                  fontSize: 20,
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          !_isLoading
              ? _QuestionsFromDB[0].length == 0
                  ? Padding(
                      padding: const EdgeInsets.only(top: 20),
                      child: Text("No Questions available"),
                    )
                  : Expanded(
                      child: Padding(
                          padding: const EdgeInsets.only(top: 80.0),
                          //list

                          child: ListView.builder(
                              shrinkWrap: true,
                              itemCount: _foundQuestions.length,
                              //   itemBuilder: (context, index_Q) {
                              itemBuilder: (context, index) {
                                return new Card(
                                  elevation: 2,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(5.0),
                                  ),
                                  child: ListTile(
                                    onTap: () {
                                      setState(() {
                                        if (_foundQuestions[index]["type_id"] ==
                                            1) {
                                          setState(() {
                                            Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      QuizType1()),
                                            );
                                          });
                                        } else if (_foundQuestions[index]
                                                ["type_id"] ==
                                            2) {
                                          setState(() {
                                            Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        QuizType2()));
                                          });
                                        } else if (_foundQuestions[index]
                                                ["type_id"] ==
                                            3) {
                                          setState(() {
                                            Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        QuizType3()));
                                          });
                                        } else if (_foundQuestions[index]
                                                ["type_id"] ==
                                            4) {
                                          setState(() {
                                            Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        QuizType4()));
                                          });
                                        }
                                      });
                                    },
                                    title: Text(
                                      _foundQuestions[index]['title'],
                                      textAlign: TextAlign.center,
                                    ),
                                  ),
                                );
                              })))
              : Padding(
                  padding: const EdgeInsets.only(top: 100.0, left: 180),
                  child: CupertinoActivityIndicator(),
                )
        ]));
  }

//get questions from grade ID details from api
  void _apiGetQuestions() async {
    setState(() {
      _isLoading = true;
    });
    try {
      _QuestionsFromDB.clear();
      var bodyRoutes;
      var res = await CallApi()
          .getQuestionsByGradeId('questionsByGradeId/${widget.gradeid}/1');
      bodyRoutes = json.decode(res.body);

      // Add Questions to _QuestionsFromDB List
      _QuestionsFromDB.add(bodyRoutes);
      _foundQuestions = _QuestionsFromDB[0];
      print(_foundQuestions);
    } catch (e) {
      print(e);
    }
    setState(() {
      _isLoading = false;
    });
  }
}

import 'dart:convert';
import 'package:deaf_app/api/api.dart';
import 'package:deaf_app/components/appbar.dart';
import 'package:deaf_app/quizType/quizType1.dart';
import 'package:deaf_app/quizType/quizType2.dart';
import 'package:deaf_app/quizType/quizType3.dart';
import 'package:deaf_app/quizType/quizType4.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';

class Quiz1Page extends StatefulWidget {
  Quiz1Page({Key? key, required this.title, required this.gradeid, required this.level})
      : super(key: key);

  final String title;
  final int gradeid;
  final int level;

  @override
  _Quiz1PageState createState() => _Quiz1PageState();
}

class _Quiz1PageState extends State<Quiz1Page> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  late int gradeid;
  String? _question;

  //initialize list for add questions from API
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
        appBar: BaseAppBar(
        bacKText: "திரும்பி செல்",
        username: 'நிக்கி',
        appBar: AppBar(),
      ),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(
                  left: 30, right: 20.0, top: 20, bottom: 20),
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
                ? _QuestionsFromDB.length == 0
                    ? Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Align(child: Text("No Questions available")),
                      )
                    : Expanded(
                        child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 20),
                            //list

                            child: ListView.builder(
                                shrinkWrap: true,
                                itemCount: _QuestionsFromDB[0].length,
                                //   itemBuilder: (context, index_Q) {
                                itemBuilder: (context, index) {
                                  return new Card(
                                    elevation: 0,
                                    shape: RoundedRectangleBorder(
                                      side: BorderSide(
                                        color: Colors.black12,
                                        width: 1.0,
                                      ),
                                      borderRadius: BorderRadius.circular(5.0),
                                    ),
                                    child: ListTile(
                                      onTap: () {
                                        print("Question type");
                                        print(
                                            _QuestionsFromDB[0][index]["type_id"]);
                                        setState(() {
                                          if (_QuestionsFromDB[0][index]
                                                  ["type_id"] ==
                                              1) {
                                            setState(() {
                                              Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        QuizType1(
                                                            image:
                                                                _QuestionsFromDB[0][
                                                                        index]
                                                                    ['image'],
                                                            questionId:
                                                                _QuestionsFromDB[0][
                                                                        index]
                                                                    ['id'])),
                                              );
                                            });
                                          } else if (_QuestionsFromDB[0][index]
                                                  ["type_id"] ==
                                              2) {
                                            setState(() {
                                              Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        QuizType2(
                                                            title:
                                                                _QuestionsFromDB[0][
                                                                        index]
                                                                    ['title'],
                                                            questionId:
                                                                _QuestionsFromDB[0][
                                                                        index]
                                                                    ['id'])),
                                              );
                                            });
                                          } else if (_QuestionsFromDB[0][index]
                                                  ["type_id"] ==
                                              3) {
                                            print(_QuestionsFromDB[0][index]);
                                            setState(() {
                                              Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                  builder: (context) =>
                                                      QuizType3(
                                                    questionId:
                                                        _QuestionsFromDB[0][index]
                                                            ['id'],
                                                    title:
                                                        _QuestionsFromDB[0][index]
                                                            ['title'],
                                                    image:
                                                        _QuestionsFromDB[0][index]
                                                            ['image'],
                                                  ),
                                                ),
                                              );
                                            });
                                          } else if (_QuestionsFromDB[0][index]
                                                  ["type_id"] ==
                                              4) {
                                            setState(() {
                                              Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                      builder: (context) =>
                                                          QuizType4(questionId: _QuestionsFromDB[0][index]['id'], 
                                                          title: _QuestionsFromDB[0][index]['title'])));
                                            });
                                          }
                                        });
                                      },
                                      title: Text(
                                        _QuestionsFromDB[0][index]['title'],
                                        // textAlign: TextAlign.center,
                                      ),
                                    ),
                                  );
                                })))
                : Padding(
                    padding: const EdgeInsets.only(top: 100.0, left: 180),
                    child: CupertinoActivityIndicator(),
                  ),
          ],
        ));
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
          .getQuestionsByGradeId('questionsByGradeId/${widget.gradeid}/${widget.level}');
      bodyRoutes = json.decode(res.body);

      // Add Questions to _QuestionsFromDB List
      print(bodyRoutes);
      if(bodyRoutes['errorMessage'] == true){
        _QuestionsFromDB.add(bodyRoutes['data']);
      }
    } catch (e) {
      print(e);
    }
    setState(() {
      _isLoading = false;
    });
  }
}

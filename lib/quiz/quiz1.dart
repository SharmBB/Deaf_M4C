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
        appBar: BaseAppBar(
        bacKText: "திரும்பி செல்",
        username: 'நிக்கி',
        appBar: AppBar(),
      ),
        body: Column(
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
                ? _QuestionsFromDB[0].length == 0
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
                                itemCount: _foundQuestions.length,
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
                                            _foundQuestions[index]["type_id"]);
                                        setState(() {
                                          if (_foundQuestions[index]
                                                  ["type_id"] ==
                                              1) {
                                            setState(() {
                                              Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        QuizType1(
                                                            image:
                                                                _foundQuestions[
                                                                        index]
                                                                    ['image'],
                                                            questionId:
                                                                _foundQuestions[
                                                                        index]
                                                                    ['id'])),
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
                                                        QuizType2(
                                                            title:
                                                                _foundQuestions[
                                                                        index]
                                                                    ['title'],
                                                            questionId:
                                                                _foundQuestions[
                                                                        index]
                                                                    ['id'])),
                                              );
                                            });
                                          } else if (_foundQuestions[index]
                                                  ["type_id"] ==
                                              3) {
                                            print(_foundQuestions[index]);
                                            setState(() {
                                              Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                  builder: (context) =>
                                                      QuizType3(
                                                    questionId:
                                                        _foundQuestions[index]
                                                            ['id'],
                                                    title:
                                                        _foundQuestions[index]
                                                            ['title'],
                                                    image:
                                                        _foundQuestions[index]
                                                            ['image'],
                                                  ),
                                                ),
                                              );
                                            });
                                          } else if (_foundQuestions[index]
                                                  ["type_id"] ==
                                              4) {
                                            setState(() {
                                              Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                      builder: (context) =>
                                                          QuizType4(questionId: _foundQuestions[index]['id'], 
                                                          title: _foundQuestions[index]['title'])));
                                            });
                                          }
                                        });
                                      },
                                      title: Text(
                                        _foundQuestions[index]['title'],
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

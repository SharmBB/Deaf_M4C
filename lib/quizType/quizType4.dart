import 'dart:convert';

import 'package:deaf_app/api/api.dart';
import 'package:deaf_app/components/Breadcrumps.dart';
import 'package:deaf_app/components/CorrectOrWrongCheck.dart';
import 'package:deaf_app/components/SubmitBtn.dart';
import 'package:deaf_app/components/appbar.dart';
import 'package:deaf_app/constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';

class QuizType4 extends StatefulWidget {
  final int questionId;
  final String title;
  QuizType4({key, required this.questionId, required this.title})
      : super(key: key);

  @override
  _Quiz1PageState createState() => _Quiz1PageState();
}

class _Quiz1PageState extends State<QuizType4> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  late int gradeid;

  double _persentage = 0;
  int _total = 0;
  List<String> StringQues = [];

  String? _answerQNo;

  String? _answer;
  String? _correctanswer;
  String? _question;
  bool _hasBeenPressed = false;
  String? _hasBeenPressedValue;

  bool _isLoading = false;
  int isAnswer = 0;
  bool isAnswerCheck = false;
  int? userSelectedAnswer;
  List answersFromDB = [];

  @override
  void initState() {
    _apiGetAnswers();
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
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 30, horizontal: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Breadcrumbs(
                title: 'நிலை 3 > கேள்வி 1',
              ),
              SizedBox(height: 40),
              Text(
                widget.title,
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              _isLoading
                  ? Padding(
                      padding: const EdgeInsets.only(top: 20.0),
                      child: Center(child: CupertinoActivityIndicator()),
                    )
                  : Padding(
                      padding: EdgeInsets.symmetric(vertical: 10),
                      child: ListView.builder(
                        physics: const NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        itemCount: answersFromDB[0].length,
                        itemBuilder: (context, index_Q1) {
                          return GestureDetector(
                            onTap: () {
                              setState(() {
                                isAnswer =
                                    answersFromDB[0][index_Q1]['is_answer'];
                              });
                              userSelectedAnswer = index_Q1;
                            },
                            child: Card(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(5.0),
                                side: BorderSide(
                                    color: userSelectedAnswer == index_Q1
                                        ? Colors.yellow
                                        : Colors.white,
                                    width: 2),
                              ),
                              child: Stack(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 10, horizontal: 10),
                                    child: Row(
                                      children: [
                                        ClipOval(
                                          child: Container(
                                            height: 30,
                                            width: 30,
                                            color: kPrimaryRedColor,
                                            child: Align(
                                              alignment: Alignment.center,
                                              child: Text(
                                                "${index_Q1 + 1}",
                                                style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 20.0,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                        Padding(
                                          padding:
                                              const EdgeInsets.only(left: 12.0),
                                          child: Container(
                                            width: MediaQuery.of(context).size.width * 0.7,
                                            child: Text(
                                              answersFromDB[0][index_Q1]
                                                  ['title'],
                                              style: GoogleFonts.muktaMalar(
                                                fontSize: 20,
                                                color: Colors.black,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Visibility(
                                      visible: userSelectedAnswer == index_Q1,
                                      child: CorrectOrWrong(
                                            isAnswerCheck: isAnswerCheck,
                                            correctAnswer: answersFromDB[0]
                                                [index_Q1]['is_answer'],
                                            questionType: 2,
                                          ),
                                    )
                                ],
                              ),
                            ),
                          );
                        },
                      ),
                    ),
              Visibility(
                visible: !_isLoading,
                child: SubmitBtn(
                  function: () {
                    if (userSelectedAnswer != null) {
                      setState(() {
                        isAnswerCheck = true;
                      });
                    }
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _apiGetAnswers() async {
    setState(() {
      _isLoading = true;
    });
    try {
      answersFromDB.clear();
      var bodyRoutes;
      var res = await CallApi()
          .getAnswerByQuestionId('getAnswersByQuestionId/${widget.questionId}');
      bodyRoutes = json.decode(res.body);

      // Add Answers to _AnswersFromDB List
      answersFromDB.add(bodyRoutes);
      // _foundAnswers = _AnswersFromDB[0];
      // print(answersFromDB[0]);
    } catch (e) {
      print(e);
    }
    setState(() {
      _isLoading = false;
    });
  }
}

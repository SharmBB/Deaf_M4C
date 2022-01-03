import 'dart:convert';

import 'package:deaf_app/_helper/controller.dart';
import 'package:deaf_app/api/api.dart';
import 'package:deaf_app/components/Breadcrumps.dart';
import 'package:deaf_app/components/CorrectOrWrongCheck.dart';
import 'package:deaf_app/components/SubmitBtn.dart';
import 'package:deaf_app/components/appbar.dart';
import 'package:deaf_app/constants.dart';
import 'package:deaf_app/quizSucces/StageFail.dart';
import 'package:deaf_app/quizSucces/StageSuccess.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';

class QuizType4 extends StatefulWidget {
  final int questionId;
  final String title;
  final String gradeLevelQuestionID;
  final int questionLength;
  final int questionIndex;
  final int gradeid;
  final int level;
  QuizType4({key, required this.questionId, required this.title, required this.gradeLevelQuestionID, required this.questionLength, required this.gradeid, required this.level, required this.questionIndex})
      : super(key: key);

  @override
  _Quiz1PageState createState() => _Quiz1PageState();
}

class _Quiz1PageState extends State<QuizType4> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  MarksServices marksServices = MarksServices();
  
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
        appBar: AppBar(),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 30, horizontal: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Breadcrumbs(
                title: 'நிலை ${widget.level} > கேள்வி ${widget.questionIndex+1}',
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
                        itemBuilder: (context, index) {
                          return GestureDetector(
                            onTap: isAnswerCheck
                            ? () {}
                            : () {
                              setState(() {
                                isAnswer =
                                    answersFromDB[0][index]['is_answer'];
                              });
                              userSelectedAnswer = index;
                            },
                            child: Card(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(5.0),
                                side: BorderSide(
                                    color: userSelectedAnswer == index
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
                                                "${index + 1}",
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
                                              answersFromDB[0][index]
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
                                      visible: userSelectedAnswer == index,
                                      child: CorrectOrWrong(
                                            isAnswerCheck: isAnswerCheck,
                                            correctAnswer: answersFromDB[0]
                                                [index]['is_answer'],
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
                  function: () async{
                    if (userSelectedAnswer != null) {
                    setState(() {
                      print("finalResult");
                      isAnswerCheck = true;
                      marksServices.addResults(widget.gradeLevelQuestionID, widget.questionId, isAnswer);
                    });

                    var resultList = await marksServices.getResultList();
                    var finalResult =
                        await marksServices.findAverage(widget.questionLength);
                        
                    if(widget.questionLength == resultList.length){
                      print(finalResult);
                      double successPercent = await marksServices.findAverage(widget.questionLength);
                      int correctAnswers = await marksServices.getCorrectAnswers();

                      if(successPercent > 50){
                          marksServices.apiUpdateResult(widget.gradeid, finalResult, widget.level);
                          // navigate to success or fail page
                          double successPercent = await marksServices.findAverage(widget.questionLength);
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => StageSuccess(correctAnswers: correctAnswers, totalQuestions: widget.questionLength, successPercent: successPercent,),
                            ),
                          );
                      } else {
                         Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => StageFail(correctAnswers: correctAnswers, totalQuestion: widget.questionLength, successPercent: successPercent),
                            ),
                          );
                      }
                    }
                    
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

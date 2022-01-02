import 'dart:convert';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:deaf_app/_helper/controller.dart';
import 'package:deaf_app/api/api.dart';
import 'package:deaf_app/components/Breadcrumps.dart';
import 'package:deaf_app/components/CorrectOrWrongCheck.dart';
import 'package:deaf_app/components/SubmitBtn.dart';
import 'package:deaf_app/components/appbar.dart';
import 'package:deaf_app/constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';

class QuizType3 extends StatefulWidget {
  final int questionId;
  final String title;
  final String image;
  final String gradeLevelQuestionID;
  final int questionLength;
  final int gradeid;
  final int level;
  QuizType3(
      {key, required this.questionId, required this.title, required this.image, required this.gradeLevelQuestionID, required this.questionLength, required this.gradeid, required this.level})
      : super(key: key);

  @override
  _Quiz1PageState createState() => _Quiz1PageState();
}

class _Quiz1PageState extends State<QuizType3> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  MarksServices marksServices = MarksServices();
  
  late int gradeid;
  late int questionId;
  late String title;
  var image = "https://deafapi.moodfor.codes/images/";

  double _persentage = 0;
  int _total = 0;
  List<String> StringQues = [];

  String? _answerQNo;

  String? _answer;
  String? _correctanswer;
  String? _question = "1";
  bool _hasBeenPressed = false;
  String? _hasBeenPressedValue;

  //initialize list  for add questions from API
  List<dynamic> _foundQuestions = [];
  List _QuestionsFromDB = [];

// loader
  bool _isLoading = false;
  int isAnswer = 0;
  bool isAnswerCheck = false;
  int? userSelectedAnswer;
  List answersFromDB = [];

  @override
  void initState() {
    _apiGetAnswers();
    questionId = widget.questionId;
    title = widget.title;
    print(questionId);
    print(title);
    print(image);
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
            padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 10),
                  child: Breadcrumbs(
                    title: 'நிலை 3 > கேள்வி 1',
                  ),
                ),
                // Padding(
                //   padding: const EdgeInsets.symmetric(vertical: 10),
                //   child: Row(
                //     mainAxisAlignment: MainAxisAlignment.spaceAround,
                //     children: [
                //       NextBeforeBtn(text: 'முந்திய', function: (){}),
                //       NextBeforeBtn(text: 'அடுத்து', function: (){})
                //     ],
                //   ),
                // ),
                CachedNetworkImage(
                    height: 300,
                    // width: 160,
                    imageUrl: image + widget.image,
                    imageBuilder: (context, imageProvider) => Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5),
                            image: DecorationImage(
                                image: imageProvider, fit: BoxFit.cover),
                          ),
                        ),
                    errorWidget: (context, url, error) => Icon(Icons.error)),
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
                                            padding: const EdgeInsets.only(
                                                left: 12.0),
                                            child: Container(
                                              width: MediaQuery.of(context)
                                                      .size
                                                      .width *
                                                  0.7,
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
                                    userSelectedAnswer == index
                                        ? CorrectOrWrong(
                                            isAnswerCheck: isAnswerCheck,
                                            correctAnswer: answersFromDB[0]
                                                [index]['is_answer'],
                                            questionType: 2,
                                          )
                                        : SizedBox()
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
                          isAnswerCheck = true;
                          marksServices.addResults(widget.gradeLevelQuestionID, widget.questionId, isAnswer);
                        });
                        var resultList = await marksServices.getResultList();
                        var finalResult = await marksServices.findAverage(widget.questionLength);
                        if(widget.questionLength == resultList.length){
                          print(finalResult);
                          marksServices.apiUpdateResult(widget.gradeid, finalResult, widget.level);
                        }
                      }
                    },
                  ),
                ),
              ],
            )),
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
      print(answersFromDB[0]);
    } catch (e) {
      print(e);
    }
    setState(() {
      _isLoading = false;
    });
  }
  
}

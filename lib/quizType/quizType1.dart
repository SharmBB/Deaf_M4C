import 'dart:convert';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:deaf_app/_helper/controller.dart';
import 'package:deaf_app/api/api.dart';
import 'package:deaf_app/components/Breadcrumps.dart';
import 'package:deaf_app/components/CorrectOrWrongCheck.dart';
import 'package:deaf_app/components/SubmitBtn.dart';
import 'package:deaf_app/components/appbar.dart';
import 'package:deaf_app/quizSucces/StageSuccess.dart';
import 'package:deaf_app/quizSucces/Stagefail.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:shared_preferences/shared_preferences.dart';

class QuizType1 extends StatefulWidget {
  final int questionId;
  final String image;
  final String gradeLevelQuestionID;
  final int questionLength;
  final int questionIndex;
  final int gradeid;
  final int level;
  QuizType1(
      {key,
      required this.questionId,
      required this.image,
      required this.gradeLevelQuestionID,
      required this.questionLength,
      required this.gradeid,
      required this.level, required this.questionIndex})
      : super(key: key);

  @override
  _Quiz1PageState createState() => _Quiz1PageState();
}

class _Quiz1PageState extends State<QuizType1> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  MarksServices marksServices = MarksServices();
  late int gradeid;
  late int questionId;
  late String image;

  List<String> StringQues = [];

  //initialize list  for add questions from API
  // List<dynamic> _foundAnswers = [];
  List _AnswersFromDB = [];

// loader
  bool _isLoading = false;
  var ans;

  var _answer = null;
  int isAnswer = 0;
  bool isAnswerCheck = false;
  int? userSelectedAnswer;

  @override
  void initState() {
    questionId = widget.questionId;
    print(questionId);
    image = widget.image;
    print("widget.gradeLevelQuestionID");
    print("${widget.gradeLevelQuestionID}-${widget.questionId}");
    _apiGetAnswers();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var image = "https://deafapi.moodfor.codes/images/";
    var width = MediaQuery.of(context).size.width;

    return Scaffold(
      key: _scaffoldKey,
      appBar: BaseAppBar(
        bacKText: "திரும்பி செல்",
        appBar: AppBar(),
      ),
      body: SingleChildScrollView(
          child: Padding(
        padding:
            const EdgeInsets.only(left: 20, right: 20, top: 10, bottom: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.symmetric(vertical: 10),
              child: Breadcrumbs(
                title: 'நிலை ${widget.level} > கேள்வி ${widget.questionIndex+1}',
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
                  image:
                      DecorationImage(image: imageProvider, fit: BoxFit.cover),
                ),
              ),
              errorWidget: (context, url, error) => Icon(Icons.error),
            ),
            SizedBox(
              height: 15,
            ),
            _isLoading
                ? Center(
                    child: Padding(
                    padding: const EdgeInsets.all(18.0),
                    child: CupertinoActivityIndicator(),
                  ))
                : GridView.builder(
                    shrinkWrap: true,

                    /// physics:
                    //   const NeverScrollableScrollPhysics(),
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      // childAspectRatio: 9/10,
                      mainAxisSpacing: 5.0,
                      // crossAxisSpacing: 25.0
                    ),
                    itemCount: _AnswersFromDB[0].length,
                    itemBuilder: (context, index) {
                      return GestureDetector(
                        onTap: isAnswerCheck
                            ? () {}
                            : () {
                                setState(() {
                                  isAnswer =
                                      _AnswersFromDB[0][index]['is_answer'];
                                });
                                userSelectedAnswer = index;
                              },
                        child: Card(
                          color: userSelectedAnswer == index
                              ? Colors.yellow
                              : null,
                          elevation: 0,
                          child: Stack(
                            children: <Widget>[
                              Padding(
                                padding: const EdgeInsets.all(5.0),
                                child: CachedNetworkImage(
                                    // height: 150,
                                    // width: 160,
                                    imageUrl: image +
                                        _AnswersFromDB[0][index]['image'],
                                    imageBuilder: (context, imageProvider) =>
                                        Container(
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(5),
                                            image: DecorationImage(
                                                image: imageProvider,
                                                fit: BoxFit.cover),
                                          ),
                                        ),
                                    errorWidget: (context, url, error) =>
                                        Icon(Icons.error)),
                              ),
                              userSelectedAnswer == index
                                  ? CorrectOrWrong(
                                      isAnswerCheck: isAnswerCheck,
                                      correctAnswer: _AnswersFromDB[0][index]
                                          ['is_answer'],
                                    )
                                  : SizedBox()
                            ],
                          ),
                        ),
                      );
                    }),
            Visibility(
              visible: !_isLoading,
              child: SubmitBtn(
                function: () async {    
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
      )),
    );
  }

  //get answer from question ID details from api
  void _apiGetAnswers() async {
    setState(() {
      _isLoading = true;
    });
    try {
      _AnswersFromDB.clear();
      var bodyRoutes;
      var res = await CallApi()
          .getAnswerByQuestionId('getAnswersByQuestionId/${widget.questionId}');
      bodyRoutes = json.decode(res.body);
      print(bodyRoutes);
      // Add Answers to _AnswersFromDB List
      _AnswersFromDB.add(bodyRoutes);
      // print(_foundAnswers);
    } catch (e) {
      print(e);
    }
    setState(() {
      _isLoading = false;
    });
  }
}

import 'dart:convert';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:deaf_app/_helper/controller.dart';
import 'package:deaf_app/api/api.dart';
import 'package:deaf_app/components/Breadcrumps.dart';
import 'package:deaf_app/components/CorrectOrWrongCheck.dart';
import 'package:deaf_app/components/NextBeforeBtn.dart';
import 'package:deaf_app/components/SubmitBtn.dart';
import 'package:deaf_app/components/appbar.dart';
import 'package:deaf_app/quizSucces/StageFail.dart';
import 'package:deaf_app/quizSucces/StageSuccess.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';

class QuizType2 extends StatefulWidget {
  final int questionId;
  final String title;
  final String gradeLevelQuestionID;
  final int questionLength;
  final int questionIndex;
  final int gradeid;
  final int level;
  QuizType2({key, required this.questionId, required this.title, required this.gradeLevelQuestionID, required this.questionLength, required this.gradeid, required this.level, required this.questionIndex})
      : super(key: key);

  @override
  _Quiz1PageState createState() => _Quiz1PageState();
}

class _Quiz1PageState extends State<QuizType2> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  MarksServices marksServices = MarksServices();
  late int gradeid;
  late int questionId;
  late String title;

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
  List<dynamic> _foundAnswers = [];
  List _AnswersFromDB = [];

// loader
  bool _isLoading = false;
  int isAnswer = 0;
  bool isAnswerCheck = false;
  int? userSelectedAnswer;

  @override
  void initState() {
    _apiGetAnswers();
    questionId = widget.questionId;
    print(questionId);
    title = widget.title;
    print(title);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var image = "https://deafapi.moodfor.codes/images/";

    return Scaffold(
      key: _scaffoldKey,
      appBar: BaseAppBar(
        bacKText: "திரும்பி செல்",
        appBar: AppBar(),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
              padding:  EdgeInsets.symmetric(vertical: 10),
              child: Breadcrumbs(title: 'நிலை ${widget.level} > கேள்வி ${widget.questionIndex+1}',),
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
            SizedBox(
                height: 5,
              ),
              Padding(
                padding: const EdgeInsets.only(
                  left: 10,
                ),
                child: Text(
                  widget.title,
                  style: GoogleFonts.muktaMalar(
                    fontSize: 24,
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              _isLoading ? Center(
                    child: Padding(
                    padding: const EdgeInsets.all(18.0),
                    child: CupertinoActivityIndicator(),
                  )) : GridView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      mainAxisSpacing: 5.0,
                      crossAxisSpacing: 5.0),
                  itemCount: _AnswersFromDB[0].length,
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      onTap: isAnswerCheck
                            ? () {}
                            : () {
                        setState(() {
                          isAnswer = _AnswersFromDB[0][index]['is_answer'];
                        });
                        userSelectedAnswer = index;
                      },
                      child: Card(
                        color: userSelectedAnswer == index
                            ? Colors.yellow
                            : null,
                        elevation: 0,
                        child: Stack(children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.all(5.0),
                            child: CachedNetworkImage(
                                imageUrl:
                                    image + _AnswersFromDB[0][index]['image'],
                                imageBuilder: (context, imageProvider) =>
                                    Container(
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(5),
                                        image: DecorationImage(
                                            image: imageProvider,
                                            fit: BoxFit.cover),
                                      ),
                                    ),
                                errorWidget: (context, url, error) =>
                                    Icon(Icons.error)),
                          ),
                          userSelectedAnswer == index
                              ? CorrectOrWrong(isAnswerCheck: isAnswerCheck, correctAnswer: _AnswersFromDB[0][index]['is_answer'],)
                              : SizedBox()
                        ]),
                      ),
                    );
                  }),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  NextBeforeBtn(text: 'முந்திய', function: () {}),
                  NextBeforeBtn(text: 'அடுத்து', function: () {})
                ],
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
      _AnswersFromDB.clear();
      var bodyRoutes;
      var res = await CallApi()
          .getAnswerByQuestionId('getAnswersByQuestionId/${widget.questionId}');
      bodyRoutes = json.decode(res.body);

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

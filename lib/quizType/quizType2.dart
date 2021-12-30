import 'dart:convert';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:deaf_app/api/api.dart';
import 'package:deaf_app/components/Breadcrumps.dart';
import 'package:deaf_app/components/CorrectOrWrongCheck.dart';
import 'package:deaf_app/components/SubmitBtn.dart';
import 'package:deaf_app/components/appbar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';

class QuizType2 extends StatefulWidget {
  final int questionId;
  final String title;
  QuizType2({key, required this.questionId, required this.title})
      : super(key: key);

  @override
  _Quiz1PageState createState() => _Quiz1PageState();
}

class _Quiz1PageState extends State<QuizType2> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

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
              padding:  EdgeInsets.symmetric(vertical: 10),
              child: Breadcrumbs(title: 'நிலை 1 > கேள்வி 1',),
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
                  itemBuilder: (BuildContext ctx, index_A) {
                    return GestureDetector(
                      onTap: () {
                        setState(() {
                          isAnswer = _AnswersFromDB[0][index_A]['is_answer'];
                        });
                        userSelectedAnswer = index_A;
                      },
                      child: Card(
                        color: userSelectedAnswer == index_A
                            ? Colors.yellow
                            : null,
                        elevation: 0,
                        child: Stack(children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.all(5.0),
                            child: CachedNetworkImage(
                                imageUrl:
                                    image + _AnswersFromDB[0][index_A]['image'],
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
                          userSelectedAnswer == index_A
                              ? CorrectOrWrong(isAnswerCheck: isAnswerCheck, correctAnswer: _AnswersFromDB[0][index_A]['is_answer'],)
                              : SizedBox()
                        ]),
                      ),
                    );
                  }),
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

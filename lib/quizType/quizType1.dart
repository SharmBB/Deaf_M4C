import 'dart:convert';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:deaf_app/api/api.dart';
import 'package:deaf_app/components/Breadcrumps.dart';
import 'package:deaf_app/components/SubmitBtn.dart';
import 'package:deaf_app/components/appbar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class QuizType1 extends StatefulWidget {
  final int questionId;
  final String image;
  QuizType1({key, required this.questionId, required this.image})
      : super(key: key);

  @override
  _Quiz1PageState createState() => _Quiz1PageState();
}

class _Quiz1PageState extends State<QuizType1> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

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
    print(image);
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
        username: 'நிக்கி',
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
                title: 'நிலை 1 > கேள்வி 1',
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
                          child: Stack(
                            children: <Widget>[
                              Padding(
                                padding: const EdgeInsets.all(5.0),
                                child: CachedNetworkImage(
                                    // height: 150,
                                    // width: 160,
                                    imageUrl: image +
                                        _AnswersFromDB[0][index_A]['image'],
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
                              userSelectedAnswer == index_A
                                  ? Visibility(
                                      visible: isAnswerCheck,
                                      child: Padding(
                                        padding: const EdgeInsets.all(5.0),
                                        child: Image(
                                                image: AssetImage(
                                                    _AnswersFromDB[0][index_A]['is_answer'] == 1 ?'assets/static/correct.png' : 'assets/static/wrong.png'
                                                    ),
                                                fit: BoxFit.cover,
                                                alignment: Alignment.center,
                                              ),
                                      ),
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

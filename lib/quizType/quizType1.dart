import 'dart:convert';
import 'package:deaf_app/api/api.dart';
import 'package:deaf_app/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';

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
  List<dynamic> _foundAnswers = [];
  List _AnswersFromDB = [];

// loader
  bool _isLoading = false;
  var ans;

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
        body: SingleChildScrollView(
            child: Padding(
                padding: const EdgeInsets.only(
                  left: 20,
                  right: 20.0,
                  top: 20,
                ),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ListView.builder(
                          // physics: const NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          itemCount: 1,
                          itemBuilder: (context, index_Q) {
                            return Padding(
                                padding: const EdgeInsets.only(
                                  left: 20,
                                  bottom: 20,
                                ),
                                child: Row(
                                  children: [
                                    Text(
                                      'நிலை 1' + ' > ',
                                      style: GoogleFonts.muktaMalar(
                                        fontSize: 20,
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    Text(
                                      'கேள்வி 1',
                                      style: GoogleFonts.muktaMalar(
                                        fontSize: 20,
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ],
                                ));
                          }),
                      Padding(
                          padding: const EdgeInsets.only(
                            bottom: 30,
                            left: 20,
                            right: 20,
                          ),
                          child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                ConstrainedBox(
                                  constraints: BoxConstraints.tightFor(
                                      width: 130, height: 40),
                                  child: ElevatedButton(
                                    onPressed: () {},
                                    child: Text(
                                      'முந்திய',
                                      style: GoogleFonts.muktaMalar(
                                        color: Colors.white,
                                        fontSize: 18,
                                      ),
                                    ),
                                    style: ElevatedButton.styleFrom(
                                      primary: kPrimaryRedColor,
                                      elevation: 0,
                                      shape: RoundedRectangleBorder(
                                          borderRadius: new BorderRadius.all(
                                              new Radius.circular(20))),
                                    ),
                                  ),
                                ),
                                ConstrainedBox(
                                  constraints: BoxConstraints.tightFor(
                                      width: 130, height: 40),
                                  child: ElevatedButton(
                                    onPressed: () {},
                                    child: Text(
                                      'அடுத்து',
                                      style: GoogleFonts.muktaMalar(
                                        color: Colors.white,
                                        fontSize: 18,
                                      ),
                                    ),
                                    style: ElevatedButton.styleFrom(
                                      primary: kPrimaryRedColor,
                                      elevation: 0,
                                      shape: RoundedRectangleBorder(
                                          borderRadius: new BorderRadius.all(
                                              new Radius.circular(20))),
                                    ),
                                  ),
                                ),
                              ])),
                      Container(
                          child: ListView.builder(
                              //physics: const NeverScrollableScrollPhysics(),
                              shrinkWrap: true,
                              itemCount: 1,
                              itemBuilder: (context, index_Q1) {
                                return Padding(
                                    padding: const EdgeInsets.only(
                                        left: 20, right: 20),
                                    child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Container(
                                              height: 300,
                                              child: Stack(children: <Widget>[
                                                Container(
                                                    height: 300.0,
                                                    decoration: BoxDecoration(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(15),
                                                        image: DecorationImage(
                                                          image: NetworkImage(
                                                              image +
                                                                  widget.image),
                                                          fit: BoxFit.cover,
                                                        ))),
                                              ])),
                                          SizedBox(
                                            height: 15,
                                          ),
                                          GridView.builder(
                                              shrinkWrap: true,

                                              /// physics:
                                              //   const NeverScrollableScrollPhysics(),
                                              gridDelegate:
                                                  SliverGridDelegateWithMaxCrossAxisExtent(
                                                      maxCrossAxisExtent: 200,
                                                      childAspectRatio: 5 / 4,
                                                      crossAxisSpacing: 20,
                                                      mainAxisSpacing: 20),
                                              itemCount: _foundAnswers.length,
                                              itemBuilder:
                                                  (BuildContext ctx, index_A) {
                                                return GestureDetector(
                                                  onTap: () {},
                                                  child: Card(
                                                    child: Stack(
                                                        children: <Widget>[
                                                          Padding(
                                                              padding:
                                                                  const EdgeInsets
                                                                      .all(5),
                                                              child: Container(
                                                                height: 150,
                                                                width: 150,
                                                                alignment:
                                                                    Alignment
                                                                        .center,
                                                                decoration:
                                                                    BoxDecoration(
                                                                        image:
                                                                            DecorationImage(
                                                                          image:
                                                                              NetworkImage(image + _foundAnswers[index_A]['image']),
                                                                          fit: BoxFit
                                                                              .cover,
                                                                        ),
                                                                        borderRadius:
                                                                            BorderRadius.circular(15)),
                                                              )),
                                                        ]),
                                                  ),
                                                );
                                              }),
                                          buttonEnd(width)
                                        ]));
                              }))
                    ]))));
  }

  Visibility buttonEnd(double width) {
    return Visibility(
        // visible: _answer == null ? false : true,
        child: SafeArea(
            child: Align(
      alignment: Alignment.bottomCenter,
      child: ConstrainedBox(
        constraints: BoxConstraints.tightFor(width: width * 1, height: 60),
        child: ElevatedButton(
          onPressed: () {
            setState(() {});
          },
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('முடிக்கவும்',
                  style: GoogleFonts.muktaMalar(
                    fontSize: 24,
                    color: Colors.white,
                  )),
            ],
          ),
          style: ElevatedButton.styleFrom(
            primary: kPrimaryRedColor,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.only(
              topRight: Radius.circular(15),
              topLeft: Radius.circular(15),
            )),
          ),
        ),
      ),
    )));
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

      // Add Answers to _AnswersFromDB List
      _AnswersFromDB.add(bodyRoutes);
      _foundAnswers = _AnswersFromDB[0];
      print(_foundAnswers);
    } catch (e) {
      print(e);
    }
    setState(() {
      _isLoading = false;
    });
  }
}

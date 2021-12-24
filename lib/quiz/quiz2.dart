//unwanted

import 'package:deaf_app/constants.dart';
import 'package:deaf_app/questionLock/Lock.dart';
import 'package:deaf_app/quizSucces/Stage2.dart';
import 'package:deaf_app/quizSucces/Stagefail.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';

class Quiz2Page extends StatefulWidget {
  Quiz2Page({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  _Quiz2PageState createState() => _Quiz2PageState();
}

class _Quiz2PageState extends State<Quiz2Page> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  List quiz = [
    {
      "Question": {
        "Question_Name": 'பூட்டு',
        "QuestionNumber": '1',
        'img1': 'assets/png/k1.png',
        'Nilai': '2',
      },
      "Answers": [
        {
          'imgA': 'assets/gif/circle.gif',
          "AnswerNumber": "1",
          "Correct": "1",
          "Answer_QuestionNumber": '1'
        },
        {
          'imgA': 'assets/gif/rectangle.gif',
          "AnswerNumber": "2",
          "Correct": "1",
          "Answer_QuestionNumber": '1'
        },
        {
          'imgA': 'assets/gif/square.gif',
          "AnswerNumber": "3",
          "Correct": "1",
          "Answer_QuestionNumber": '1'
        },
        {
          'imgA': 'assets/gif/triangle.gif',
          "AnswerNumber": "4",
          "Correct": "1",
          "Answer_QuestionNumber": '1'
        }
      ]
    },
    {
      "Question": {
        "Question_Name": 'பூட்டு',
        "QuestionNumber": '2',
        'img1': 'assets/png/k2.png',
        'Nilai': '2',
      },
      "Answers": [
        {
          'imgA': 'assets/gif/circle.gif',
          "AnswerNumber": "1",
          "Correct": "1",
          "Answer_QuestionNumber": '2'
        },
        {
          'imgA': 'assets/gif/circle.gif',
          "AnswerNumber": "2",
          "Correct": "1",
          "Answer_QuestionNumber": '2'
        },
        {
          'imgA': 'assets/gif/circle.gif',
          "AnswerNumber": "3",
          "Correct": "1",
          "Answer_QuestionNumber": '2'
        },
        {
          'imgA': 'assets/gif/circle.gif',
          "AnswerNumber": "4",
          "Correct": "1",
          "Answer_QuestionNumber": '2'
        }
      ]
    },
    {
      "Question": {
        "Question_Name": 'பூட்டு',
        "QuestionNumber": '3',
        'img1': 'assets/png/k3.png',
        'Nilai': '2',
      },
      "Answers": [
        {
          'imgA': 'assets/gif/triangle.gif',
          "AnswerNumber": "1",
          "Correct": "1",
          "Answer_QuestionNumber": '3'
        },
        {
          'imgA': 'assets/gif/triangle.gif',
          "AnswerNumber": "2",
          "Correct": "1",
          "Answer_QuestionNumber": '3'
        },
        {
          'imgA': 'assets/gif/triangle.gif',
          "AnswerNumber": "3",
          "Correct": "1",
          "Answer_QuestionNumber": '3'
        },
        {
          'imgA': 'assets/gif/square.gif',
          "AnswerNumber": "4",
          "Correct": "1",
          "Answer_QuestionNumber": '3'
        }
      ]
    },
    {
      "Question": {
        "Question_Name": 'பூட்டு',
        "QuestionNumber": '4',
        'img1': 'assets/png/k4.png',
        'Nilai': '2',
      },
      "Answers": [
        {
          'imgA': 'assets/gif/square.gif',
          "AnswerNumber": "1",
          "Correct": "1",
          "Answer_QuestionNumber": '4'
        },
        {
          'imgA': 'assets/gif/square.gif',
          "AnswerNumber": "2",
          "Correct": "1",
          "Answer_QuestionNumber": '4'
        },
        {
          'imgA': 'assets/gif/circle.gif',
          "AnswerNumber": "3",
          "Correct": "1",
          "Answer_QuestionNumber": '4'
        },
        {
          'imgA': 'assets/gif/triangle.gif',
          "AnswerNumber": "4",
          "Correct": "1",
          "Answer_QuestionNumber": '4'
        }
      ]
    },
  ];

  double _persentage = 0;
  int _total = 0;
  List<String> StringQues = [];

  String? _answerQNo;

  String? _answer;
  String? _correctanswer;
  String? _question;
  bool _hasBeenPressed = false;
  String? _hasBeenPressedValue;

  @override
  Widget build(BuildContext context) {
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
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => LockPage(
                                nilai: 1,
                                next_nilai: 2,
                              )),
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
        body: NotificationListener<OverscrollIndicatorNotification>(
            onNotification: (OverscrollIndicatorNotification overscroll) {
              overscroll.disallowGlow();
              return false;
            },
            child: Stack(children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(
                  left: 30,
                  right: 20.0,
                  top: 20,
                ),
                child: Visibility(
                  visible: _question == null ? true : false,
                  child: Text(
                    'நிலை 2',
                    style: GoogleFonts.muktaMalar(
                      fontSize: 20,
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              Padding(
                  padding: const EdgeInsets.only(
                    left: 20,
                    right: 20.0,
                    top: 80,
                    bottom: 20,
                  ),
                  child: Visibility(
                    visible: _question == null ? true : false,
                    child: Container(
                      child: ListView.builder(
                          shrinkWrap: true,
                          itemCount: quiz.length,
                          itemBuilder: (context, index_Q) {
                            return Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  GestureDetector(
                                      onTap: () {
                                        setState(() {
                                          _question = quiz[index_Q]['Question']
                                              ['QuestionNumber'];
                                          // print(_question.toString());
                                        });
                                      },
                                      child: Card(
                                          shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(15.0),
                                          ),
                                          child: Container(
                                            height: 100,
                                            child: Stack(
                                              children: <Widget>[
                                                Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            left: 20,
                                                            right: 20),
                                                    child: Container(
                                                        height: 150.0,
                                                        decoration:
                                                            BoxDecoration(
                                                                image:
                                                                    DecorationImage(
                                                          image: AssetImage(
                                                            quiz[index_Q]
                                                                    ['Question']
                                                                ['img1'],
                                                          ),
                                                          fit: BoxFit.contain,
                                                        )))),
                                              ],
                                            ),
                                          ))),
                                  SizedBox(
                                    height: 20,
                                  ),
                                ]);
                          }),
                    ),
                  )),
              questionsW(),
              buttonEnd(width),
            ])));
  }

  Visibility questionsW() {
    return Visibility(
        visible: _question == null ? false : true,
        child: SafeArea(
            child: SingleChildScrollView(
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
                                          'நிலை ' +
                                              quiz[index_Q]['Question']
                                                  ['Nilai'] +
                                              ' > ',
                                          style: GoogleFonts.muktaMalar(
                                            fontSize: 20,
                                            color: Colors.black,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        Text(
                                          'கேள்வி ' + _question.toString(),
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
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    ConstrainedBox(
                                      constraints: BoxConstraints.tightFor(
                                          width: 130, height: 40),
                                      child: ElevatedButton(
                                        onPressed: () {
                                          setState(() {
                                            _hasBeenPressed = false;
                                            if (_question == '1') {
                                            } else {
                                              _question = (int.parse(_question
                                                          .toString()) -
                                                      1)
                                                  .toString();
                                            }
                                            print('Question ' +
                                                _question.toString());
                                          });
                                        },
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
                                              borderRadius:
                                                  new BorderRadius.all(
                                                      new Radius.circular(20))),
                                        ),
                                      ),
                                    ),
                                    ConstrainedBox(
                                      constraints: BoxConstraints.tightFor(
                                          width: 130, height: 40),
                                      child: ElevatedButton(
                                        onPressed: () {
                                          setState(() {
                                            _hasBeenPressed = false;
                                            if (_question ==
                                                quiz.length.toString()) {
                                              if (_persentage >= 50) {
                                                Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                      builder: (context) =>
                                                          Stage2(
                                                              persentage:
                                                                  _persentage,
                                                              max: _total,
                                                              correct:
                                                                  quiz.length)),
                                                );
                                              } else {
                                                Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                      builder: (context) =>
                                                          Stagefail(
                                                              next_nilai: 2,
                                                              nilai: 1,
                                                              persentage:
                                                                  _persentage,
                                                              max: quiz.length,
                                                              correct: _total)),
                                                );
                                              }

                                              print(_question);
                                            } else {
                                              _question = (int.parse(_question
                                                          .toString()) +
                                                      1)
                                                  .toString();
                                            }
                                            print('Question ' +
                                                _question.toString());

                                            if (_answer == _correctanswer) {
                                              _total = _total;
                                              print(
                                                  'final ' + _total.toString());
                                            }
                                          });
                                        },
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
                                              borderRadius:
                                                  new BorderRadius.all(
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
                                            Padding(
                                                padding: const EdgeInsets.only(
                                                  left: 10,
                                                ),
                                                child: Text(
                                                  quiz[index_Q1]['Question']
                                                      ['Question_Name'],
                                                  style: GoogleFonts.muktaMalar(
                                                    fontSize: 24,
                                                    color: Colors.black,
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                )),
                                            SizedBox(
                                              height: 15,
                                            ),
                                            GridView.builder(
                                                shrinkWrap: true,
                                                physics:
                                                    const NeverScrollableScrollPhysics(),
                                                gridDelegate:
                                                    SliverGridDelegateWithMaxCrossAxisExtent(
                                                        maxCrossAxisExtent: 200,
                                                        childAspectRatio: 4 / 5,
                                                        crossAxisSpacing: 20,
                                                        mainAxisSpacing: 20),
                                                itemCount: 4,
                                                itemBuilder: (BuildContext ctx,
                                                    index_A) {
                                                  return GestureDetector(
                                                    onTap: () {
                                                      setState(() {
                                                        //button green
                                                        _hasBeenPressedValue =
                                                            null;
                                                        _answer == null;

                                                        // button select
                                                        _hasBeenPressedValue = quiz[
                                                                int.parse(_question
                                                                        .toString()) -
                                                                    1]['Answers']
                                                            [
                                                            index_A]['AnswerNumber'];

                                                        //pick select answer no
                                                        _answer = quiz[int.parse(
                                                                    _question
                                                                        .toString()) -
                                                                1]['Answers'][
                                                            index_A]['AnswerNumber'];

                                                        // array correct answer no
                                                        _correctanswer = quiz[
                                                                int.parse(_question
                                                                        .toString()) -
                                                                    1]['Answers']
                                                            [
                                                            index_A]['Correct'];

                                                        // answer jason question no
                                                        _answerQNo = quiz[int.parse(
                                                                    _question
                                                                        .toString()) -
                                                                1]['Answers'][index_A]
                                                            [
                                                            'Answer_QuestionNumber'];

                                                        print('Selected_Question ' +
                                                            _answerQNo
                                                                .toString() +
                                                            '  Selected_Answer ' +
                                                            _answer.toString());
                                                      });
                                                    },
                                                    child: Card(
                                                      color: _hasBeenPressedValue ==
                                                                  quiz[index_Q1]
                                                                              [
                                                                              'Answers']
                                                                          [
                                                                          index_A]
                                                                      [
                                                                      'AnswerNumber'] &&
                                                              (_answerQNo ==
                                                                  _question)
                                                          ? kPrimaryLightGreyColor
                                                          : Colors.white,
                                                      shape:
                                                          RoundedRectangleBorder(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(15.0),
                                                      ),
                                                      child: Stack(
                                                          children: <Widget>[
                                                            Padding(
                                                                padding:
                                                                    const EdgeInsets
                                                                        .all(5),
                                                                child:
                                                                    Container(
                                                                  height: 200,
                                                                  width: 150,
                                                                  alignment:
                                                                      Alignment
                                                                          .center,
                                                                  decoration:
                                                                      BoxDecoration(
                                                                          image:
                                                                              DecorationImage(
                                                                            image:
                                                                                AssetImage(
                                                                              quiz[int.parse(_question.toString()) - 1]['Answers'][index_A]['imgA'],
                                                                            ),
                                                                            fit:
                                                                                BoxFit.cover,
                                                                          ),
                                                                          borderRadius:
                                                                              BorderRadius.circular(15)),
                                                                )),
                                                            Positioned(
                                                              top: 10,
                                                              left: 10,
                                                              child: ClipOval(
                                                                  child: Container(
                                                                      height: 40,
                                                                      width: 40,
                                                                      color: kPrimaryRedColor,
                                                                      child: Align(
                                                                          alignment: Alignment.center,
                                                                          child: Text(
                                                                            quiz[index_Q1]['Answers'][index_A]['AnswerNumber'],
                                                                            style:
                                                                                TextStyle(
                                                                              color: Colors.white,
                                                                              fontSize: 20.0,
                                                                              fontWeight: FontWeight.bold,
                                                                            ),
                                                                          )))),
                                                            ),
                                                            correctAnswer(
                                                                index_A,
                                                                index_Q1)
                                                          ]),
                                                    ),
                                                  );
                                                }),
                                          ]));
                                }),
                          ),
                        ])))));
  }

  Visibility correctAnswer(int index_A, int index_Q1) {
    return Visibility(
        visible: (_answer ==
                        quiz[int.parse(_question.toString()) - 1]['Answers']
                            [index_A]['AnswerNumber'] &&
                    _hasBeenPressed == true) &&
                (_answerQNo == _question) &&
                (_hasBeenPressedValue == null)
            ? true
            : false,
        child: _correctanswer == _answer
            ? Stack(children: <Widget>[
                Opacity(
                    opacity: 0.5,
                    child: Card(
                        color: kPrimaryLight2GreenColor,
                        child: Container(
                          height: 200,
                          width: 150,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15.0),
                        ))),
                Container(
                    height: 200,
                    width: 150,
                    child: Align(
                        alignment: Alignment.center,
                        child: ConstrainedBox(
                          constraints:
                              BoxConstraints.tightFor(width: 80, height: 30),
                          child: ElevatedButton(
                            onPressed: () {},
                            child: Text(
                              'சரி!',
                              style: GoogleFonts.muktaMalar(
                                color: kPrimaryLight1GreenColor,
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            style: ElevatedButton.styleFrom(
                              primary: Colors.white,
                              elevation: 0,
                              shape: RoundedRectangleBorder(
                                  borderRadius: new BorderRadius.all(
                                      new Radius.circular(20))),
                            ),
                          ),
                        )))
              ])
            : Stack(children: <Widget>[
                Opacity(
                    opacity: 0.5,
                    child: Card(
                        color: kPrimaryLightRedColor,
                        child: Container(
                          height: 200,
                          width: 150,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15.0),
                        ))),
                Container(
                    height: 200,
                    width: 150,
                    child: Align(
                        alignment: Alignment.center,
                        child: ConstrainedBox(
                          constraints:
                              BoxConstraints.tightFor(width: 80, height: 30),
                          child: ElevatedButton(
                            onPressed: () {},
                            child: Text(
                              'தவறு',
                              style: GoogleFonts.muktaMalar(
                                color: kPrimaryRedColor,
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            style: ElevatedButton.styleFrom(
                              primary: Colors.white,
                              elevation: 0,
                              shape: RoundedRectangleBorder(
                                  borderRadius: new BorderRadius.all(
                                      new Radius.circular(20))),
                            ),
                          ),
                        )))
              ]));
  }

  Visibility buttonEnd(double width) {
    return Visibility(
        visible: _answer == null ? false : true,
        child: SafeArea(
            child: Align(
          alignment: Alignment.bottomCenter,
          child: ConstrainedBox(
            constraints: BoxConstraints.tightFor(width: width * 1, height: 60),
            child: ElevatedButton(
              onPressed: () {
                setState(() {
                  _hasBeenPressed = true;
                  _hasBeenPressedValue = null;

                  if (_answer == _correctanswer && _answerQNo == _question) {
                    if (!StringQues.contains(_question.toString())) {
                      StringQues.add(_question.toString());
                      _total = StringQues.length;
                      print(StringQues.toList());
                      print("total " + _total.toString());
                      print("Persentage " + (_total / quiz.length).toString());

                      _persentage = (_total / quiz.length) * 100.0;
                      print(_persentage.toString());
                    }
                  }
                });
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
}

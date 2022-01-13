import 'package:deaf_app/Subject/subject.dart';
import 'package:deaf_app/_helper/controller.dart';
import 'package:deaf_app/components/appbar.dart';
import 'package:deaf_app/questionLock/Lock.dart';
import 'package:flutter/material.dart';

import 'package:flutter_svg/svg.dart';

import '../constants.dart';

class StageSuccess extends StatefulWidget {
  StageSuccess({
    Key? key,
    required this.totalQuestions,
    required this.correctAnswers,
    required this.successPercent,
    required this.level,
  }) : super(key: key);
  final int totalQuestions;
  final int correctAnswers;
  final double successPercent;
  final int level;

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<StageSuccess> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  MarksServices marksServices = MarksServices();
  Color getColor(Set<MaterialState> states) {
    const Set<MaterialState> interactiveStates = <MaterialState>{
      MaterialState.pressed,
      MaterialState.hovered,
      MaterialState.focused,
    };
    if (states.any(interactiveStates.contains)) {
      return Colors.red;
    }
    return Colors.grey;
  }

  @override
  Widget build(BuildContext context) {
    var screenHeight = MediaQuery.of(context).size.height;
    var screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
        key: _scaffoldKey,
        appBar: BaseAppBar(
          bacKText: "திரும்பி செல்",
          appBar: AppBar(),
        ),
        body: Stack(children: [
          Center(
              child: new Form(
                  child: new Column(children: <Widget>[
            SizedBox(height: screenHeight * (1 / 20)),
            Container(
              child: new Image.asset(
                "assets/png/Stage1.png",
              ),
            ),
            SizedBox(height: screenHeight * (1 / 20)),
            Container(
                child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                "நீங்கள் ${widget.totalQuestions} இல் ${widget.correctAnswers} க்கு ${widget.successPercent}% சரியாக ",
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 16.0,
                    fontWeight: FontWeight.bold),
              ),
            )),
            Container(
                child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                " பதில் அளித்துள்ளார் ",
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 16.0,
                    fontWeight: FontWeight.bold),
              ),
            )),
            SizedBox(height: screenHeight * (2.5 / 20)),
            SizedBox.fromSize(
              size: Size(76, 76),
              child: ClipOval(
                child: Material(
                  color: Colors.lightGreen[400],
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Icon(
                        Icons.done,
                      ),
                    ],
                  ),
                ),
              ),
            ),
            SizedBox(height: screenHeight * (0.5 / 20)),
          ]))),
          SafeArea(
            child: Align(
                alignment: Alignment.bottomCenter,
                child: Padding(
                    padding: const EdgeInsets.only(top: 0),
                    child: ConstrainedBox(
                      constraints: BoxConstraints.tightFor(
                          width: screenWidth * 1.0, height: 75),
                      child: ElevatedButton(
                        onPressed: () {
                          // Navigator.push(
                          //       context,
                          //       MaterialPageRoute(
                          //           builder: (context) => SubjectPage()),
                          //     );

                          marksServices.deleteAllLocalStorage();
                          Navigator.pop(context);
                          Navigator.pop(context);
                          Navigator.pop(context, "success");
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'நிலை ${widget.level} வரை',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 16.0,
                              ),
                            ),
                          ],
                        ),
                        style: ElevatedButton.styleFrom(
                          primary: kPrimaryLightGreenColor,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.only(
                              topRight: Radius.circular(20),
                              topLeft: Radius.circular(20),
                            ),
                          ),
                        ),
                      ),
                    ))),
          )
        ]));
  }
}

import 'package:deaf_app/questionLock/Lock.dart';

import 'package:flutter/material.dart';

import 'package:flutter_svg/svg.dart';

import '../constants.dart';

class Stage2 extends StatefulWidget {
     Stage2({Key? key, required this.persentage,required this.max,required this.correct}) : super(key: key);

  final double persentage;
  final int max;
  final int correct;

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<Stage2> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

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
        appBar: AppBar(
          leading: IconButton(
            icon: Icon(
              Icons.arrow_back,
              color: Colors.black,
            ),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => LockPage(nilai: 2,next_nilai: 3,)),
              );
            },
          ),
          leadingWidth: 70,
          actions: [
            Container(
                margin: const EdgeInsets.only(right: 30.0, top: 10.0),
                child: GestureDetector(
                  onTap: () {},
                  child: new SvgPicture.asset(
                    'assets/images/Group 86.svg',
                    width: 50.0,
                    height: 50.0,
                    allowDrawingOutsideViewBox: true,
                  ),
                )),
          ],
          backgroundColor: Colors.transparent,
          elevation: 0,
        ),
        body: Stack(children: [
          Center(
              child: new Form(
                  child: new Column(children: <Widget>[
            SizedBox(height: screenHeight * (1 / 20)),
            Container(
              child: new Image.asset(
                "assets/png/Stage2.png",
              ),
            ),
            SizedBox(height: screenHeight * (1 / 20)),
            Container(
                child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                   "நீங்கள் ${widget.correct} இல் ${widget.max} க்கு ${widget.persentage.floor()}% சரியாக ",
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
                      Icon(Icons.done),
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
                      constraints:
                          BoxConstraints.tightFor(width: screenWidth*1.0, height: 80),
                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => LockPage( nilai:2, next_nilai:3 )),
                             
                          );
                       
                                    
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'நிலை 2 வரை',
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

import 'package:deaf_app/constants.dart';
import 'package:deaf_app/questionLock/Lock.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:flutter_svg/svg.dart';

// ignore: must_be_immutable
class Stagefail extends StatefulWidget {
   Stagefail({Key? key, required this.persentage,required this.max,required this.correct,required this.nilai,required this.next_nilai}) : super(key: key);

  final double persentage;
  final int max;
  final int correct;


  int nilai = 0;
  int next_nilai = 0;
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<Stagefail> {
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
                MaterialPageRoute(builder: (context) => LockPage(nilai: widget.nilai,next_nilai: widget.next_nilai,)),
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
                "assets/png/Screenshot 2021-08-20 at 11.36.50 AM.png",
              ),
            ),
            SizedBox(height: screenHeight * (1 / 20)),
            Container(
                child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                "நீங்கள் குறைந்தது ${widget.max} இல் ${(widget.max/2).floor()} க்கு ",
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 16.0,
                    fontWeight: FontWeight.bold),
              ),
            )
              
                ),
            Container(
              child: Text(
                " (50%) சரியாக  பதில் அளிக்க வேண்டும் ",
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 16.0,
                    fontWeight: FontWeight.bold),
              ),
            ),
            Container(
                child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                "நீங்கள்  ${widget.max} இல் ${widget.correct} க்கு (${widget.persentage.floor()}%) சரியாக ",
                style: TextStyle(
                    color: Colors.red,
                    fontSize: 12.0,
                    fontWeight: FontWeight.bold),
              ),
            )
              
                ),
            Container(
              child: Text(
                "  பதில் அளித்துள்ளீர்கள் ",
                style: TextStyle(
                    color: Colors.red,
                    fontSize: 12.0,
                    fontWeight: FontWeight.bold),
              ),
            ),
            SizedBox(height: screenHeight * (1 / 20)),
            SizedBox.fromSize(
              size: Size(76, 76), 
              child: ClipOval(
                child: Material(
                  color: Colors.redAccent[100],

                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Icon(Icons.sync_rounded),
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
                    padding: const EdgeInsets.only(top: 0
                    
                        ),
                    child: ConstrainedBox(
                      constraints:
                          BoxConstraints.tightFor(width: screenWidth*1.0, height: 75),
                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => LockPage(nilai: widget.nilai,next_nilai: widget.next_nilai,)),
                          );
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'மீண்டும் முயற்சி செய் ',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 16.0,
                              ),
                            ),
                          ],
                        ),
                        style: ElevatedButton.styleFrom(
                          primary: kPrimaryColor,
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

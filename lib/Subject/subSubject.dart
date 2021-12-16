import 'package:deaf_app/constants.dart';
import 'package:deaf_app/grade/grade.dart';
import 'package:deaf_app/question/tamil.dart';
import 'package:deaf_app/questionLock/Lock.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';

class SubSubjectPage extends StatefulWidget {
  SubSubjectPage({Key? key, required this.title, required this.idForGetTerms})
      : super(key: key);

  final String title;
  final int idForGetTerms;
  

  @override
  _SubSubjectPageState createState() => _SubSubjectPageState();
}

class _SubSubjectPageState extends State<SubSubjectPage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  final List<Color> colors = <Color>[
    Colors.deepPurpleAccent,
    Colors.deepOrangeAccent,
    Colors.lightBlueAccent,
    Colors.lightGreenAccent,
    Colors.blue,
    Colors.pinkAccent
  ];
  final List<Map> details = [
    {'img': 'assets/png/1.png', "name": 'கலைச்சொற்கள்'},
    {'img': 'assets/png/2.png', "name": 'கற்றல் செயட்பாடுகள்'},
  ];
  late int idForGetTerms;

  @override
  void initState() {
    //initialize subject id for grades
    idForGetTerms = widget.idForGetTerms;
    print(idForGetTerms);

    super.initState();
  }

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
        body: NotificationListener<OverscrollIndicatorNotification>(
            onNotification: (OverscrollIndicatorNotification overscroll) {
              overscroll.disallowGlow();
              return false;
            },
            child: SingleChildScrollView(
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Stack(children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.only(
                            top: 20, left: 20, right: 20.0),
                        child: Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(top: 10.0),
                              child: TextField(
                                decoration: InputDecoration(
                                  border: InputBorder.none,
                                  fillColor: kPrimaryGreyColor,
                                  prefixIcon: Padding(
                                      padding: const EdgeInsets.only(
                                          left: 20, right: 20.0),
                                      child: Icon(
                                        Icons.search,
                                        color: Colors.grey,
                                      )),
                                  suffixIcon: Padding(
                                      padding:
                                          const EdgeInsets.only(right: 20.0),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        mainAxisSize: MainAxisSize.min,
                                        children: <Widget>[
                                          Container(
                                              height: 30,
                                              width: 40,
                                              child: VerticalDivider(
                                                color: Colors.grey,
                                                thickness: 1,
                                              )),
                                          Icon(
                                            Icons.keyboard_arrow_down,
                                            color: Colors.black,
                                          )
                                        ],
                                      )),
                                  enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.all(
                                      Radius.circular(15.0),
                                    ),
                                    borderSide: BorderSide(
                                      color: Colors.white,
                                      width: 2,
                                    ),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.all(
                                      Radius.circular(15.0),
                                    ),
                                    borderSide: BorderSide(
                                      color: kPrimaryGreyColor,
                                      width: 2,
                                    ),
                                  ),
                                  contentPadding: EdgeInsets.all(25.0),
                                  filled: true,
                                  hintText: 'தேடு',
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ]),
                    SizedBox(
                      height: 20,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                        left: 20,
                        right: 20.0,
                        top: 20,
                      ),
                      child: ListView.builder(
                          shrinkWrap: true,
                          itemCount: details.length,
                          itemBuilder: (context, index) {
                            return Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  GestureDetector(
                                      onTap: () {},
                                      child: Card(
                                          shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(15.0),
                                          ),
                                          child: Container(
                                            height: 270,
                                            child: Stack(
                                              children: <Widget>[
                                                Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            left: 10,
                                                            right: 10),
                                                    child: Container(
                                                        height: 200.0,
                                                        decoration:
                                                            BoxDecoration(
                                                                image:
                                                                    DecorationImage(
                                                          image: AssetImage(
                                                            details[index]
                                                                ['img'],
                                                          ),
                                                          fit: BoxFit.contain,
                                                        )))),
                                                Align(
                                                  alignment:
                                                      Alignment.bottomLeft,
                                                  child: ConstrainedBox(
                                                    constraints:
                                                        BoxConstraints.tightFor(
                                                            height: 70,
                                                            width: width * 0.9),
                                                    child: Container(
                                                      child: Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .center,
                                                        children: [
                                                          Text(
                                                            details[index]
                                                                ['name'],
                                                            style: GoogleFonts
                                                                .muktaMalar(
                                                              fontSize: 20,
                                                              color:
                                                                  Colors.white,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold,
                                                            ),
                                                          ),
                                                          SizedBox(
                                                            width: 10,
                                                          ),
                                                          ElevatedButton(
                                                            onPressed: () {
                                                              if (details[index]
                                                                      [
                                                                      'name'] ==
                                                                  "கலைச்சொற்கள்") {
                                                                Navigator.push(
                                                                  context,
                                                                  MaterialPageRoute(
                                                                      builder: (context) => TamilPage(
                                                                          title:
                                                                              '',
                                                                          id: widget
                                                                              .idForGetTerms)),
                                                                );
                                                              } else if (details[
                                                                          index]
                                                                      [
                                                                      'name'] ==
                                                                  "கற்றல் செயட்பாடுகள்") {
                                                                Navigator.push(
                                                                  context,
                                                                  MaterialPageRoute(
                                                                      builder:
                                                                          (context) =>
                                                                              LockPage(
                                                                                nilai: 0,
                                                                                next_nilai: 0,
                                                                              )),
                                                                );
                                                              } else {
                                                                return;
                                                              }
                                                            },
                                                            child: Icon(
                                                                Icons
                                                                    .arrow_forward,
                                                                color: Colors
                                                                    .white),
                                                            style:
                                                                ElevatedButton
                                                                    .styleFrom(
                                                              primary:
                                                                  kPrimaryRedColor,
                                                              onPrimary:
                                                                  Colors.white,
                                                              shape:
                                                                  CircleBorder(),
                                                              padding:
                                                                  EdgeInsets
                                                                      .all(5),
                                                              side: BorderSide(
                                                                width: 1.0,
                                                                color: Colors
                                                                    .white,
                                                              ),
                                                            ),
                                                          )
                                                        ],
                                                      ),
                                                      decoration: BoxDecoration(
                                                          color:
                                                              kPrimaryRedColor,
                                                          borderRadius:
                                                              BorderRadius.only(
                                                            bottomRight:
                                                                Radius.circular(
                                                                    15),
                                                            bottomLeft:
                                                                Radius.circular(
                                                                    15),
                                                          )),
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ))),
                                  SizedBox(
                                    height: 20,
                                  ),
                                ]);
                          }),
                    ),
                  ]),
            )));
  }
}

import 'dart:convert';

import 'package:deaf_app/Subject/subSubject.dart';
import 'package:deaf_app/Subject/subject.dart';
import 'package:deaf_app/api/api.dart';
import 'package:deaf_app/constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class GradePage extends StatefulWidget {
  final int idForGetSubjects;
  const GradePage({key, required this.idForGetSubjects}) : super(key: key);
  // GradePage(foundSubject);

  // GradePage(foundSubject);

  //GradePage(foundSubject);

  //GradePage(foundSubject);

  // late final List _foundSubject;

  // GradePage(this._foundSubject);
  @override
  _GradePageState createState() => _GradePageState();
}

class _GradePageState extends State<GradePage> {
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
    {'img': 'assets/png/1-2.png', "name": '1-2'},
    {'img': 'assets/png/3-4.png', "name": '3-4'},
    {'img': 'assets/png/5.png', "name": '5'},
    {'img': 'assets/png/6-8.png', "name": '6-8'},
    {'img': 'assets/png/9-11.png', "name": '9-11'},
  ];
// List _foundSubject = [];

  //   void _calculation() {
  //   var no = _cart[0]["selling_price"];
  //   setState(() {
  //     {
  //       _volume = int.parse(_total_cost.text);
  //       _total = int.parse(_total_cost.text) * no;
  //     }
  //   });
  //   print(_volume);
  //   print(_total);
  // }
  late int idForGetSubjects;

  //initialize list for add subjects from API
  List<dynamic> _foundgrade = [];
  List _GradesFromDB = [];

  @override
  void initState() {
    idForGetSubjects = widget.idForGetSubjects;
    print(idForGetSubjects);
    _getUserById();
    print("cvdsvdsv");
    super.initState();
  }

  int? usernameId;

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var image = "https://deafapi.moodfor.codes/images/";
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
                          builder: (context) => SubjectPage(title: '')),
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
                        child: SizedBox(
                          height: details.length * 130,
                          child: ListView.builder(
                              itemCount: _foundgrade.length,
                              itemBuilder: (context, index) {
                                return Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      GestureDetector(
                                          onTap: () {
                                            if (details[index]['name'] ==
                                                "1-2") {
                                              Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        SubSubjectPage(
                                                            title: '')),
                                              );
                                            } else {
                                              return;
                                            }
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
                                                            const EdgeInsets
                                                                    .only(
                                                                left: 20,
                                                                right: 20),
                                                        child: Container(
                                                            height: 150.0,
                                                            decoration:
                                                                BoxDecoration(
                                                                    image:
                                                                        DecorationImage(
                                                              image:
                                                                  NetworkImage(
                                                                image +
                                                                    _foundgrade[
                                                                            index]
                                                                        [
                                                                        'image'],
                                                              ),
                                                              fit: BoxFit
                                                                  .contain,
                                                            )))),
                                                  ],
                                                ),
                                              ))),
                                      SizedBox(
                                        height: 20,
                                      ),
                                    ]);
                              }),
                        )),
                  ]),
            )));
  }

  // void _getUserById() async {
  //   print("data from sample screen");
  //   usernameId = widget.idForGetSubjects;
  //   print(usernameId);
  //   var data = {
  //     "subject_id": usernameId,
  //   };
  //   var res = await CallApi().getSubjectById(data, 'getGradeBySubjectId');
  //   var body = json.decode(res.body);
  //   print(body);
  //   // Add subjects to _SubjectsFromDB List
  //   _SubjectsFromDB.add(body);
  //   _foundSubject = _SubjectsFromDB[0];
  //   print(_foundSubject);

  //   setState(() {});
  // }

  void _getUserById() async {
    setState(() {});
    usernameId = widget.idForGetSubjects;
    var data = {
      "subject_id": usernameId,
    };
    try {
      _GradesFromDB.clear();
      var bodyRoutes;
      var res = await CallApi()
          .getSubjectById("getGradeBySubjectId/${widget.idForGetSubjects}");
      bodyRoutes = json.decode(res.body);
      print("bodyRoutes");
      // print(bodyRoutes);

      // Add subjects to _SubjectsFromDB List
      _GradesFromDB.add(bodyRoutes);
      _foundgrade = _GradesFromDB[0];
      print(_foundgrade);
      print("----------------------");
    } catch (e) {
      print(e);
    }
    setState(() {});
  }
}

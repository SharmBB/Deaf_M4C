import 'dart:convert';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:deaf_app/api/api.dart';
import 'package:deaf_app/constants.dart';
import 'package:deaf_app/grade/grade.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';

class SubjectPage extends StatefulWidget {
  SubjectPage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  _SubjectPageState createState() => _SubjectPageState();
}

class _SubjectPageState extends State<SubjectPage> {
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

//initialize list for add subjects from API
  // List<dynamic> _foundSubject = [];
  List _SubjectsFromDB = [];

// loader
  bool _isLoading = false;

  @override
  initState() {
    _apiGetSubjects();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    //fetch image from api
    var image = "https://deafapi.moodfor.codes/images/";
    return Scaffold(
        appBar: AppBar(
          leading: Padding(
              padding: const EdgeInsets.only(
                top: 20.0,
                left: 10,
              ),
              child: Row(mainAxisAlignment: MainAxisAlignment.start, children: [
                IconButton(
                  icon: Icon(Icons.subject, color: Colors.black),
                  onPressed: () {},
                ),
                Padding(
                  padding: const EdgeInsets.only(
                    top: 5.0,
                  ),
                ),
              ])),
          leadingWidth: width * 1,
          titleSpacing: 0.00,
          actions: [
            Padding(
              padding: const EdgeInsets.only(
                top: 30.0,
                right: 10,
              ),
            ),
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
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Padding(
                  padding: const EdgeInsets.only(left: 20.0),
                  child: Text(
                    'வணக்கம் ',
                    style: GoogleFonts.muktaMalar(
                      fontSize: 15,
                    ),
                  )),
              new Text('நிக்கி.',
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 18.0,
                      fontWeight: FontWeight.bold)),
            ]),
            Stack(children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(left: 20, right: 20.0),
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 10.0),
                      child: TextField(
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          fillColor: kPrimaryGreyColor,
                          prefixIcon: Padding(
                              padding:
                                  const EdgeInsets.only(left: 20, right: 20.0),
                              child: Icon(
                                Icons.search,
                                color: Colors.grey,
                              )),
                          suffixIcon: Padding(
                              padding: const EdgeInsets.only(right: 20.0),
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
            Padding(
                padding: const EdgeInsets.only(
                  left: 20,
                  right: 20,
                ),
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      TextButton(
                        style: ButtonStyle(
                          foregroundColor:
                              MaterialStateProperty.resolveWith(getColor),
                          overlayColor:
                              MaterialStateProperty.all(Colors.transparent),
                        ),
                        onPressed: () {},
                        child: Text(
                          'வகைகள்  ',
                          style: GoogleFonts.muktaMalar(
                            fontSize: 18,
                          ),
                        ),
                      ),
                      TextButton(
                        style: ButtonStyle(
                          foregroundColor:
                              MaterialStateProperty.resolveWith(getColor),
                          overlayColor:
                              MaterialStateProperty.all(Colors.transparent),
                        ),
                        onPressed: () {},
                        child: Text(
                          'அனைத்தையும் காட்டு',
                          style: GoogleFonts.muktaMalar(
                            fontSize: 18,
                          ),
                        ),
                      ),
                    ])),
            !_isLoading
                ? _SubjectsFromDB[0].length == 0
                    ? Padding(
                        padding: const EdgeInsets.only(top: 20),
                        child: Text("No Subjects available"),
                      )
                    : GridView.builder(
                        physics: NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          // childAspectRatio: 9/10,
                          mainAxisSpacing: 5.0,
                          // crossAxisSpacing: 25.0
                        ),
                        itemCount: _SubjectsFromDB[0].length,
                        itemBuilder: (BuildContext context, int index) =>
                            GestureDetector(
                          onTap: () {
                            Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => GradePage(
                                        idForGetSubjects: _SubjectsFromDB[0][index]['id']),
                                  ));
                          },
                          child: Container(
                            padding: EdgeInsets.all(10),
                            child: Column(
                              children: [
                                Align(
                                  alignment: Alignment.centerLeft,
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text(
                                        _SubjectsFromDB[0][index]['title'],
                                        style: TextStyle(
                                            color: Colors.black,
                                            fontSize: 15.0)),
                                  ),
                                ),
                                Expanded(
                                  child: CachedNetworkImage(
                                    // height: 150,
                                    // width: 160,
                                    imageUrl: image +
                                        _SubjectsFromDB[0][index]['image'],
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
                                        Icon(Icons.error),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      )
                : Padding(
                    padding: const EdgeInsets.only(top: 30.0, left: 190),
                    child: CupertinoActivityIndicator(),
                  ),
          ]),
        ));
  }

//get subjects details from api
  void _apiGetSubjects() async {
    setState(() {
      _isLoading = true;
    });
    try {
      _SubjectsFromDB.clear();
      var bodyRoutes;
      var res = await CallApi().getAllSubjects('subjects');
      bodyRoutes = json.decode(res.body);

      // Add subjects to _SubjectsFromDB List
      _SubjectsFromDB.add(bodyRoutes);
      print(_SubjectsFromDB[0]);
    } catch (e) {
      print(e);
    }
    setState(() {
      _isLoading = false;
    });
  }
}

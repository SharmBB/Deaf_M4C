import 'dart:convert';
import 'package:deaf_app/api/api.dart';
import 'package:deaf_app/constants.dart';
import 'package:deaf_app/questionLock/Lock.dart';
import 'package:deaf_app/terms/termsCatergory.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class TamilPage extends StatefulWidget {
  TamilPage({Key? key, required this.title, required this.id})
      : super(key: key);

  final String title;
  final int id;

  @override
  _TamilPageState createState() => _TamilPageState();
}

class _TamilPageState extends State<TamilPage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  late int id;

  @override
  void initState() {
    //initialize grades id for terms
    id = widget.id;
    print(id);
    _getTermbyID();
    super.initState();
  }

//initialize list for add terms from API
  List<dynamic> _foundTerms = [];
  List _TermsFromDB = [];

  // loader
  bool _isLoading = false;

  @override
  Widget build(BuildContext context) {
    //fetch image from api
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
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Stack(children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(top: 20, left: 20, right: 20.0),
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
            SizedBox(
              height: 20,
            ),
            Padding(
                padding: const EdgeInsets.only(
                  left: 20,
                  right: 20.0,
                  top: 20,
                ),
                child: Container(
                  child: !_isLoading
                      ? _TermsFromDB[0].length == 0
                          ? Padding(
                              padding: const EdgeInsets.only(top: 20),
                              child: Text("No terms available"),
                            )
                          : ListView.builder(
                              shrinkWrap: true,
                              itemCount: _foundTerms.length,
                              itemBuilder: (context, index) {
                                return Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      GestureDetector(
                                          onTap: () {
                                            Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      Terms_Catergory(
                                                          gradeid: widget.id)),
                                            );
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
                                                                    _foundTerms[
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
                              })
                      : Padding(
                          padding: const EdgeInsets.only(top: 120.0, left: 180),
                          child: CupertinoActivityIndicator(),
                        ),
                )),
          ]),
        ));
  }

  //get subjects details from api
  void _getTermbyID() async {
    setState(() {
      _isLoading = true;
    });
    try {
      _TermsFromDB.clear();
      var bodyRoutes;
      var res = await CallApi().getTermsById("getTermByGradeId/${widget.id}");
      bodyRoutes = json.decode(res.body);

      // Add terms from body to _GradesFromDB List
      _TermsFromDB.add(bodyRoutes);
      _foundTerms = _TermsFromDB[0];
      print(_foundTerms);
    } catch (e) {
      print(e);
    }
    setState(() {
      _isLoading = false;
    });
  }
}

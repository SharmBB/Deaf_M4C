import 'dart:convert';

import 'package:deaf_app/Subject/subSubject.dart';
import 'package:deaf_app/api/api.dart';
import 'package:deaf_app/components/appbar.dart';
import 'package:deaf_app/constants.dart';
import 'package:deaf_app/quiz/quiz4.dart';
import 'package:deaf_app/quiz/quiz3dart';
import 'package:deaf_app/quiz/quiz2.dart';
import 'package:deaf_app/quiz/quiz1.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';

class QuestionLockPage extends StatefulWidget {
  QuestionLockPage({
    Key? key,
    required this.nilai,
    required this.next_nilai,
    required this.gradeid,
    required this.level,
  }) : super(key: key);

  final int nilai;
  final int next_nilai;
  final int gradeid;
  final int level;

  @override
  _LockPageState createState() => _LockPageState();
}

class _LockPageState extends State<QuestionLockPage> {
  late int gradeid;
  late int level;
  //initialize list for add subjects from API
  List<dynamic> _foundSubject = [];
  List _SubjectsFromDB = [];

// loader
  bool _isLoading = false;

  int index = 1;

  @override
  void initState() {
    gradeid = widget.gradeid;
    print(gradeid);
    level = widget.level;
    print(level);

    super.initState();
  }

  int no = 0;

  void calc() {
    no = no + 1;
  }

  @override
  Widget build(BuildContext context) {
    var image = "https://deafapi.moodfor.codes/images/";
    var width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: BaseAppBar(
        bacKText: "திரும்பி செல்",
        username: 'நிக்கி',
        appBar: AppBar(),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                  padding: const EdgeInsets.only(top: 20.0, bottom: 20.0),
                  child: Text(
                    "கற்றல் செயட்பாடுகள்",
                    style: GoogleFonts.muktaMalar(
                      fontSize: 20,
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                    ),
                  )),
              GridView.builder(
                physics: NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  mainAxisSpacing: 25.0,
                  crossAxisSpacing: 25.0,
                ),
                itemCount: widget.level,
                itemBuilder: (BuildContext ctx, int index) {
                  //  index = 0;
                  return GestureDetector(
                    onTap: () {
                      print(index+1);
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => Quiz1Page(
                                  gradeid: widget.gradeid,
                                  title: "", level: index+1,
                                )),
                      );
                    },
                    child: Container(
                      alignment: Alignment.center,
                      child: Text("${index+1}"),
                      decoration: BoxDecoration(
                          color: Colors.grey[300],
                          borderRadius: BorderRadius.circular(15)),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Future<dynamic> popup(BuildContext context, int xNilai, int xNilai2) {
  //   return showDialog(
  //       context: context,
  //       builder: (BuildContext context) {
  //         return AlertDialog(
  //           title: Padding(
  //               padding:
  //                   const EdgeInsets.only(left: 10.0, right: 10.0, top: 10.0),
  //               child: Align(
  //                 alignment: Alignment.center,
  //                 child: Column(
  //                   children: <Widget>[
  //                     Text('நிலை $xNilai2 ஐ திறக்க நீங்கள்',
  //                         style: GoogleFonts.muktaMalar(
  //                           fontSize: 18,
  //                           fontWeight: FontWeight.bold,
  //                         )),
  //                     Text('நிலை $xNilai ஐ முடிக்க வேண்டும் ',
  //                         style: GoogleFonts.muktaMalar(
  //                           fontSize: 18,
  //                           fontWeight: FontWeight.bold,
  //                         )),
  //                     Padding(
  //                         padding: const EdgeInsets.only(top: 15.0),
  //                         child: ConstrainedBox(
  //                           constraints:
  //                               BoxConstraints.tightFor(width: 130, height: 40),
  //                           child: ElevatedButton(
  //                             onPressed: () {},
  //                             child: Text(
  //                               'சரி',
  //                               style: GoogleFonts.muktaMalar(
  //                                 color: Colors.white,
  //                                 fontSize: 18,
  //                               ),
  //                             ),
  //                             style: ElevatedButton.styleFrom(
  //                               primary: kPrimaryRedColor,
  //                               elevation: 0,
  //                               shape: RoundedRectangleBorder(
  //                                   borderRadius: new BorderRadius.all(
  //                                       new Radius.circular(20))),
  //                             ),
  //                           ),
  //                         )),
  //                   ],
  //                 ),
  //               )),
  //         );
  //       });
  // }

  // void _apiGetSubjects() async {
  //   setState(() {
  //     //  _isLoading = true;
  //   });
  //   try {
  //     _SubjectsFromDB.clear();
  //     var bodyRoutes;
  //     var res = await CallApi()
  //         .getQuestionsByGradeId('questionsByGradeId/${widget.id}/1');
  //     bodyRoutes = json.decode(res.body);

  //     // Add subjects to _SubjectsFromDB List
  //     _SubjectsFromDB.add(bodyRoutes);
  //     _foundSubject = _SubjectsFromDB[0];
  //     print(_foundSubject);
  //   } catch (e) {
  //     print(e);
  //   }
  //   setState(() {
  //     _isLoading = false;
  //   });
  // }
}

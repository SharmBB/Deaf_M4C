import 'dart:convert';

import 'package:deaf_app/Screen/Screen1.dart';
import 'package:deaf_app/api/api.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../constants.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final scaffoldKey = new GlobalKey<ScaffoldState>();

  GlobalKey<FormState> formKey = new GlobalKey();

  TextEditingController _emailController = new TextEditingController();
  TextEditingController _passwordController = new TextEditingController();

  String? email, password;

  bool showPassword = true;

  bool _validate = false;
  //initialize list for add subjects from API
  List<dynamic> _foundUsers = [];
  List _UsersFromDB = [];
  List user = [];

  String? usernameDB;

// loader
  bool _isLoading = false;
  List orderAdd = [];

  @override
  initState() {
    _apiGetUsers();
    addItems();
    super.initState();
  }

  addItems() {
    for (var i = 0; i < _foundUsers.length; i++) {
      orderAdd.add({
        _foundUsers[i]["name"],
        // "quantity": _cart[i]["numberofPacks"]
      });
    }
    // print(addItems());
    print("object");
    print(orderAdd);
  }

  void performLogin() {
    final snackbar = new SnackBar(
      content: new Text("Email : $email, password : $password"),
    );
    scaffoldKey.currentState!.showSnackBar(snackbar);
  }

  var mac = "24234.52345.354345";

  @override
  Widget build(BuildContext context) {
    var screenHeight = MediaQuery.of(context).size.height;
    var screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
        //     resizeToAvoidBottomInset: false,
        body: Stack(children: [
      Center(
          child: new Form(
              key: formKey,
              //   autovalidate: _validate,
              child: new Column(children: <Widget>[
                SizedBox(height: screenHeight * (2 / 20)),
                Align(
                  alignment: Alignment.center,
                  child: Padding(
                    padding: const EdgeInsets.only(left: 25),
                    child: Text(
                      'உள்நுழைக',
                      textAlign: TextAlign.left,
                      style: TextStyle(
                          color: kPrimaryDarkColor,
                          fontSize: 20,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
                SizedBox(height: screenHeight * (2.5 / 20)),

                Padding(
                  padding: const EdgeInsets.all(18.0),
                  child: Container(
                      child: Column(
                    children: <Widget>[
                      nameInput(),
                      SizedBox(height: screenHeight * (0.5 / 20)),
                      telephoneInput(),
                      SizedBox(height: screenHeight * (5 / 20)),
                    ],
                  )),
                ),

                Container(
                  child: SvgPicture.asset(
                    "assets/images/arrow.svg",
                  ),
                ),
                // SizedBox(height: 60.0),
              ]))),
      SafeArea(
        child: Align(
            alignment: Alignment.bottomCenter,
            child: ConstrainedBox(
              constraints:
                  BoxConstraints.tightFor(width: screenWidth * 1.0, height: 75),

              child: ElevatedButton(
                onPressed: () {
                  onClick();
                  // Navigator.push(
                  //   context,
                  //   MaterialPageRoute(builder: (context) => Screen1()),
                  // );
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'உள்நுழைக',
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
              //   ),
            )),
      )
    ]));
  }

  Widget nameInput() {
    RegExp regex = new RegExp("([a-zA-Z',.-]+( [a-zA-Z',.-]+)*){2,30}");
    return TextFormField(
      decoration: InputDecoration(
        hintText: "பெயர்",
        hintStyle: TextStyle(
            fontSize: 16.0, color: Colors.black, fontWeight: FontWeight.bold),
        fillColor: Colors.black12,
        filled: true,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(20.0)),
          borderSide: BorderSide.none,
        ),
      ),
      textInputAction: TextInputAction.next,
      keyboardType: TextInputType.name,
      validator: (value) {
        if (value!.length == 0) {
          return 'Name Required';
        } else if (!regex.hasMatch(value)) {
          return 'Enter Valid Name';
        } else {
          return null;
        }
      },
      onSaved: (String? val) {
        email = val;
      },
      controller: _emailController,
    );
  }

  Widget telephoneInput() {
    return TextFormField(
      keyboardType: TextInputType.number,
      validator: (value) {
        RegExp regex = new RegExp(r'(^(?:[+0]9)?[0-9]{10,12}$)');
        if (value!.length == 0) {
          return 'Telephone Number Required';
        } else if (!regex.hasMatch(value)) {
          return 'Enter Valid Telephone Number';
        }
        return null;
      },
      onSaved: (String? val) {
        password = val;
      },
      controller: _passwordController,
      textInputAction: TextInputAction.next,
      decoration: InputDecoration(
        hintText: "தொலைபேசி எண்",
        hintStyle: TextStyle(
            fontSize: 16.0, color: Colors.black, fontWeight: FontWeight.bold),
        fillColor: Colors.black12,
        filled: true,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(20.0)),
          borderSide: BorderSide.none,
        ),
      ),
    );
  }

  onClick() async {
    if (formKey.currentState!.validate()) {
      _handleLogin();
      // scaffoldKey.currentState!.showSnackBar(snackbar);

    } else {
      setState(() {
        _validate = true;
      });
    }
  }

  void _handleLogin() async {
    setState(() {
      //  _isLoading = true;
    });
    try {
      var data = {
        "name": _emailController.text,
        "phone": _passwordController.text,
        "mac": mac,
      };

      var res = await CallApi().postData(data, 'users');

      var body = json.decode(res.body);
      print(body);
      print(body['phone']);

      if (body['phone'] != user) {
        // SharedPreferences localStorage = await SharedPreferences.getInstance();
        // var phoneNumber = body['phone'];
        // localStorage.setString('phone', phoneNumber);
        // print(phoneNumber);
        print("------------");
        print(orderAdd);
        print(body);
        print(body);
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (BuildContext context) => Screen1()),
        );
      } else {
        print("error");
      }
    } catch (e) {
      print(e);
    }
    setState(() {
      //_isLoading = false;
    });
  }

  //get subjects details from api
  void _apiGetUsers() async {
    setState(() {
      // _isLoading = true;
    });
    try {
      _UsersFromDB.clear();
      var bodyRoutes;
      var res = await CallApi().getAllUsers('users');
      bodyRoutes = json.decode(res.body);

      // Add subjects to _SubjectsFromDB List
      _UsersFromDB.add(bodyRoutes);
      _foundUsers = _UsersFromDB[0];
      for (var i = 0; i < _foundUsers.length; i++) {
        SharedPreferences localStorage = await SharedPreferences.getInstance();
        user.add({'no': _foundUsers[i]['id'].toString()});
        var phoneNumber = user[i]['no'];
        localStorage.setString('no', phoneNumber).toString();
        print(phoneNumber);
        print("------------");
        print(phoneNumber);

        print(user);
      }

      print(user);
      print("nckjn");
      print(_foundUsers);
      print("nckjn");
      // print(ph)
    } catch (e) {
      print(e);
    }
    setState(() {
      _isLoading = false;
    });
  }
}

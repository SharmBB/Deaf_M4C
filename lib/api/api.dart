import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class CallApi {
  var _urlwithoutAuth = 'https://deafapi.moodfor.codes/';
  var token;

  getAllSubjects(apiUrl) async {
    var fullUrl = Uri.parse(_urlwithoutAuth + apiUrl);
    return await http.get(
      fullUrl,
      headers: _setHeaders(),
    );
  }

  getSubjectById(data, apiUrl) async {
    var fullUrl = Uri.parse(_urlwithoutAuth + apiUrl);
    return await http.post(
      fullUrl,
      body: jsonEncode(data),
      headers: _setHeaders(),
    );
  }

  _setHeaders() => {
        'Content-type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Bearer $token'
      };

  _getToken() async {
    SharedPreferences localStorage = await SharedPreferences.getInstance();
    var token = localStorage.getString('token');
    return '?token=$token';
  }
}

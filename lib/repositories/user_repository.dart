import 'dart:convert';
import 'package:app_drink_arena/helpers/handle_error.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import '/models/user.dart';

class UserRepository {
  Future<void> register(User user) async {
    String baseUrl = dotenv.env['BASE_URL'].toString();
    Uri url = Uri.parse('$baseUrl/user');
    dynamic response = await http.post(
      url,
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(user),
    );
    print('Response status: ${response.statusCode}');
    print('Response body: ${response.body}');
  }

  Future<String> getUser() async {
    // get user in the local storage
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? username = prefs.getString('username');
    if (username != null) {
      return username;
    } else {
      return 'Invité';
    }
  }

  Future<void> saveIdUser() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if (!prefs.containsKey('userId')) {
      String baseUrl = dotenv.env['BASE_URL'].toString();
      Uri url = Uri.parse('$baseUrl/user/me');
      var response = await http.get(
        url,
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': 'Bearer ${await getToken()}'
        },
      );
      print('Response status: ${response.statusCode}');
      print('Response body: ${response.body}');

      int id = jsonDecode(response.body)['id'];
      print('id : $id');
      prefs.setInt('userId', id);
    }
  }

  Future<String> getToken() async {
    // get user in the local storage
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('token');
    return token!;
  }

  Future<void> login(String username, String password) async {
    String baseUrl = dotenv.env['BASE_URL'].toString();
    Uri url = Uri.parse('$baseUrl/login_check');
    var response = await http.post(url,
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode({'username': username, 'password': password}));

    if (response.statusCode == 200) {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      dynamic token = jsonDecode(response.body)['token'];
      print('Response body: $token');

      prefs.setString('token', token);
      prefs.setString('username', username);
    } else {
      throw Exception('Ce compte n\'existe pas');
    }
  }

  Future<void> logout() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.remove('user');
  }

  Future<String> requestForgotPassword() async {
    String baseUrl = dotenv.env['BASE_URL'].toString();

    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? email = prefs.getString('email');

    Uri url = Uri.parse('$baseUrl/user/request-forgot-password');
    dynamic response = await http.post(
      url,
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(email),
    );
    print('Response status: ${response.statusCode}');
    print('Response body: ${response.body}');

    return jsonDecode(response.body)['code'];
  }

  Future<int> recoverPassword(String password, String recoverCode) async {
    String baseUrl = dotenv.env['BASE_URL'].toString();

    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? email = prefs.getString('email');

    var url = Uri.parse('$baseUrl/user/recover-password');
    var response = await http.post(url,
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode({
          'password': password,
          'recoverCode': recoverCode,
          'email': email
        }));
    if (response.statusCode == 200) {
      print('Response status: ${response.statusCode}');
      print('Response body: ${response.body}');
      // return respose.body to int
      return int.parse(response.body);
    } else {
      throw Exception('Mauvais code de récupération');
    }
  }

  SnackBar errorOnLogin(int statusCode, BuildContext context) {
    HandleError handleError = HandleError();
    return handleError.errorOnLogin(statusCode, context);
  }

  Widget errorOnProfile(int statusCode, BuildContext context) {
    HandleError handleError = HandleError();
    return handleError.errorOnProfile(statusCode, context);
  }
}

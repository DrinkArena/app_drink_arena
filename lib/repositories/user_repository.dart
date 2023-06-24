import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import '/models/user.dart';

class UserRepository {
  Future<void> saveUser(User user) async {
    await dotenv.load(fileName: ".env");
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

  Future<User> getUser() async {
    // get user in the local storage
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? userString = prefs.getString('user');
    if (userString != null) {
      Map<String, dynamic> userMap = jsonDecode(userString);
      User user = User.fromJson(userMap);
      return user;
    } else {
      throw Exception('No user found');
    }
  }

  Future<void> login(String email, String password) async {
    await dotenv.load(fileName: ".env");
    String baseUrl = dotenv.env['BASE_URL'].toString();
    // get user in the database
    Uri url = Uri.parse('$baseUrl/users/$email/$password');
    dynamic response = await http.get(url);
    print('Response status: ${response.statusCode}');
    print('Response body: ${response.body}');
    if (response.statusCode == 200) {
      // set user in the local storage
      SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.setString('user', response.body);
    } else {
      throw Exception('No user found');
    }
  }

  Future<void> logout() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.remove('user');
  }

  Future<String> requestForgotPassword() async {
    await dotenv.load(fileName: ".env");
    String baseUrl = dotenv.env['BASE_URL'].toString();

    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? email = prefs.getString('email');

    Uri url = Uri.parse('$baseUrl/users/request-forgot-password');
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
    await dotenv.load(fileName: ".env");
    String baseUrl = dotenv.env['BASE_URL'].toString();

    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? email = prefs.getString('email');

    var url = Uri.parse('$baseUrl/recover-password');
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
      throw Exception('No user found');
    }
  }
}

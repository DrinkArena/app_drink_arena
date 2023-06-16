import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import '/models/user.dart';

_dotenv() async {
  await dotenv.load(fileName: ".env");
}

final String _baseUrl = dotenv.env['BASE_URL'].toString();

class UserRepository {
  Future<void> saveUser(User user) async {
    var url = Uri.parse('$_baseUrl/users');
    var response = await http.post(
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
    // get user in the database
    var url = Uri.parse('$_baseUrl/users/$email/$password');
    var response = await http.get(url);
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

  Future<void> disconnect() async {
    // disconnect user in the local storage
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.remove('user');
  }

  Future<int> recoverPassword(String email) async {
    // recover password in the database
    var url = Uri.parse('$_baseUrl/users/recoverPassword/$email');
    var response = await http.get(url);
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

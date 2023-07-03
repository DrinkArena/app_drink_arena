import 'dart:convert';

import 'package:app_drink_arena/models/history.dart';
import 'package:app_drink_arena/repositories/user_repository.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;

class HistoryRepository {
  UserRepository _userRepository = UserRepository();
  Future<List<History>> getHistory() async {
    await dotenv.load(fileName: ".env");
    String baseUrl = dotenv.env['BASE_URL'].toString();

    var url = Uri.parse('$baseUrl/user/history/me');
    var response = await http.get(
      url,
      headers: <String, String>{
        'Content-Type': 'application/json',
        'Authorization': 'Bearer ${await _userRepository.getToken()}'
      },
    );
    print('Response status: ${response.statusCode}');
    print('Response body: ${response.body}');
    if (response.statusCode == 200) {
      List<dynamic> historyMap = jsonDecode(response.body);
      List<History> history =
          historyMap.map((e) => History.fromJson(e)).toList();

      return history;
    } else {
      return [];
    }
  }
}

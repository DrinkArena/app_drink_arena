import 'package:app_drink_arena/models/history.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

_dotenv() async {
  await dotenv.load(fileName: ".env");
}

final String _baseUrl = dotenv.env['BASE_URL'].toString();

class HistoryRepository {
  Future<History> getHistory() async {
    var url = Uri.parse('$_baseUrl/history');
    var response = await http.get(url);
    print('Response status: ${response.statusCode}');
    print('Response body: ${response.body}');
    if (response.statusCode == 200) {
      // set Model in the local storage
      Map<String, dynamic> historyMap = jsonDecode(response.body);
      History history = History.fromJson(historyMap);
      return history;
    } else {
      throw Exception('No history found');
    }
  }
}

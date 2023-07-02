import 'package:app_drink_arena/models/history.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class HistoryRepository {
  Future<List<History>> getHistory() async {
    await dotenv.load(fileName: ".env");
    String baseUrl = dotenv.env['BASE_URL'].toString();

    // var url = Uri.parse('$baseUrl/history');
    // var response = await http.get(url);
    // print('Response status: ${response.statusCode}');
    // print('Response body: ${response.body}');
    // if (response.statusCode == 200) {
    //   List<dynamic> historyMap = jsonDecode(response.body);
    //   List<History> history =
    //       historyMap.map((history) => History.fromJson(history)).toList();
    //   return history;
    // } else {
    return [];
    // }
  }
}

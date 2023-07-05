import 'dart:convert';
import 'package:app_drink_arena/models/pledge.dart';
import 'package:app_drink_arena/repositories/user_repository.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;

class PledgeRepository {
  final UserRepository _userRepository = UserRepository();

  Future<void> createPledge(String pledge) async {
    String baseUrl = dotenv.env['BASE_URL'].toString();

    var url = Uri.parse('$baseUrl/pledge');
    var response = await http.post(
      url,
      headers: <String, String>{
        'Content-Type': 'application/json',
        'Authorization': 'Bearer ${await _userRepository.getToken()}'
      },
      body: jsonEncode({'title': pledge}),
    );
    print('Response status: ${response.statusCode}');
    print('Response body: ${response.body}');
  }

  Future<List<Pledge>> getPledges() async {
    String baseUrl = dotenv.env['BASE_URL'].toString();

    var url = Uri.parse('$baseUrl/pledge/me');
    var response = await http.get(
      url,
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Bearer ${await _userRepository.getToken()}'
      },
    );
    print('Response status: ${response.statusCode}');
    print('Response body: ${response.body}');

    if (response.statusCode == 200) {
      List<Pledge> pledges = [];
      List<dynamic> pledgesJson = jsonDecode(response.body);
      print(pledgesJson);
      if (pledgesJson.isEmpty) return pledges;
      for (var pledge in pledgesJson) {
        pledges.add(Pledge(
            id: pledge['id'],
            title: pledge['title'],
            type: pledge['type'],
            created_at: DateTime.parse(pledge['created_at'])));
      }
      return pledges;
    } else {
      throw Exception('No pledges found');
    }
  }

  Future<void> deletePledge(int pledgeId) async {
    String baseUrl = dotenv.env['BASE_URL'].toString();

    var url = Uri.parse('$baseUrl/pledge/$pledgeId');
    var response = await http.delete(url, headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
      'Authorization': 'Bearer ${await _userRepository.getToken()}'
    });
    print('Response status: ${response.statusCode}');
    print('Response body: ${response.body}');
  }
}

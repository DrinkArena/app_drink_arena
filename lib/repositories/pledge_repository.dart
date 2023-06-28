import 'dart:convert';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'dart:ffi';

class PledgeRepository {
  Future<void> createPledge(String pledge) async {
    String baseUrl = dotenv.env['BASE_URL'].toString();

    var url = Uri.parse('$baseUrl/pledge');
    var response = await http.post(
      url,
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(pledge),
    );
    print('Response status: ${response.statusCode}');
    print('Response body: ${response.body}');
  }

  Future<List<String>> getPledges() async {
    await dotenv.load(fileName: ".env");
    String baseUrl = dotenv.env['BASE_URL'].toString();

    var url = Uri.parse('$baseUrl/pledge/me');
    var response = await http.get(url);
    print('Response status: ${response.statusCode}');
    print('Response body: ${response.body}');

    if (response.statusCode == 200) {
      List<String> pledges = [];
      List<dynamic> pledgesJson = jsonDecode(response.body)['pledges'];
      pledgesJson.forEach((pledge) {
        pledges.add(pledge);
      });
      return pledges;
    } else {
      throw Exception('No pledges found');
    }
  }

  Future<void> deletePledge(String pledgeId) async {
    String baseUrl = dotenv.env['BASE_URL'].toString();

    var url = Uri.parse('$baseUrl/pledge/$pledgeId');
    var response = await http.delete(url);
    print('Response status: ${response.statusCode}');
    print('Response body: ${response.body}');
  }
}

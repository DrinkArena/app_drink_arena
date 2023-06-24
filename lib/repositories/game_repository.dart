import 'dart:convert';
import 'dart:ffi';

import 'package:app_drink_arena/models/game.dart';
import 'package:app_drink_arena/models/player.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class GameRepository {
  Future createRoom(String name) async {
    await dotenv.load(fileName: ".env");
    String baseUrl = dotenv.env['BASE_URL'].toString();
    var url = Uri.parse('$baseUrl/room');
    var response = await http.post(
      url,
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(name),
    );
    print('Response status: ${response.statusCode}');
    print('Response body: ${response.body}');
    if (response.statusCode == 200) {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      Game game = Game.fromJson(jsonDecode(response.body));
      prefs.setString('room', game.id.toString());
    }
  }

  Future joinRoom(Int64 idRoom) async {
    await dotenv.load(fileName: ".env");
    String baseUrl = dotenv.env['BASE_URL'].toString();
    var url = Uri.parse('$baseUrl/room/$idRoom');
    var response = await http.post(url,
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(idRoom));
    print('Response status: ${response.statusCode}');
    print('Response body: ${response.body}');
    if (response.statusCode == 200) {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      Game game = Game.fromJson(jsonDecode(response.body));
      prefs.setString('room', game.id.toString());
    }
  }

  Future<List<Player>> getRoom() async {
    await dotenv.load(fileName: ".env");
    String baseUrl = dotenv.env['BASE_URL'].toString();

    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? roomString = prefs.getString('room');

    var url = Uri.parse('$baseUrl/room/$roomString');
    var response = await http.get(url);
    print('Response status: ${response.statusCode}');
    print('Response body: ${response.body}');

    if (response.statusCode == 200) {
      List<dynamic> players = jsonDecode(response.body)['participants'];
      List<dynamic> playerOwner = jsonDecode(response.body)['owner'];

      List<Player> playersList = [];
      players.forEach((element) {
        playersList.add(Player.fromJson(element));
      });

      playersList.forEach((element) {
        if (element.id == playerOwner[0]['id']) {
          element.isOwner = true;
        }
      });
      prefs.setString('OwnerId', playerOwner[0]['id']);

      return playersList;
    } else {
      throw Exception('No room found');
    }
  }

  Future<String> startGame() async {
    await dotenv.load(fileName: ".env");
    String baseUrl = dotenv.env['BASE_URL'].toString();

    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? roomString = prefs.getString('room');

    var url = Uri.parse('$baseUrl/room/$roomString/pledge/next');
    var response = await http.get(url);
    print('Response status: ${response.statusCode}');
    print('Response body: ${response.body}');

    if (response.statusCode == 200) {
      String pledge = jsonDecode(response.body)['pledge'];
      return pledge;
    } else {
      throw Exception('No room found');
    }
  }

  Future<void> leaveGame() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.remove('room');
    prefs.remove('OwnerId');
  }
}

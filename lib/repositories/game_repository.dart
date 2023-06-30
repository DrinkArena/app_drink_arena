import 'dart:convert';
import 'dart:ffi';

import 'package:app_drink_arena/models/game.dart';
import 'package:app_drink_arena/models/player.dart';
import 'package:app_drink_arena/models/user.dart';
import 'package:app_drink_arena/repositories/user_repository.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class GameRepository {
  final UserRepository _userRepository = UserRepository();

  Future createRoom(String name) async {
    String baseUrl = dotenv.env['BASE_URL'].toString();
    var url = Uri.parse('$baseUrl/room');
    var response = await http.post(
      url,
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Bearer ${await _userRepository.getToken()}'
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

  Future joinRoom(int idRoom) async {
    String baseUrl = dotenv.env['BASE_URL'].toString();
    var url = Uri.parse('$baseUrl/room/$idRoom/join');
    var response = await http.post(url,
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': 'Bearer ${await _userRepository.getToken()}'
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

  Future leaveRoom() async {
    String baseUrl = dotenv.env['BASE_URL'].toString();

    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? roomId = prefs.getString('room');

    var url = Uri.parse('$baseUrl/room/$roomId/leave');
    var response = await http.post(
      url,
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Bearer ${await _userRepository.getToken()}'
      },
    );
    print('Response status: ${response.statusCode}');
    print('Response body: ${response.body}');
    if (response.statusCode == 200) {
      prefs.remove('room');
      prefs.remove('OwnerId');
    }
  }

  Future<List<Player>> getRoom() async {
    String baseUrl = dotenv.env['BASE_URL'].toString();

    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? roomId = prefs.getString('room');

    var url = Uri.parse('$baseUrl/room/$roomId');
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
    String baseUrl = dotenv.env['BASE_URL'].toString();
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? roomId = prefs.getString('room');

    var url = Uri.parse('$baseUrl/room/$roomId/pledge/next');
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
      String pledge = jsonDecode(response.body)['pledge'];
      return pledge;
    } else {
      throw Exception('La partie n\'a pas pu commencer');
    }
  }

  Future<void> leaveGame() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.remove('room');
    prefs.remove('OwnerId');
  }
}

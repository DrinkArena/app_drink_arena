import 'dart:convert';
import 'dart:ffi';

import 'package:app_drink_arena/helpers/handle_error.dart';
import 'package:app_drink_arena/models/game.dart';
import 'package:app_drink_arena/models/player.dart';
import 'package:app_drink_arena/models/user.dart';
import 'package:app_drink_arena/repositories/user_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

/**
 * Repository for the game
 * 
 * @see Game
 * @see UserRepository
 * @see Player
 * @see User
 * @see HandleError
 */
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
      body: jsonEncode({'name': name}),
    );
    print('Response status: ${response.statusCode}');
    print('Response body: ${response.body}');
    if (response.statusCode == 201) {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      Game game = Game.fromJson(jsonDecode(response.body));
      prefs.setInt('room', game.id!);
    }
  }

  Future<bool> isOwner() async {
    UserRepository userRepository = UserRepository();
    userRepository.saveIdUser();
    SharedPreferences prefs = await SharedPreferences.getInstance();
    int? ownerId = prefs.getInt('ownerId');
    int? userId = prefs.getInt('userId');
    if (ownerId == userId) {
      return true;
    } else {
      return false;
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
        body: jsonEncode({'id': idRoom}));
    print('Response status: ${response.statusCode}');
    print('Response body: ${response.body}');
    if (response.statusCode == 200) {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      Game game = Game.fromJson(jsonDecode(response.body));
      prefs.setInt('room', game.id!);
    }
  }

  Future leaveGame() async {
    String baseUrl = dotenv.env['BASE_URL'].toString();

    SharedPreferences prefs = await SharedPreferences.getInstance();
    int? roomId = prefs.getInt('room');

    if (roomId == null) {
      print('Room ID is null');
      return;
    }
    var url = Uri.parse('$baseUrl/room/$roomId/leave');
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
      prefs.remove('room');
      prefs.remove('ownerId');
    }
  }

  Future<List<Player>> getRoom() async {
    String baseUrl = dotenv.env['BASE_URL'].toString();

    SharedPreferences prefs = await SharedPreferences.getInstance();
    int? roomId = prefs.getInt('room');

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
      dynamic playerOwner = jsonDecode(response.body)['owner'];

      List<Player> playersList = [];
      players.forEach((element) {
        playersList.add(Player.fromJson(element));
      });

      playersList.forEach((element) {
        if (element.id == playerOwner['id']) {
          element.isOwner = true;
        }
      });

      prefs.setInt('ownerId', playerOwner['id']);

      return playersList;
    } else {
      throw Exception(response.statusCode);
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
      throw Exception(response.statusCode);
    }
  }

  Future<int> getRoomId() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    int? roomId = prefs.getInt('room');
    if (roomId != null) {
      return roomId;
    } else {
      throw Exception('Room ID is null');
    }
  }

  Widget errorOnRoom(int statusCode, BuildContext context) {
    final HandleError handleError = HandleError();
    return handleError.errorOnRoom(statusCode, context);
  }
}

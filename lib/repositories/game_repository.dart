import 'dart:convert';

import 'package:app_drink_arena/helpers/handle_error.dart';
import 'package:app_drink_arena/models/game.dart';
import 'package:app_drink_arena/models/player.dart';
import 'package:app_drink_arena/repositories/user_repository.dart';
import 'package:flutter/material.dart';
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
      body: jsonEncode({'name': name}),
    );
    // print('Response status: ${response.statusCode}');
    // print('Response body: ${response.body}');
    if (response.statusCode == 201) {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      Game game = Game.fromJson(jsonDecode(response.body));
      prefs.setInt('room', game.id!);
      prefs.setBool('isOwner', true);
    }
  }

  Future<bool> isOwner() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getBool('isOwner') ?? false;
  }

  Future joinRoom(int roomId) async {
    String baseUrl = dotenv.env['BASE_URL'].toString();

    var url = Uri.parse('$baseUrl/room/$roomId/join');
    var response = await http.get(
      url,
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Bearer ${await _userRepository.getToken()}'
      },
    );
    print('--------------------------');
    print(url);
    print('Response status: ${response.statusCode}');
    print('Response body: ${response.body}');
    if (response.statusCode == 200) {
      SharedPreferences prefs = await SharedPreferences.getInstance();

      prefs.setInt('room', roomId);
      prefs.setBool('isOwner', false);
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
    } else if (response.statusCode == 404) {
      prefs.remove('room');
      prefs.remove('ownerId');
    }
  }

  Future<List<Player>> getRoom() async {
    String baseUrl = dotenv.env['BASE_URL'].toString();

    SharedPreferences prefs = await SharedPreferences.getInstance();
    int? roomId = prefs.getInt('room');

    if (roomId == null) {
      print('Room ID is null');
      return [];
    }

    var url = Uri.parse('$baseUrl/room/$roomId');
    // var sseUrl = '$mercureUrl/.well-known/mercure?topic=$url';
    // SSEClient.subscribeToSSE(
    //   url: sseUrl,
    //   header: <String, String>{
    //     "Accept": "text/event-stream",
    //     "Cache-Control": "no-cache",
    //   },
    // ).listen((event) {
    //   print('Id: ' + event.id!);
    //   print('Event: ' + event.event!);
    //   print('Data: ' + event.data!);
    // });
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
      for (var element in players) {
        playersList.add(Player.fromJson(element));
      }

      for (var element in playersList) {
        if (element.id == playerOwner['id']) {
          element.isOwner = true;
        }
      }

      prefs.setInt('ownerId', playerOwner['id']);

      return playersList;
    } else {
      throw Exception(response.statusCode);
    }
  }

  Future<String> getState() async {
    String baseUrl = dotenv.env['BASE_URL'].toString();

    SharedPreferences prefs = await SharedPreferences.getInstance();
    int? roomId = prefs.getInt('room');

    if (roomId == null) {
      print('Room ID is null');
      return '';
    }

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
      String state = jsonDecode(response.body)['state'];
      return state;
    } else {
      throw Exception(response.statusCode);
    }
  }

  Future<String> startGame() async {
    String baseUrl = dotenv.env['BASE_URL'].toString();
    SharedPreferences prefs = await SharedPreferences.getInstance();
    int? roomId = prefs.getInt('room');

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
      String pledge = jsonDecode(response.body)['title'];
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

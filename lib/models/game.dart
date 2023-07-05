import 'package:app_drink_arena/models/pledge.dart';

class Game {
  final int? id;
  final String? name;
  final Owner? owner;
  final String? state;
  final DateTime? created_at;
  final Pledge? current_pledge;

  Game(
      {this.name,
      this.id,
      this.owner,
      this.state,
      this.created_at,
      this.current_pledge});

  factory Game.fromJson(Map<String, dynamic> json) {
    return Game(
      id: json['id'],
      name: json['name'],
      owner: Owner.fromJson(json['owner']),
      state: json['state'],
      created_at: DateTime.parse(json['created_at']),
      current_pledge: json['current_pledge'] != null
          ? Pledge.fromJson(json['current_pledge'])
          : null,
    );
  }
}

class Owner {
  final int? id;
  final String? username;
  final String? created_at;

  Owner({this.id, this.username, this.created_at});

  factory Owner.fromJson(Map<String, dynamic> json) {
    return Owner(
      id: json['id'],
      username: json['username'],
      created_at: json['created_at'],
    );
  }
}

import 'dart:ffi';

class Game {
  final String? name;
  final Int64? id;

  Game({this.name, this.id});

  factory Game.fromJson(Map<String, dynamic> json) {
    return Game(
      name: json['name'],
      id: json['id'],
    );
  }
}

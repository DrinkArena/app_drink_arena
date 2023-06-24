import 'dart:ffi';

class Player {
  Int64? id;
  String? username;
  bool? isOwner;

  Player({this.id, this.username, this.isOwner});
  factory Player.fromJson(Map<String, dynamic> json) {
    return Player(
      id: json['id'],
      username: json['username'],
      isOwner: false,
    );
  }
}

import 'dart:ffi';

class Pledge {
  int? id;
  String? title;
  String? type;
  DateTime? createdAt;

  Pledge({this.id, this.title, this.type, this.createdAt});

  factory Pledge.fromJson(Map<String, dynamic> json) {
    return Pledge(
      id: json['id'],
      title: json['title'],
      type: json['type'],
      createdAt: DateTime.parse(json['createdAt']),
    );
  }
}

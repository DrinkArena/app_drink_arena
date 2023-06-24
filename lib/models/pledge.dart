import 'dart:ffi';

class Pledge {
  Int64? id;
  String? title;

  Pledge({this.id, this.title});

  factory Pledge.fromJson(Map<String, dynamic> json) {
    return Pledge(
      id: json['id'],
      title: json['title'],
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'title': title,
      };
}

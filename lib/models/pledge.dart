class Pledge {
  int? id;
  String? title;
  String? type;
  DateTime? created_at;

  Pledge({this.id, this.title, this.type, this.created_at});

  factory Pledge.fromJson(Map<String, dynamic> json) {
    return Pledge(
      id: json['id'],
      title: json['title'],
      type: json['type'],
      created_at: DateTime.parse(json['created_at']),
    );
  }
}

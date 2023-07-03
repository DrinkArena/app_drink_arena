class History {
  final int id;
  final String name;
  final Owner owner;
  final String state;
  final DateTime created_at;

  History(
      {required this.id,
      required this.name,
      required this.owner,
      required this.state,
      required this.created_at});

  factory History.fromJson(Map<String, dynamic> json) {
    return History(
      id: json['id'],
      name: json['name'],
      owner: Owner.fromJson(json['owner']),
      state: json['state'],
      created_at: DateTime.parse(json['created_at']),
    );
  }
}

class Owner {
  final int id;
  final String username;

  Owner({required this.id, required this.username});

  factory Owner.fromJson(Map<String, dynamic> json) {
    return Owner(
      id: json['id'],
      username: json['username'],
    );
  }
}

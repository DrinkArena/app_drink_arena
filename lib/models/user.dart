class User {
  final String pseudo;
  final String email;
  final String password;

  User({required this.pseudo, required this.email, required this.password});

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      pseudo: json['pseudo'],
      email: json['email'],
      password: json['password'],
    );
  }

  Map<String, dynamic> toJson() => {
        'pseudo': pseudo,
        'email': email,
        'password': password,
      };
}

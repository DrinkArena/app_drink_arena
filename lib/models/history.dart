class History {
  final DateTime date;
  final int amount;

  History({required this.date, required this.amount});

  factory History.fromJson(Map<String, dynamic> json) {
    return History(
      date: json['date'],
      amount: json['amount'],
    );
  }
}

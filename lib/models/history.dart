import 'dart:ffi';

class History {
  final DateTime date;
  final Int64 amount;

  History({required this.date, required this.amount});

  factory History.fromJson(Map<String, dynamic> json) {
    return History(
      date: json['date'],
      amount: json['amount'],
    );
  }
}

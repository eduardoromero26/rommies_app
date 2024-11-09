import 'package:cloud_firestore/cloud_firestore.dart';

class ExpenseModel {
  final String id;
  final String title;
  final String? description;
  final double amount;
  final String houseId;
  final String userId;
  final DateTime date;
  final int type;

  ExpenseModel(
      {required this.id,
      required this.title,
      this.description,
      required this.amount,
      required this.houseId,
      required this.userId,
      required this.date,
      required this.type});

  factory ExpenseModel.fromJson(Map<String, dynamic> json) {
    return ExpenseModel(
      id: json['id'],
      title: json['title'],
      description: json['description'],
      amount: json['amount'],
      houseId: json['houseId'],
      userId: json['userId'],
      type: json['type'],
      date: (json['date'] as Timestamp).toDate(),
    );
  }

  Map<String, dynamic> toDocument() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'amount': amount,
      'houseId': houseId,
      'userId': userId,
      'date': Timestamp.fromDate(date),
      'type': type,
    };
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'amount': amount,
      'houseId': houseId,
      'userId': userId,
      'type': type,
      'date': Timestamp.fromDate(date),
    };
  }

  ExpenseModel copyWith({
    String? id,
    String? title,
    String? description,
    double? amount,
    String? houseId,
    String? userId,
    DateTime? date,
    int? type,
  }) {
    return ExpenseModel(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      amount: amount ?? this.amount,
      houseId: houseId ?? this.houseId,
      userId: userId ?? this.userId,
      date: date ?? this.date,
      type: type ?? this.type,
    );
  }
}

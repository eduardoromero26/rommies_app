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
      date: DateTime.parse(
        json['date'],
      ),
    );
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
      'date': date.toIso8601String(),
    };
  }
}

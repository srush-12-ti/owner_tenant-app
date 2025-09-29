class Bill {
  final int id;
  final int userId;
  final double amount;
  final DateTime dueDate;
  final String status;

  Bill({
    required this.id,
    required this.userId,
    required this.amount,
    required this.dueDate,
    required this.status,
  });

  factory Bill.fromJson(Map<String, dynamic> json) {
    return Bill(
      id: json['id'],
      userId: json['user_id'],
      amount: double.parse(json['amount'].toString()),
      dueDate: DateTime.parse(json['due_date']),
      status: json['status'],
    );
  }
}
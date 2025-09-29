class Payment {
  final int id;
  final int billId;
  final double amountPaid;
  final DateTime paymentDate;

  Payment({
    required this.id,
    required this.billId,
    required this.amountPaid,
    required this.paymentDate,
  });

  factory Payment.fromJson(Map<String, dynamic> json) {
    return Payment(
      id: json['id'],
      billId: json['bill_id'],
      amountPaid: double.parse(json['amount_paid'].toString()),
      paymentDate: DateTime.parse(json['payment_date']),
    );
  }
}
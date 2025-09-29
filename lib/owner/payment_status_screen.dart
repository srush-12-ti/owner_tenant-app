import 'package:flutter/material.dart';

class PaymentScreenStatus extends StatelessWidget {
  final List<Map<String, dynamic>> paymentData = [
    {
      "tenantName": "Riya Sharma",
      "month": "August 2025",
      "status": "Paid",
    },
    {
      "tenantName": "Aarav Patel",
      "month": "August 2025",
      "status": "Unpaid",
    },
    {
      "tenantName": "Ishita Mehra",
      "month": "August 2025",
      "status": "Paid",
    },
  ];

  Color _getStatusColor(String status) {
    switch (status.toLowerCase()) {
      case 'paid':
        return Colors.green;
      case 'unpaid':
        return Colors.red;
      case 'pending':
        return Colors.orange;
      default:
        return Colors.grey;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Payment Status"),
      ),
      body: ListView.builder(
        itemCount: paymentData.length,
        itemBuilder: (context, index) {
          final payment = paymentData[index];
          return Card(
            margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            child: ListTile(
              leading: Icon(
                Icons.account_circle,
                size: 40,
              ),
              title: Text(payment["tenantName"]),
              subtitle: Text("Month: ${payment["month"]}"),
              trailing: Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                decoration: BoxDecoration(
                  color: _getStatusColor(payment["status"]).withOpacity(0.2),
                  border: Border.all(color: _getStatusColor(payment["status"])),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Text(
                  payment["status"],
                  style: TextStyle(
                    color: _getStatusColor(payment["status"]),
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

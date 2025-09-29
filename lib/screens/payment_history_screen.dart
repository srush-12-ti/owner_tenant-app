import 'package:flutter/material.dart';
import 'package:flutter_projects/api/payment_service.dart';
import 'package:flutter_projects/models/payment.dart';
import 'package:flutter_projects/screens/payment_history_screen.dart';

class PaymentHistoryScreen extends StatefulWidget {
  const PaymentHistoryScreen({Key? key}) : super(key: key);

  @override
  _PaymentHistoryScreenState createState() => _PaymentHistoryScreenState();
}

class _PaymentHistoryScreenState extends State<PaymentHistoryScreen> {
  late Future<List<Payment>> futurePayments;

  @override
  void initState() {
    super.initState();
    futurePayments = PaymentService().fetchPayments();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Payment History'),
      ),
      body: Center(
        child: FutureBuilder<List<Payment>>(
          future: futurePayments,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const CircularProgressIndicator();
            } else if (snapshot.hasError) {
              return Text('Error: ${snapshot.error}');
            } else if (snapshot.hasData) {
              return ListView.builder(
                itemCount: snapshot.data!.length,
                itemBuilder: (context, index) {
                  final payment = snapshot.data![index];
                  return Card(
                    child: ListTile(
                      title: Text('Payment ID: ${payment.id}'),
                      subtitle: Text(
                        'Amount: \$${payment.amountPaid.toStringAsFixed(2)} on ${payment.paymentDate.toLocal()}',
                      ),
                    ),
                  );
                },
              );
            } else {
              return const Text('No payments found.');
            }
          },
        ),
      ),
    );
  }
}
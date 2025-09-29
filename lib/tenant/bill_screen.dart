import 'package:flutter/material.dart';
import 'package:flutter_projects/api/bill_service.dart';
import 'package:flutter_projects/models/bill.dart';

class BillScreen extends StatefulWidget {
  const BillScreen({Key? key}) : super(key: key);

  @override
  _BillScreenState createState() => _BillScreenState();
}

class _BillScreenState extends State<BillScreen> {
  late Future<List<Bill>> futureBills;

  @override
  void initState() {
    super.initState();
    futureBills = BillService().fetchBills();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('My Bills'),
      ),
      body: Center(
        child: FutureBuilder<List<Bill>>(
          future: futureBills,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const CircularProgressIndicator();
            } else if (snapshot.hasError) {
              return Text('Error: ${snapshot.error}');
            } else if (snapshot.hasData) {
              return ListView.builder(
                itemCount: snapshot.data!.length,
                itemBuilder: (context, index) {
                  final bill = snapshot.data![index];
                  return Card(
                    child: ListTile(
                      title: Text('Bill ID: ${bill.id}'),
                      subtitle: Text('Amount: \$${bill.amount.toStringAsFixed(2)}'),
                      trailing: Text(
                        bill.status,
                        style: TextStyle(
                          color: bill.status == 'unpaid' ? Colors.red : Colors.green,
                        ),
                      ),
                    ),
                  );
                },
              );
            } else {
              return const Text('No bills found.');
            }
          },
        ),
      ),
    );
  }
}
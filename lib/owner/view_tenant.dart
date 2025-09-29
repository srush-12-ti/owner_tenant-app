import 'package:flutter/material.dart';

class ViewTenantPage extends StatelessWidget {
  final List<Map<String, String>> tenants = [
    {
      'name': 'John Doe',
      'floor': '2nd',
      'flat': '201',
      'bhk': '2BHK',
      'status': 'Paid',
    },
    {
      'name': 'Alice Smith',
      'floor': '3rd',
      'flat': '301',
      'bhk': '3BHK',
      'status': 'Unpaid',
    },
    {
      'name': 'Rahul Mehta',
      'floor': '1st',
      'flat': '102',
      'bhk': '1BHK',
      'status': 'Paid',
    },
    {
      'name': 'Nisha Rao',
      'floor': 'Ground',
      'flat': 'G01',
      'bhk': '2BHK',
      'status': 'Overdue',
    },
  ];

  Color getStatusColor(String status) {
    switch (status.toLowerCase()) {
      case 'paid':
        return Colors.green;
      case 'unpaid':
        return Colors.red;
      case 'overdue':
        return Colors.orange;
      default:
        return Colors.grey;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('View Tenants'),
        centerTitle: true,
        backgroundColor: Colors.blueGrey.shade800,
      ),
      body: ListView.builder(
        itemCount: tenants.length,
        itemBuilder: (context, index) {
          final tenant = tenants[index];
          return Card(
            margin: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
            elevation: 3,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            child: ListTile(
              contentPadding: EdgeInsets.all(16),
              title: Text(
                tenant['name'] ?? '',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 4),
                  Text('Floor: ${tenant['floor']}'),
                  Text('Flat No: ${tenant['flat']}'),
                  Text('Type: ${tenant['bhk']}'),
                ],
              ),
              trailing: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    tenant['status'] ?? 'Unknown',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: getStatusColor(tenant['status'] ?? ''),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

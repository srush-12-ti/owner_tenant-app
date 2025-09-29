import 'package:flutter/material.dart';
import 'package:flutter_projects/owner/add_tenant_screen.dart';
import 'package:flutter_projects/api/message_service.dart';
import 'package:flutter_projects/models/message.dart';

class OwnerDashboard extends StatefulWidget {
  const OwnerDashboard({Key? key}) : super(key: key);

  @override
  _OwnerDashboardState createState() => _OwnerDashboardState();
}

class _OwnerDashboardState extends State<OwnerDashboard> {
  final List<Map<String, dynamic>> _tenants = [
    {'name': 'Ramnath', 'apartment': 'A-101', 'bhk': 2, 'status': 'Paid'},
    {'name': 'Shiv Shankar', 'apartment': 'B-202', 'bhk': 3, 'status': 'Unpaid'},
    {'name': 'Srushti', 'apartment': 'C-303', 'bhk': 1, 'status': 'Overdue'},
  ];

  late Future<List<Message>> futureMessages;

  @override
  void initState() {
    super.initState();
    futureMessages = MessageService().fetchMessages();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Padding(
          padding: const EdgeInsets.only(left: 12.0),
          child: Image.asset('assets/images/logo.png'),
        ),
        title: const Text("Owner Dashboard"),
        backgroundColor: Colors.deepPurple,
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () {
              Navigator.of(context)
                  .pushNamedAndRemoveUntil('/login', (Route<dynamic> route) => false);
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              // Add Tenant Button
              ElevatedButton.icon(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const AddTenantScreen(),
                    ),
                  );
                },
                icon: const Icon(Icons.person_add),
                label: const Text("Add Tenant"),
                style: ElevatedButton.styleFrom(
                  minimumSize: const Size.fromHeight(50),
                ),
              ),
              const SizedBox(height: 20),
              // Tenant List
              ListView.builder(
                shrinkWrap: true, // This is crucial for a nested ListView
                physics: const NeverScrollableScrollPhysics(), // Prevents scrolling issues
                itemCount: _tenants.length,
                itemBuilder: (context, index) {
                  final tenant = _tenants[index];
                  final isUnpaid = tenant['status'] == 'Unpaid' || tenant['status'] == 'Overdue';
                  return Card(
                    margin: const EdgeInsets.symmetric(vertical: 8),
                    child: ListTile(
                      leading: const Icon(Icons.account_circle, size: 40),
                      title: Text("Tenant Name: ${tenant['name']}"),
                      subtitle: Text("Apartment: ${tenant['apartment']} | BHK: ${tenant['bhk']}"),
                      trailing: isUnpaid
                          ? Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            tenant['status'],
                            style: TextStyle(
                              color: tenant['status'] == 'Overdue' ? Colors.red : Colors.orange,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(width: 8),
                          IconButton(
                            icon: const Icon(Icons.notifications_active, color: Colors.orange),
                            onPressed: () {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(content: Text("Reminder sent to ${tenant['name']}")),
                              );
                            },
                          ),
                        ],
                      )
                          : Text(
                        tenant['status'],
                        style: const TextStyle(color: Colors.green, fontWeight: FontWeight.bold),
                      ),
                      onTap: () {},
                    ),
                  );
                },
              ),
              const SizedBox(height: 20),
              // Message Box
              Card(
                elevation: 4,
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      const Text(
                        'Messages from Tenants',
                        style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 10),
                      FutureBuilder<List<Message>>(
                        future: futureMessages,
                        builder: (context, snapshot) {
                          if (snapshot.connectionState == ConnectionState.waiting) {
                            return const Center(child: CircularProgressIndicator());
                          } else if (snapshot.hasError) {
                            return Center(child: Text('Error: ${snapshot.error}'));
                          } else if (snapshot.hasData && snapshot.data!.isNotEmpty) {
                            return ListView.builder(
                              shrinkWrap: true, // This is crucial
                              physics: const NeverScrollableScrollPhysics(), // Prevents scrolling issues
                              itemCount: snapshot.data!.length,
                              itemBuilder: (context, index) {
                                final message = snapshot.data![index];
                                return ListTile(
                                  title: Text(message.content),
                                  subtitle: Text('Sent: ${message.timestamp.toLocal()}'),
                                );
                              },
                            );
                          }
                          return const Center(child: Text('No new messages.'));
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
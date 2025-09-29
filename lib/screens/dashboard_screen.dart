import 'package:flutter/material.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Dashboard"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Expanded(
              child: Card(
                child: ListTile(
                  title: Text("Owner Login"),
                  subtitle: Text("Access billing, tenants & reminders"),
                  trailing: ElevatedButton(
                    onPressed: () {
                      Navigator.pushNamed(context, '/ownerLogin');
                    },
                    child: Text("Login"),
                  ),
                ),
              ),
            ),
            Expanded(
              child: Card(
                child: ListTile(
                  title: Text("Tenant Login"),
                  subtitle: Text("View bills & pay"),
                  trailing: ElevatedButton(
                    onPressed: () {
                      Navigator.pushNamed(context, '/tenantLogin');
                    },
                    child: Text("Login"),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

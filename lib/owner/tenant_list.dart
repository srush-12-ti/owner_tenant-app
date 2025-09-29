import 'package:flutter/material.dart';

class Tenant {
  final String name;
  final String apartment;
  final String bhk;
  final String floor;

  Tenant({required this.name, required this.apartment, required this.bhk, required this.floor});
}

class TenantList extends StatelessWidget {
  final List<Tenant> tenants;

  TenantList({required this.tenants});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Tenant List'),
      ),
      body: ListView.builder(
        itemCount: tenants.length,
        itemBuilder: (context, index) {
          final tenant = tenants[index];
          return Card(
            child: ListTile(
              title: Text(tenant.name),
              subtitle: Text(
                'Apartment: ${tenant.apartment}, BHK: ${tenant.bhk}, Floor: ${tenant.floor}',
              ),
            ),
          );
        },
      ),
    );
  }
}

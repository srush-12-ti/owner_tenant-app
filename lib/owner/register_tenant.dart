import 'package:flutter/material.dart';

class RegisterTenant extends StatefulWidget {
  @override
  _RegisterTenantState createState() => _RegisterTenantState();
}

class _RegisterTenantState extends State<RegisterTenant> {
  final _formKey = GlobalKey<FormState>();
  String name = '';
  String apartment = '';
  String bhk = '';
  String floor = '';

  void _registerTenant() {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      // Here, call your backend or local storage method to save the tenant data
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Tenant "$name" registered successfully!')),
      );
      Navigator.pop(context); // Navigate back after registration
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Register Tenant'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                decoration: InputDecoration(labelText: 'Name'),
                onSaved: (value) => name = value ?? '',
                validator: (value) =>
                value!.isEmpty ? 'Please enter name' : null,
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'Apartment'),
                onSaved: (value) => apartment = value ?? '',
                validator: (value) =>
                value!.isEmpty ? 'Please enter apartment name' : null,
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'BHK'),
                onSaved: (value) => bhk = value ?? '',
                validator: (value) =>
                value!.isEmpty ? 'Please enter BHK' : null,
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'Floor'),
                onSaved: (value) => floor = value ?? '',
                validator: (value) =>
                value!.isEmpty ? 'Please enter floor' : null,
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: _registerTenant,
                child: Text('Register Tenant'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

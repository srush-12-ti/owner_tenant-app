import 'package:flutter/material.dart';

class TenantLogin extends StatefulWidget {
  const TenantLogin({super.key});

  @override
  _TenantLoginState createState() => _TenantLoginState();
}

class _TenantLoginState extends State<TenantLogin> {
  final TextEditingController _apartmentNameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  void _loginTenant() {
    String apartment = _apartmentNameController.text.trim();
    String password = _passwordController.text.trim();

    if (apartment == 'tenant' && password == 'tenant123') {
      Navigator.pushNamed(context, '/tenantDashboard');
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Invalid tenant credentials')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Tenant Login'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          children: [
            SizedBox(height: 40),
            TextField(
              controller: _apartmentNameController,
              decoration: InputDecoration(
                labelText: 'Apartment Name',
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.home),
              ),
            ),
            SizedBox(height: 20),
            TextField(
              controller: _passwordController,
              obscureText: true,
              decoration: InputDecoration(
                labelText: 'Password',
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.lock),
              ),
            ),
            SizedBox(height: 30),
            ElevatedButton(
              onPressed: _loginTenant,
              style: ElevatedButton.styleFrom(
                padding: EdgeInsets.symmetric(horizontal: 32, vertical: 16),
              ),
              child: Text('Login as Tenant'),
            ),
          ],
        ),
      ),
    );
  }
}

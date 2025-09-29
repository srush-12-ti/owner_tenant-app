// lib/main.dart
import 'package:flutter/material.dart';

import 'owner/owner_dashboard.dart';
import 'tenant/tenant_dashboard.dart';
import 'package:flutter/material.dart';
import 'package:flutter_projects/api/bill_service.dart';
import 'package:flutter_projects/models/bill.dart';
void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Home Secure',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.deepPurple,
        scaffoldBackgroundColor: const Color(0xFFFBF6FF), // A light lavender background
      ),
      // Set the initial route to your new login screen
      initialRoute: '/login',
      // Define the named routes for your app
      routes: {
        '/login': (context) => const LoginScreen(),
        '/ownerDashboard': (context) => const OwnerDashboard(),
        // The TenantDashboard requires a username, which we will pass as an argument
        // Your TenantDashboard code is already set up to handle this!
        '/tenantDashboard': (context) => const TenantDashboard(username: ''),
      },
    );
  }
}

// This is the new LoginScreen that matches your screenshot
class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  // Controllers to get the text from TextFields
  final _usernameController = TextEditingController(text: 'jj'); // Pre-filled for testing
  final _passwordController = TextEditingController(text: '12'); // Pre-filled for testing

  // State for the dropdown menu
  String _selectedRole = 'Owner';
  final List<String> _roles = ['Owner', 'Tenant'];

  void _login() {
    final username = _usernameController.text;
    final password = _passwordController.text;

    // Basic validation
    if (username.isEmpty || password.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please enter username and password')),
      );
      return;
    }

    // Navigate based on the selected role
    if (_selectedRole == 'Owner') {
      // Use pushReplacementNamed to prevent going back to the login screen
      Navigator.of(context).pushReplacementNamed('/ownerDashboard');
    } else if (_selectedRole == 'Tenant') {
      // For the tenant, pass the username as an argument
      Navigator.of(context).pushReplacementNamed(
        '/tenantDashboard',
        arguments: username,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(32.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                'Home Secure Login',
                style: TextStyle(fontSize: 28, fontWeight: FontWeight.w300),
              ),
              const SizedBox(height: 40),
              const Text(
                'Welcome to Home Secure',
                style: TextStyle(fontSize: 22, color: Colors.black54),
              ),
              const SizedBox(height: 40),
              // Username TextField
              TextField(
                controller: _usernameController,
                decoration: const InputDecoration(
                  labelText: 'Username',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 20),
              // Password TextField
              TextField(
                controller: _passwordController,
                obscureText: true,
                decoration: const InputDecoration(
                  labelText: 'Password',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 20),
              // Role Dropdown
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 12.0),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(4.0),
                  border: Border.all(color: Colors.grey),
                ),
                child: DropdownButtonHideUnderline(
                  child: DropdownButton<String>(
                    value: _selectedRole,
                    isExpanded: true,
                    items: _roles.map((String role) {
                      return DropdownMenuItem<String>(
                        value: role,
                        child: Text(role),
                      );
                    }).toList(),
                    onChanged: (String? newValue) {
                      setState(() {
                        _selectedRole = newValue!;
                      });
                    },
                  ),
                ),
              ),
              const SizedBox(height: 30),
              // Login Button
              ElevatedButton(
                onPressed: _login,
                style: ElevatedButton.styleFrom(
                  minimumSize: const Size(double.infinity, 50),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(25),
                  ),
                ),
                child: const Text('Login', style: TextStyle(fontSize: 18)),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
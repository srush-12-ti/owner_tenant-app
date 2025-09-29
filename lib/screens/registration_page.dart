import 'package:flutter/material.dart';

class RegistrationPage extends StatelessWidget {
  final TextEditingController aptNameController = TextEditingController();

  RegistrationPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Register Apartment")),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(
              controller: aptNameController,
              decoration: InputDecoration(labelText: "Apartment Name"),
            ),
            ElevatedButton(
              onPressed: () {
                if (aptNameController.text.isNotEmpty) {
                  Navigator.pushNamed(context, '/signup');
                }
              },
              child: Text("Continue to Sign Up"),
            )
          ],
        ),
      ),
    );
  }
}

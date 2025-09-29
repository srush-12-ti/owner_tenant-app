// lib/tenant/send_message_screen.dart
import 'package:flutter/material.dart';
import 'package:flutter_projects/api/message_service.dart';

class SendMessageScreen extends StatefulWidget {
  const SendMessageScreen({Key? key}) : super(key: key);

  @override
  _SendMessageScreenState createState() => _SendMessageScreenState();
}

class _SendMessageScreenState extends State<SendMessageScreen> {
  final _controller = TextEditingController();
  final _service = MessageService();
  bool _isSending = false;

  void _sendMessage() async {
    if (_controller.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Message cannot be empty.')),
      );
      return;
    }

    setState(() {
      _isSending = true;
    });

    try {
      // Corrected call to sendMessage with all four arguments
      final success = await _service.sendMessage(
        senderId: 1,
        senderType: 'tenant',
        userId: 1, // Change this from 0 to 1
        content: _controller.text,
      );
      if (success) {
        _controller.clear();
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Message sent successfully!')),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to send message: $e')),
      );
    } finally {
      setState(() {
        _isSending = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Send Message to Owner')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _controller,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Write your message...',
              ),
              maxLines: 5,
            ),
            const SizedBox(height: 16),
            _isSending
                ? const CircularProgressIndicator()
                : ElevatedButton(
              onPressed: _sendMessage,
              child: const Text('Send'),
            ),
          ],
        ),
      ),
    );
  }
}
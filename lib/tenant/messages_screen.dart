import 'package:flutter/material.dart';
import 'package:flutter_projects/api/message_service.dart';
import 'package:flutter_projects/models/message.dart';

class MessagesScreen extends StatefulWidget {
  const MessagesScreen({Key? key}) : super(key: key);

  @override
  _MessagesScreenState createState() => _MessagesScreenState();
}

class _MessagesScreenState extends State<MessagesScreen> {
  final _messageController = TextEditingController();
  final _service = MessageService();
  late Future<List<Message>> futureMessages;

  @override
  void initState() {
    super.initState();
    futureMessages = _service.fetchMessages();
  }

  void _sendMessage() async {
    if (_messageController.text.isEmpty) return;

    final messageContent = _messageController.text;
    _messageController.clear();

    try {
      // NOTE: Here we are sending the sender_id and sender_type
      // We are hardcoding sender_id to 1 and sender_type to 'tenant' for now
      await _service.sendMessage(senderId: 1, senderType: 'tenant', userId: 0, content: messageContent);
      setState(() {
        futureMessages = _service.fetchMessages(); // Refresh the messages
      });
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to send message: $e')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Conversation with Owner')),
      body: Column(
        children: [
          Expanded(
            child: FutureBuilder<List<Message>>(
              future: futureMessages,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  return Center(child: Text('Error: ${snapshot.error}'));
                } else if (snapshot.hasData) {
                  return ListView.builder(
                    itemCount: snapshot.data!.length,
                    itemBuilder: (context, index) {
                      final message = snapshot.data![index];
                      final isTenantMessage = message.senderType == 'tenant';
                      return Align(
                        alignment: isTenantMessage ? Alignment.centerRight : Alignment.centerLeft,
                        child: Container(
                          margin: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
                          padding: const EdgeInsets.all(12),
                          decoration: BoxDecoration(
                            color: isTenantMessage ? Colors.blue.shade100 : Colors.grey.shade300,
                            borderRadius: BorderRadius.circular(16),
                          ),
                          child: Text(message.content),
                        ),
                      );
                    },
                  );
                }
                return const Center(child: Text('Start a conversation!'));
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _messageController,
                    decoration: const InputDecoration(
                      hintText: 'Type your message...',
                      border: OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(20))),
                    ),
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.send, color: Colors.green),
                  onPressed: _sendMessage,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
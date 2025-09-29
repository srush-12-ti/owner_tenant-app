import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter_projects/api/api_config.dart';
import 'package:flutter_projects/models/message.dart';

class MessageService {
  Future<List<Message>> fetchMessages() async {
    final response = await http.get(
        Uri.parse('${ApiConfig.baseUrl}/api/messages'));

    if (response.statusCode == 200) {
      List<dynamic> jsonList = json.decode(response.body);
      return jsonList.map((json) => Message.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load messages');
    }
  }

  // New function to send a message to the owner
  // Inside the MessageService class

  Future<bool> sendMessage({
    required int senderId,
    required String senderType,
    required int userId,
    required String content,
  }) async {
    final response = await http.post(
      Uri.parse('${ApiConfig.baseUrl}/api/messages'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, dynamic>{
        'sender_id': senderId,
        'sender_type': senderType,
        'user_id': userId,
        'content': content,
      }),
    );

    if (response.statusCode == 201) {
      return true;
    } else {
      throw Exception('Failed to send message');
    }
  }
}
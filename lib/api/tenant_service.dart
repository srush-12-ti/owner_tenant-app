import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter_projects/api/api_config.dart';

class TenantService {
  Future<bool> addTenant({
    required String username,
    required String email,
    required String password,
  }) async {
    final response = await http.post(
      Uri.parse('${ApiConfig.baseUrl}/api/tenants'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, dynamic>{
        'username': username,
        'email': email,
        'password': password,
      }),
    );
    if (response.statusCode == 201) {
      return true;
    } else {
      throw Exception('Failed to add tenant');
    }
  }
}
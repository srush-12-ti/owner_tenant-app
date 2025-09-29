import 'dart:convert';
import 'package:http/http.dart' as http;
import 'api_config.dart';
import '../models/payment.dart';

class PaymentService {
  Future<List<Payment>> fetchPayments() async {
    final response = await http.get(Uri.parse('${ApiConfig.baseUrl}/api/payments'));

    if (response.statusCode == 200) {
      List<dynamic> jsonList = json.decode(response.body);
      return jsonList.map((json) => Payment.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load payments');
    }
  }
}
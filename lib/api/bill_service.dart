import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter_projects/api/api_config.dart';
import 'package:flutter_projects/models/bill.dart';

class BillService {
  Future<List<Bill>> fetchBills() async {
    final response = await http.get(Uri.parse('${ApiConfig.baseUrl}/api/bills'));

    if (response.statusCode == 200) {
      List<dynamic> jsonList = json.decode(response.body);
      return jsonList.map((json) => Bill.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load bills');
    }
  }
}
import 'package:flutter/material.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';

class RazorpayService {
  late Razorpay _razorpay;

  void init(VoidCallback onSuccess) {
    _razorpay = Razorpay();

    _razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, (_) => onSuccess());
    _razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, (e) => print("Payment error: $e"));
    _razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, (e) => print("External wallet: $e"));
  }

  void pay({required double amount, required String name}) {
    var options = {
      'key': 'rzp_test_YourKeyHere',
      'amount': (amount * 100).toInt(), // Razorpay takes paisa
      'name': name,
      'description': 'Rent Payment',
      'prefill': {'contact': '8888888888', 'email': 'test@example.com'},
    };
    _razorpay.open(options);
  }

  void dispose() {
    _razorpay.clear();
  }
}

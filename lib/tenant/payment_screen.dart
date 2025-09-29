import 'package:flutter/material.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';

class MakePaymentScreen extends StatefulWidget {
  const MakePaymentScreen({Key? key}) : super(key: key);

  @override
  _MakePaymentScreenState createState() => _MakePaymentScreenState();
}

class _MakePaymentScreenState extends State<MakePaymentScreen> {
  late Razorpay _razorpay;

  @override
  void initState() {
    super.initState();
    _razorpay = Razorpay();
    _razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, _handlePaymentSuccess);
    _razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, _handlePaymentError);
    _razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, _handleExternalWallet);
  }

  void _handlePaymentSuccess(PaymentSuccessResponse response) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Payment successful: ${response.paymentId}')),
    );
  }

  void _handlePaymentError(PaymentFailureResponse response) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Payment failed: ${response.message}')),
    );
  }

  void _handleExternalWallet(ExternalWalletResponse response) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('External wallet selected: ${response.walletName}')),
    );
  }

  void openCheckout(double amount) async {
    try {
      var options = {
        'key': '[YOUR_RAZORPAY_KEY_ID]', // Replace this with your actual Key ID
        'amount': (amount * 100).toInt(),
        'name': 'Tenant App',
        'description': 'Bill Payment',
        'prefill': {
          'contact': '9876543210',
          'email': 'test@razorpay.com',
        },
      };
      _razorpay.open(options);
    } catch (e) {
      debugPrint('Error: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Make Payment')),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            openCheckout(500.0); // Example payment of 500
          },
          child: const Text('Pay Now'),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _razorpay.clear();
    super.dispose();
  }
}
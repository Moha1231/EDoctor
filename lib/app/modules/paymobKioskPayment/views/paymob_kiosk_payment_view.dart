import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/paymob_kiosk_payment_controller.dart';

class PaymobKioskPaymentView extends GetView<PaymobKioskPaymentController> {
  const PaymobKioskPaymentView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('PaymobKioskPaymentView'),
        centerTitle: true,
      ),
      body: const Center(
        child: Text(
          'PaymobKioskPaymentView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}

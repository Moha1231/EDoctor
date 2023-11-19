import 'package:cloud_functions/cloud_functions.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:hallo_doctor_client/app/models/paymob_model.dart';

class PaymentService {
  Future<String> getClientSecret(String timeSlotId, String uid) async {
    try {
      var callable =
          FirebaseFunctions.instance.httpsCallable('purchaseTimeslot');
      final results = await callable({'timeSlotId': timeSlotId, 'userId': uid});
      var clientSecret = results.data;
      return clientSecret;
    } catch (e) {
      return Future.error(e.toString());
    }
  }

  Future<bool> purchaseFreeTimeSlot(String timeSlotId, String uid) async {
    try {
      var callable =
          FirebaseFunctions.instance.httpsCallable('purchaseFreeTimeSlot');
      final results = await callable({'timeSlotId': timeSlotId, 'userId': uid});
      var result = results.data as bool;
      return result;
    } catch (e) {
      if (e is FirebaseException) {
        return Future.error(e.message ?? 'Firebase Error');
      } else {
        return Future.error(e);
      }
    }
  }

  Future<String> payWithRazorpay(String timeSlotId, String uid) async {
    try {
      var callable =
          FirebaseFunctions.instance.httpsCallable('requestRazorpayPayment');
      final results = await callable({'timeSlotId': timeSlotId, 'userId': uid});
      var orderId = results.data;
      return orderId;
    } catch (e) {
      return Future.error(e);
    }
  }

  Future<PaymobModelResponse> payWithPaymob(
      String timeSlotId, String uid, PaymobPaymentType type) async {
    try {
      var callable =
          FirebaseFunctions.instance.httpsCallable('paymobCreateOrder');
      final results = await callable(
          {'timeSlotId': timeSlotId, 'userId': uid, 'paymentType': type.name});
      print('payment types' + type.toString());
      var userToken = results.data['token'] as String;

      PaymobModelResponse paymobModelResponse = PaymobModelResponse(
        token: results.data['token'] as String,
      );
      if (type == PaymobPaymentType.kiosk) {
        var kioskCode = results.data['kioskCode'] as String;
        paymobModelResponse.kioskCode = kioskCode;
      }
      return paymobModelResponse;
    } catch (e) {
      return Future.error(e);
    }
  }
}

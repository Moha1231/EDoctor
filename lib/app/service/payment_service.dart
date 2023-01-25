import 'package:cloud_functions/cloud_functions.dart';
import 'package:firebase_core/firebase_core.dart';

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
}

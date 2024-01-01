import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_firebase_chat_core/flutter_firebase_chat_core.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:hallo_doctor_client/app/service/notification_service.dart';
import 'package:hallo_doctor_client/app/utils/environment.dart';
import 'package:hallo_doctor_client/main.dart';
import 'package:integration_test/integration_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:patrol/patrol.dart';

///Integration Test using Patrol Test, these test are just few example test to make sure the app is working
///To run the test using patrol use this command, but make sure you have install the patroll cli, follow the documentation
///Command : patrol test -t integration_test/main_test.dart
void main() {
  //Replace these values with your own
  String email = 'test11@gmail.com';
  String password = 'test11';
  setUp(() async {
    await dotenv.load();
    await Firebase.initializeApp();
    NotificationService();
    Stripe.publishableKey = Environment.stripePublishableKey;
    initializeDateFormatting('en', null);
    FirebaseChatCore.instance
        .setConfig(FirebaseChatCoreConfig(null, 'Rooms', 'Users'));
  });

  patrolTest('Login Test', ($) async {
    await $.pumpWidgetAndSettle(HalloDoctorApp(isUserLogin: false));
    await $(#username).enterText(email);
    await $(#password).enterText(password);
    await $.tester.testTextInput.receiveAction(TextInputAction.done);
    await $(#loginButton).tap(settlePolicy: SettlePolicy.noSettle);
    await $("Welcome Back,").waitUntilExists();
    if (await $.native
        .isPermissionDialogVisible(timeout: Duration(seconds: 10))) {
      // await $.native.grantPermissionWhenInUse();
      print('notification permission pop up');
      await $.native.tap(
        Selector(text: 'Allow'),
      );
    }

    /// click on bottom navigation bar to go
    await $(#doctorCategoryIcon).tap();
    await $(#appointmentIcon).tap();
    await $(#chatIcon).tap();
    await $(#profileIcon).tap();
  });
}

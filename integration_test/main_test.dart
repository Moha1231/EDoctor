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

///Text login & Register app, make sure the app can still run
void main() async {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load();
  await Firebase.initializeApp();
  NotificationService();
  Stripe.publishableKey = Environment.stripePublishableKey;
  initializeDateFormatting('en', null);
  FirebaseChatCore.instance
      .setConfig(FirebaseChatCoreConfig(null, 'Rooms', 'Users'));

  testWidgets('Main Test', (WidgetTester tester) async {
    // Run app
    await tester
        .pumpWidget(HalloDoctorApp(isUserLogin: false)); // Create main app
    await tester.pumpAndSettle(); // Finish animations and scheduled microtasks
    await tester.pump(Duration(seconds: 2)); // Wait some time

    // Find username & password text
    final Finder usernameText = find.byKey(ValueKey('username'));
    final Finder passwordText = find.byKey(ValueKey('password'));

    // Ensure there is a login and password field on the initial page
    expect(usernameText, findsOneWidget);
    expect(passwordText, findsOneWidget);

    // Enter text
    await tester.enterText(usernameText, 'test11@gmail.com');
    await tester.enterText(passwordText, 'test11');
    await tester.pumpAndSettle();
    await tester.pump(Duration(seconds: 10));

    // Find login button
    final Finder loginButton = find.byKey(ValueKey('loginButton'));
    // Tap login button
    await tester.tap(loginButton, warnIfMissed: true);
    await tester.pumpAndSettle();
    await tester.pump(Duration(seconds: 2));

    //find test button
    expect(find.byKey(ValueKey('testButton')), findsNothing);
  });
}

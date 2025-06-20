import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_chat_ui/flutter_chat_ui.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:get/get.dart';
import 'package:hallo_doctor_client/app/service/local_notification_service.dart';
import 'package:hallo_doctor_client/app/utils/environment.dart';
import 'package:hallo_doctor_client/app/utils/localization.dart';
import 'app/routes/app_pages.dart';
import 'app/service/firebase_service.dart';
import 'package:intl/date_symbol_data_local.dart';
// ignore: depend_on_referenced_packages
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:hallo_doctor_client/app/modules/ai/core/di/locator.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

//Main App
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Future.delayed(const Duration(seconds: 5));
  FlutterNativeSplash.remove();
  await dotenv.load();
  await Firebase.initializeApp();
  LocalNotificationService().initNotification();
  bool isUserLogin = await FirebaseService().checkUserAlreadyLogin();
  Stripe.publishableKey = Environment.stripePublishableKey;
  initializeDateFormatting('en', null);
  setUpLocator();
  SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual,
      overlays: [SystemUiOverlay.bottom, SystemUiOverlay.top]);
  FirebaseChatCore.instance
      .setConfig(FirebaseChatCoreConfig(null, 'Rooms', 'Users'));
  // await ChatService().init();
  runApp(HalloDoctorApp(isUserLogin: isUserLogin));
}

class HalloDoctorApp extends StatelessWidget {
  HalloDoctorApp({super.key, required this.isUserLogin});
  final bool isUserLogin;

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: "E Doctor",
      initialRoute: isUserLogin ? AppPages.DASHBOARD : AppPages.LOGIN,
      getPages: AppPages.routes,
      builder: EasyLoading.init(),
      localizationsDelegates: [
        FormBuilderLocalizations.delegate,
      ],
      locale: LocalizationService.locale,
      translations: LocalizationService(),
      theme: ThemeData(useMaterial3: true),
    );
  }
}

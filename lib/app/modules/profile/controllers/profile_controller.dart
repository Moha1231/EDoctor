import 'dart:io';
import 'package:url_launcher/url_launcher.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:hallo_doctor_client/app/routes/app_pages.dart';
import 'package:hallo_doctor_client/app/service/local_notification_service.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:hallo_doctor_client/app/modules/profile/views/pages/change_password.dart';
import 'package:hallo_doctor_client/app/modules/profile/views/pages/edit_image_page.dart';
import 'package:hallo_doctor_client/app/modules/profile/views/pages/update_email_page.dart';
import 'package:hallo_doctor_client/app/service/auth_service.dart';
import 'package:hallo_doctor_client/app/service/user_service.dart';
// import '../../ai/ui/views/chat_view.dart';

class ProfileController extends GetxController {
  //TODO: Implement ProfileController

  final count = 0.obs;
  AuthService authService = Get.find();
  UserService userService = Get.find();
  var username = ''.obs;
  var profilePic = ''.obs;
  var appVersion = ''.obs;
  var email = ''.obs;
  var newPassword = ''.obs;

  @override
  void onInit() async {
    super.onInit();
    PackageInfo packageInfo = await PackageInfo.fromPlatform();
    appVersion.value = packageInfo.version;
  }

  @override
  void onReady() {
    super.onReady();
    profilePic.value = userService.getProfilePicture()!;
    username.value = userService.currentUserFirebase!.displayName!;
    email.value = userService.currentUserFirebase!.email!;
  }

  @override
  void onClose() {}

  void logout() async {
    Get.defaultDialog(
      title: 'Logout'.tr,
      middleText: 'Are you sure you want to Logout'.tr,
      radius: 15,
      textCancel: 'Cancel'.tr,
      textConfirm: 'Logout'.tr,
      onConfirm: () {
        authService.logout();
        Get.offAllNamed(Routes.LOGIN);
      },
    );
  }

  toEditImage() {
    Get.to(() => EditImagePage());
  }

  toUpdateEmail() {
    Get.to(() => UpdateEmailPage());
  }

  toChangePassword() {
    Get.to(() => ChangePasswordPage());
  }

  void updateProfilePic(File filePath) {
    EasyLoading.show(maskType: EasyLoadingMaskType.black);
    userService.updateProfilePic(filePath).then((updatedUrl) {
      profilePic.value = updatedUrl;
      Get.back();
    }).catchError((error) {
      Fluttertoast.showToast(
          msg: error.toString(), toastLength: Toast.LENGTH_LONG);
    }).whenComplete(() {
      EasyLoading.dismiss();
    });
  }

  void updateEmail(String email) async {
    // if (!(await checkGoogleLogin())) return;
    try {
      EasyLoading.show();
      UserService().updateEmail(email).then((value) {
        Get.back();
        this.email.value = email;
        update();
      }).catchError((err) {
        Fluttertoast.showToast(msg: err.toString());
      }).whenComplete(() {
        EasyLoading.dismiss();
      });
    } catch (e) {
      Fluttertoast.showToast(msg: e.toString());
    }
  }

  void changePassword(String currentPassword, String newPassword) async {
    // if (!(await checkGoogleLogin())) return;

    try {
      await UserService().changePassword(currentPassword, newPassword);
      currentPassword = '';
      newPassword = '';
      Get.back();
      Fluttertoast.showToast(msg: 'Successfully change password'.tr);
    } catch (err) {
      Fluttertoast.showToast(msg: err.toString());
    }
    EasyLoading.dismiss();
  }

//user for testing something
  Future testButton() async {
    try {
      DateTime scheduleTime = DateTime.now();
      final oneMinutefromNow = scheduleTime.add(const Duration(seconds: 20));
      debugPrint('Notification Scheduled for $oneMinutefromNow');
      LocalNotificationService().scheduleNotification(
          title: 'Scheduled Notification',
          body: '$oneMinutefromNow',
          scheduledNotificationDateTime: oneMinutefromNow);
      //NotificationService().testNotification();
      // DateTime now = DateTime.now();
      // Duration tenMinutes = Duration(minutes: 10);
      // DateTime tenMinutesBefore = now.subtract(tenMinutes);

      // print(
      //     'Ten minutes before ${now.toString()}: ${tenMinutesBefore.toString()}');
    } catch (e) {
      return Future.error(e.toString());
    }
  }

  void toSettings() {
    // testButton();
    Get.toNamed(Routes.SETTINGS);
  }

  void toWallet() {
    //testButton();
    Get.toNamed(Routes.USER_WALLET);
  }

//  void toaichat() {
  //Get.toNamed(Routes.USER_WALLET);
  //  Get.to(CharView);
  //   Get.to(() => CharView());
//  }
  // Future<bool> checkGoogleLogin() async {
  //   bool loginGoogle = await AuthService().checkIfGoogleLogin();
  //   print('is login google : ' + loginGoogle.toString());
  //   if (loginGoogle) {
  //     Fluttertoast.showToast(
  //         msg: 'your login method, it is not possible to change this data');
  //     return false;
  //   }
  //   return loginGoogle;
  // }

  supportwhatsup() async {
    var contact = "+0201061221444";
    var androidUrl = "whatsapp://send?phone=$contact&text=Hi, I need some help";
    var iosUrl =
        "https://wa.me/$contact?text=${Uri.parse('Hi, I need some help')}";

    try {
      if (Platform.isIOS) {
        await launchUrl(Uri.parse(iosUrl));
      } else {
        await launchUrl(Uri.parse(androidUrl));
      }
    } on Exception {
      EasyLoading.showError('WhatsApp is not installed.');
    }
  }
}

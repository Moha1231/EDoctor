import 'dart:io';

import 'package:flutter/material.dart';
import '../../core/constants/color_constant.dart';
import '../../core/constants/string_constants.dart';
import '../../core/model/chat_model.dart';
import '../../ui/widgets/common_image.dart';
import '../../ui/widgets/common_sized_box.dart';
import '../../ui/widgets/common_text.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:hallo_doctor_client/app/modules/dashboard/controllers/dashboard_controller.dart';
import 'package:get/get.dart';

// ignore: must_be_immutable
class MessageBody extends StatelessWidget {
  MessageBody({super.key, required this.chatModel, required this.isLoading});
  ChatModel? chatModel;
  bool isLoading;
  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: chatModel?.role == StringConstants.user
          ? Alignment.centerRight
          : Alignment.centerLeft,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Padding(
            padding: chatModel?.role == StringConstants.user
                ? const EdgeInsets.only(top: 10, right: 15, left: 70)
                : const EdgeInsets.only(
                    left: 15, right: 70, top: 10, bottom: 10),
            child: ClipRRect(
              borderRadius: chatModel?.role == StringConstants.user
                  ? const BorderRadius.only(
                      bottomLeft: Radius.circular(20),
                      topLeft: Radius.circular(20),
                      topRight: Radius.circular(20))
                  : const BorderRadius.only(
                      bottomRight: Radius.circular(20),
                      topLeft: Radius.circular(20),
                      topRight: Radius.circular(20)),
              child: Container(
                padding: const EdgeInsets.all(10),
                color: chatModel?.role == StringConstants.user
                    ? ColorConstants.grey7A8194
                    : ColorConstants.green373E4E,
                child: isLoading == true
                    ? LoadingAnimationWidget.waveDots(
                        color: ColorConstants.white, size: 30)
                    : CommonText(
                        text: chatModel?.text ?? '',
                        color: ColorConstants.white,
                        fontSize: 18,
                        fontWeight: FontWeight.w500,
                      ),
              ),
            ),
          ),
// hereeeeeeeeeeeeeeeeeeee
          chatModel?.role == StringConstants.model
              ? Column(
                  //  mainAxisAlignment: MainAxisAlignment.start,
                  //  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Chip(
                      //  borderRadius: BorderRadius.circular(15),
                      avatar: CircleAvatar(
                          backgroundImage:
                              AssetImage('assets/images/stethoscope.jpg')),
                      label: Text('Book Your Doctor video call'),
                    ),
                    // النص الذي يظهر عى الزر
                    Row(
                        mainAxisAlignment: MainAxisAlignment
                            .spaceEvenly, // use whichever suits your need

                        children: [
                          ElevatedButton(
                              onPressed: () {
                                goHome();
                              },
                              child: Text(
                                'ok',
                                style: TextStyle(color: Colors.black),
                              )),
                          ElevatedButton(
                            onPressed: () {
                              Get.back();
                            },
                            child: Text(
                              'Go Back',
                              style: TextStyle(color: Colors.black),
                            ),
                          ),
                        ]),
                  ],
                )
              : CommonSizedBox(),

          // here

          chatModel?.photo != null
              ? CommonImages(
                  bottomLeft: 20,
                  topLeft: 20,
                  bottomRight: 20,
                  file: chatModel?.photo ?? File(''),
                )
              : CommonSizedBox()
        ],
      ),
    );
  }
}

void goHome() {
  Get.find<DashboardController>().selectedIndex = 1;
  Get.back();
  // Get.offAllNamed('dashboard');
//  Get.find<DoctorCategoryController>().getListDoctorCategory();
//  Get.to(() => DoctorCategoryView());
}

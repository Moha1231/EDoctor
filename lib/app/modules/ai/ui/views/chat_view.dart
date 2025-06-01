import 'package:emoji_picker_flutter/emoji_picker_flutter.dart';
import 'package:flutter/material.dart';
import '../../core/constants/color_constant.dart';
import '../../core/constants/image_constants.dart';
import '../../core/constants/string_constants.dart';
import '../../core/model/chat_model.dart';
import '../../core/viewmodel/chat_view_model.dart';
import '../../ui/views/base_view.dart';
import '../../ui/widgets/common_emoji_icon_button.dart';
import '../../ui/widgets/pop_up_menu.dart';
import '../../ui/widgets/common_sized_box.dart';
import '../../ui/widgets/common_text.dart';
import '../../ui/widgets/message_body.dart';
import '../../ui/widgets/message_field.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mailer/mailer.dart';
import 'package:mailer/smtp_server.dart';
import 'package:get/get.dart';
import 'package:hallo_doctor_client/app/modules/dashboard/controllers/dashboard_controller.dart';
import 'package:hallo_doctor_client/app/modules/dashboard/views/dashboard_view.dart';
import 'package:hallo_doctor_client/app/modules/dashboard/controllers/dashboard_controller.dart';
import 'package:fluttertoast/fluttertoast.dart';

// ignore: must_be_immutable
class CharView extends StatelessWidget {
  CharView({super.key});
  ChatViewModel? model;

  @override
  Widget build(BuildContext context) {
    return BaseView<ChatViewModel>(
      onModelReady: (model) {
        this.model = model;
      },
      builder: (context, model, child) {
        return SafeArea(
            child: GestureDetector(
          onTap: () {
            FocusManager.instance.primaryFocus?.unfocus();
            model.keyboardAppear(false);
            model.showEmojiPicker(false);
          },
          child: Container(
            decoration: const BoxDecoration(
                image: DecorationImage(
                    fit: BoxFit.fill,
                    image: AssetImage(
                      ImageConstant.backGroundImage,
                    ))),
            child: Scaffold(
              appBar: AppBar(
                title: Text('E Doctor Ai'),
                centerTitle: true,
              ),
              backgroundColor: ColorConstants.white,
              body: buildBody(context),
            ),
          ),
        ));
      },
    );
  }

  Widget buildBody(BuildContext context) {
    return Column(
      children: [
        CommonSizedBox(height: 10),
        Row(
          children: [
            Expanded(
                child: Container(
              alignment: Alignment.topLeft,
              child: IconButton(
                  onPressed: () {
                    sendEmail();
                    Fluttertoast.showToast(msg: 'Report Sent successfully');
                  },
                  icon: Icon(Icons.report)),
            )),
          ],
        ),
        CommonSizedBox(height: 20),
        buildChatMessage(),
        // هنا الكود شغال

        // MessageField
        MessageField(
            chatViewModel: model,
            onClipTap: () {
              _showPicker(context);
              model?.setEmojiPicker = false;
            },
            emojiWidget: CommonEmojiButton(
              onPressed: () {
                model?.showEmojiPicker(true);
                FocusScope.of(context).unfocus();
              },
            )),
        model?.isEmojiPicker == true
            ? Expanded(
                child: EmojiPicker(
                textEditingController: model?.messageController,
              ))
            : CommonSizedBox()
      ],
    );
  }

  Widget buildChatMessage() {
    return Expanded(
      child: ListView.builder(
        controller: model?.scrollController,
        shrinkWrap: true,
        itemCount: model?.chatList.length ?? 0,
        itemBuilder: (context, index) {
          int last = (model?.chatList.length ?? 0);
          ChatModel? data;
          if (model?.chatList[index] != null) {
            data = model?.chatList[index];
            // test

            // end test
          }
          bool isLoading = index + 1 == last &&
              data?.role != StringConstants.user &&
              data?.text == '';
          return MessageBody(chatModel: data, isLoading: isLoading);
        },
      ),
    );
  }

// pic
  _showPicker(context) {
    showModalBottomSheet(
        backgroundColor: ColorConstants.white,
        context: context,
        builder: (BuildContext context) {
          return PopUpMenuWidget(
            onTapCamera: () {
              model?.imgFromDevice(ImageSource.camera);
              Navigator.pop(context);
            },
            onTapGalley: () {
              model?.imgFromDevice(ImageSource.gallery);
              Navigator.pop(context);
            },
          );
        });
  }
}

void goHome() {
  Get.find<DashboardController>().selectedIndex = 1;
  Get.back();
  // Get.offAllNamed('dashboard');
//  Get.find<DoctorCategoryController>().getListDoctorCategory();
//  Get.to(() => DoctorCategoryView());
}

Future<void> sendEmail() async {
  //  var displaName = UserService().currentUserFirebase!.displayName;
  final smtpServer = SmtpServer('smtp.gmail.com',
      username: 'mo7md.soliman24@gmail.com', password: 'szowguczxpquverf');

  final message = Message()
    ..from = Address('mo7md.soliman24@gmail.com', 'ai ropert')
    ..recipients.add('mo7md.soliman12@gmail.com')
    ..subject = 'ai ropert'
    ..text = 'ai ropert'
    ..html = 'ai ropert';

  try {
    final sendReport = send(message, smtpServer);
    print('Message sent: ${sendReport}');
  } catch (e) {
    print('Error occurred while sending email: $e');
  }
}

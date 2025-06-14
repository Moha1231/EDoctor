import 'dart:io';

import 'package:flutter/material.dart';
import '../../core/constants/color_constant.dart';
import '../../core/viewmodel/chat_view_model.dart';
import '../../ui/widgets/common_image.dart';
import '../../ui/widgets/common_image_asset.dart';
import '../../ui/widgets/common_send_button.dart';
import '../../ui/widgets/common_sized_box.dart';
import '../../ui/widgets/common_text_form_field.dart';

// ignore: must_be_immutable
class MessageField extends StatelessWidget {
  MessageField(
      {super.key,
      required this.chatViewModel,
      required this.onClipTap,
      required this.emojiWidget});
  ChatViewModel? chatViewModel;
  void Function()? onClipTap;
  Widget emojiWidget;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.max,
      children: [
        Expanded(
          child: Container(
            margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
            decoration: BoxDecoration(
                border: Border.all(width: 1, color: Colors.black),
                color: Colors.white70,
                borderRadius: const BorderRadius.all(Radius.circular(30))),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                chatViewModel?.photo != null
                    ? CommonTextFormField(
                        onEditingComplete: () {
                          if (chatViewModel
                                  ?.messageController.text.isNotEmpty ??
                              false) {
                            chatViewModel?.getChat();
                            chatViewModel?.messageController.clear();
                          }
                        },
                        controller: chatViewModel?.messageController)
                    : CommonSizedBox(),
                Align(
                  alignment: Alignment.topLeft,
                  child: chatViewModel?.photo != null
                      ? CommonImages(
                          bottomLeft: 20,
                          bottomRight: 20,
                          topLeft: 20,
                          topRight: 20,
                          file: chatViewModel?.photo ?? File(''),
                        )
                      : CommonSizedBox(),
                ),
                Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    chatViewModel?.photo == null
                        ? Expanded(
                            child: CommonTextFormField(
                                onTap: () {
                                  chatViewModel?.keyboardAppear(true);
                                  chatViewModel?.showEmojiPicker(false);
                                },
                                suffixIconWidget: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    CommonMenuButton(onTap: onClipTap),
                                    CommonSizedBox(
                                      width: 10,
                                    ),
                                    CommonSendButton(
                                      onPressed: () {
                                        if (chatViewModel?.messageController
                                                .text.isNotEmpty ??
                                            false) {
                                          chatViewModel?.getChat();
                                          chatViewModel?.messageController
                                              .clear();
                                        }
                                      },
                                    )
                                  ],
                                ),
                                prefixIconWidget: emojiWidget,
                                onEditingComplete: () {
                                  if (chatViewModel
                                          ?.messageController.text.isNotEmpty ??
                                      false) {
                                    chatViewModel?.getChat();
// hereeeeeeeee
// hereeeeeeeeeeeeeeeeeeeee
                                    chatViewModel?.messageController.clear();
                                  }
                                },
                                controller: chatViewModel?.messageController),
                          )
                        : CommonSizedBox(),
                  ],
                ),
                chatViewModel?.photo != null
                    ? Row(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          emojiWidget,
                          CommonSizedBox(
                            width: 10,
                          ),
                          CommonMenuButton(onTap: onClipTap),
                          CommonSizedBox(
                            width: 10,
                          ),
                          CommonSendButton(
                            onPressed: () {
                              if (chatViewModel
                                      ?.messageController.text.isNotEmpty ??
                                  false) {
                                chatViewModel?.getChat();
                                chatViewModel?.messageController.clear();
                              }
                            },
                          ),
                        ],
                      )
                    : CommonSizedBox()
              ],
            ),
          ),
        ),
      ],
    );
  }
}

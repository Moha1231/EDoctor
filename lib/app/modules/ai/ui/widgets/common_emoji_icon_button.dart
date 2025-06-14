import 'package:flutter/material.dart';
import '../../core/constants/color_constant.dart';

// ignore: must_be_immutable
class CommonEmojiButton extends StatelessWidget {
  CommonEmojiButton({super.key, required this.onPressed});
  void Function()? onPressed;

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: onPressed,
      icon: const Icon(
        Icons.emoji_emotions,
        color: Colors.blueAccent,
      ),
    );
  }
}

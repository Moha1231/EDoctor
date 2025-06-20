import 'package:flutter/material.dart';
import 'package:hallo_doctor_client/app/modules/chat/views/list_users_view.dart';
import '../../core/constants/color_constant.dart';
import '../../core/constants/string_constants.dart';

// ignore: must_be_immutable
class CommonTextFormField extends StatelessWidget {
  CommonTextFormField(
      {super.key,
      this.suffixIconWidget,
      this.prefixIconWidget,
      required this.onEditingComplete,
      this.onTap,
      this.controller});
  void Function()? onEditingComplete;
  void Function()? onTap;
  TextEditingController? controller;
  Widget? prefixIconWidget;
  Widget? suffixIconWidget;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 18.0),
      child: TextFormField(
        minLines: 1,
        maxLines: 30,
        textInputAction: TextInputAction.go,
        keyboardType: TextInputType.text,
        onTap: onTap,
        cursorColor: ColorConstants.white,
        style: const TextStyle(
            color: Color(0xFF0091FC), fontWeight: FontWeight.w500),
        onEditingComplete: onEditingComplete,
        controller: controller,
        decoration: InputDecoration(
            suffixIcon: suffixIconWidget,
            prefixIcon: prefixIconWidget,
            filled: true,
            hintText: StringConstants.textFieldHint,
            hintStyle: const TextStyle(color: Colors.blueAccent, fontSize: 17),
            fillColor: Colors.white70,
            border: const OutlineInputBorder(
                borderSide: BorderSide.none,
                borderRadius: BorderRadius.all(Radius.circular(50)))),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import '../../core/constants/color_constant.dart';
import '../../core/constants/image_constants.dart';
import '../../ui/widgets/common_sized_box.dart';

// ignore: must_be_immutable
class CommonMenuButton extends StatelessWidget {
  CommonMenuButton({super.key, required this.onTap});
  void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return CommonSizedBox(
      height: 22,
      width: 22,
      child: InkWell(
        onTap: onTap,
        child: Image.asset(
          ImageConstant.clipIcon,
          color: Colors.blueAccent,
          fit: BoxFit.fill,
        ),
      ),
    );
  }
}

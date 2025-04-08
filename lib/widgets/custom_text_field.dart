import 'package:flutter/material.dart';
import 'package:portfolio/constants/colors.dart';

class CustomTextField extends StatelessWidget {
  const CustomTextField({
    super.key,
    this.controller,
    this.hintText,
    this.maxLine,
  });
  final TextEditingController? controller;
  final int? maxLine;
  final String? hintText;

  @override
  Widget build(BuildContext context) {
    return TextField(
      maxLines: maxLine,
      controller: controller,
      decoration: InputDecoration(
        contentPadding: EdgeInsets.all(16),
        filled: true,
        fillColor: CustomColor.whiteSecondary,
        focusedBorder: getInputBoarder,
        enabledBorder: getInputBoarder,
        border: getInputBoarder,
        hintText: hintText,
        hintStyle: TextStyle(color: CustomColor.hintDark),
      ),

      style: TextStyle(color: CustomColor.scaffoldBg),
    );
  }

  OutlineInputBorder get getInputBoarder {
    return OutlineInputBorder(
      borderRadius: BorderRadius.circular(10),
      borderSide: BorderSide.none,
    );
  }
}

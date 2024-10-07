import 'package:flutter/material.dart';
import 'package:riverpod_todo/common/utlis/app_const.dart';

import 'app_style.dart';

class CustomTextField extends StatelessWidget {
  const CustomTextField(
      {super.key,
      this.keyboardType,
      required this.hintText,
      this.suffixIcon,
      this.prefixIcon,
      required this.hintStyle, required this.controller, this.onChanged});

  final TextInputType? keyboardType;
  final String hintText;
  final Widget? suffixIcon;
  final Widget? prefixIcon;
  final TextStyle hintStyle;
  final TextEditingController controller;
  final void Function(String)?onChanged;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: AppConst.width ,
      decoration: const BoxDecoration(
        color: AppConst.white,
        borderRadius: BorderRadius.all(Radius.circular(15)),
      ),
      child: TextFormField(
        keyboardType: keyboardType,
        controller: controller,
        cursorHeight: 25,
        onChanged:onChanged,
        style: appStyle(18, AppConst.black, FontWeight.w700),
        decoration: InputDecoration(
          hintText: hintText,
          suffixIcon: suffixIcon,
          prefixIcon: prefixIcon,
          suffixIconColor: AppConst.black,
          hintStyle: hintStyle,
          enabledBorder: InputBorder.none,

          errorBorder: const OutlineInputBorder(
            borderRadius: BorderRadius.zero,
            borderSide: BorderSide(color: AppConst.orange, width: 0.5),
          ),
          focusedBorder: const OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(15)),
            borderSide: BorderSide(color: AppConst.grey, width: 0.0),

          ),
          focusedErrorBorder: const OutlineInputBorder(
            borderRadius: BorderRadius.zero,
            borderSide: BorderSide(color: AppConst.lightGreen, width:15),
          ),
          disabledBorder: const OutlineInputBorder(
            borderRadius: BorderRadius.zero,
            borderSide: BorderSide(color: AppConst.black, width: 0.5),
          ),
        ),
      ),
    );
  }
}

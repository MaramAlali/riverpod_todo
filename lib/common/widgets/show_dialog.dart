import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:riverpod_todo/common/utlis/app_const.dart';
import 'package:riverpod_todo/common/widgets/app_style.dart';
import 'package:riverpod_todo/common/widgets/reusable.dart';

showAlertDialog({
  required BuildContext context,
  required String message,
  String? btnText,
}) {
  return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          content: ReusableText(
              text: message,
              style: appStyle(18, AppConst.lightPurple, FontWeight.w600)),
          contentPadding: EdgeInsets.fromLTRB(20.w, 20.h, 20.w, 0.h),
          title: Row(
            children: [
              const Icon(AntDesign.bells),
              Text(
                "Alert",
                style: appStyle(25, AppConst.pink, FontWeight.bold),
              ),
            ],
          ),
          backgroundColor: AppConst.white,
          shadowColor: AppConst.grey,
          scrollable: true,
          actions: [
            TextButton(
                onPressed: () => Navigator.pop(context),
                child: Text(
                  btnText ?? "ok",
                  style: appStyle(18, AppConst.pink, FontWeight.w500),
                ))
          ],
        );
      });
}

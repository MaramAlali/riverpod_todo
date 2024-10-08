import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:riverpod_todo/common/utlis/app_const.dart';
import 'package:riverpod_todo/common/widgets/app_style.dart';
import '../../../common/widgets/height_spacer.dart';

class SplashPage extends StatelessWidget {
  const SplashPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
        height: AppConst.height,
        width: AppConst.width,
        color: AppConst.black,
        child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Padding(
                  padding: EdgeInsets.symmetric(horizontal: 30.w),
                  child: Image.asset(
                    "assets/images/icon.png",
                    width: 200,
                    height: 200,
                  )),
              const HeightSpacer(
                height: 30,
              ),
              Text("Welcome to TaskTracker",
                  textAlign: TextAlign.center,
                  style: appStyle(30, AppConst.pink, FontWeight.w600)),
            ]));
  }
}

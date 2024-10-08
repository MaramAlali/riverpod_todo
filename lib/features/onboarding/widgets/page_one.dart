import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:riverpod_todo/common/widgets/reusable.dart';
import '../../../common/utlis/app_const.dart';
import '../../../common/widgets/app_style.dart';
import '../../../common/widgets/height_spacer.dart';

class PageOne extends StatelessWidget {
  const PageOne({super.key});

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
              child: Image.asset("assets/images/2.png",width: 200,height: 200,)),
          const HeightSpacer(
            height: 100,
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                  "TaskTracker  with a River Pod",
                  textAlign: TextAlign.center,
                  style: appStyle(30, AppConst.white, FontWeight.w600)),
              const HeightSpacer(
                height: 10,
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 30.w),
                child: Text(
                  "Welcome!! Do you want to create  a task fast with ease?",
                  style: appStyle(18, AppConst.lightPurple, FontWeight.normal),
                  textAlign: TextAlign.center,
                ),
              )
            ],
          ),
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:riverpod_todo/common/widgets/custom_btn.dart';
import 'package:riverpod_todo/features/todo/pages/login_page.dart';
import '../../../common/utlis/app_const.dart';
import '../../../common/widgets/app_style.dart';
import '../../../common/widgets/height_spacer.dart';

class PageTwo extends StatelessWidget {
  const PageTwo({super.key});

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
              child: Image.asset("assets/images/not.png")),
          const HeightSpacer(
            height: 30,
          ),
           Text(
            "let's start",
            style: appStyle(30, AppConst.pink, FontWeight.bold),
            textAlign: TextAlign.center,
          ),
          const HeightSpacer(
            height: 50,
          ),
          CustomBtn(
              onTap: () {
                Navigator.of(context).pushReplacement(
                    MaterialPageRoute(builder: (context) => const LoginPage()));
              },
              width: AppConst.width * 0.7,
              height: AppConst.width * 0.15,
              color: AppConst.white,
              text: "Login with phone number")
        ],
      ),
    );
  }
}

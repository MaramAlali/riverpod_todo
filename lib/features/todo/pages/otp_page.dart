import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:pinput/pinput.dart';
import 'package:riverpod_todo/common/widgets/app_style.dart';
import 'package:riverpod_todo/common/widgets/reusable.dart';
import 'package:riverpod_todo/features/auth/controllers/auth_controller.dart';
import '../../../common/utlis/app_const.dart';
import '../../../common/widgets/height_spacer.dart';

class OtpPage extends ConsumerWidget {
  const OtpPage({super.key, required this.smsCodeId, required this.phone});

  final String smsCodeId;
  final String phone;

  void verifyOtpCode(BuildContext context, WidgetRef ref, String smsCode) {
    ref.read(authControllerProvider).verifyOtp(
        context: context, smsId: smsCodeId, smsCode: smsCode, mounted: true);
  }

  @override
  Widget build(BuildContext context,WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
      ),
      body: SafeArea(
          child: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            HeightSpacer(height: AppConst.height * 0.1),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.w),
              child: Image.asset(
                "assets/images/2.png",
                width: AppConst.width * 0.5,
              ),
            ),
            const HeightSpacer(height: 26),
            ReusableText(
                text: "enter your otp code",
                style: appStyle(18, AppConst.white, FontWeight.bold)),
            HeightSpacer(height: 26.h),
            Pinput(
              length: 6,
              showCursor: true,

              onCompleted: (value) {
                if (value.length == 6) {
                  return verifyOtpCode(context, ref, value);
                }
              },
              onSubmitted: (value) {
                if (value.length == 6) {
                  return verifyOtpCode(context, ref, value);
                }
              },
            ),
          ],
        ),
      )),
    );
  }
}

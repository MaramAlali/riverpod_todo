import 'package:flutter/material.dart';
import 'package:country_picker/country_picker.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:riverpod_todo/common/utlis/app_const.dart';
import 'package:riverpod_todo/common/widgets/custom_btn.dart';
import 'package:riverpod_todo/common/widgets/height_spacer.dart';
import 'package:riverpod_todo/common/widgets/reusable.dart';
import 'package:riverpod_todo/common/widgets/show_dialog.dart';
import 'package:riverpod_todo/features/auth/controllers/auth_controller.dart';
import '../../../common/widgets/app_style.dart';
import '../../../common/widgets/custom_text_field.dart';

class LoginPage extends ConsumerStatefulWidget {
  const LoginPage({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _LoginPageState();
}

class _LoginPageState extends ConsumerState<LoginPage> {
  final TextEditingController phone = TextEditingController();
  Country country = Country(
    phoneCode: "963",
    countryCode: "SY",
    e164Sc: 0,
    geographic: true,
    level: 1,
    name: "SY",
    example: "SY",
    displayName: "SY",
    displayNameNoCountryCode: "SY",
    e164Key: "",
  );

  sendCodeToUser() {
    if (phone.text.isEmpty) {
      return showAlertDialog(
          context: context, message: "please enter your phone number");
    } else if (phone.text.length < 8) {
      return showAlertDialog(
          context: context, message: "phone number is short");
    } else {
      ref.read(authControllerProvider).sendSms(
          context: context, phone: '+${country.phoneCode}${phone.text}');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
            padding: EdgeInsets.symmetric(
              horizontal: 10.w,
            ),
            child: ListView(
              children: [
                Image.asset(
                  "assets/images/2.png",
                  width: 300,
                ),
                const HeightSpacer(height: 20),
                Center(
                  child: ReusableText(
                      text: "please enter phone number",
                      style: appStyle(20, AppConst.white, FontWeight.w700)),
                ),
                const HeightSpacer(height: 40),
                Center(
                  child: CustomTextField(
                    prefixIcon: Container(
                      padding: const EdgeInsets.all(9),
                      child: GestureDetector(
                        onTap: () {
                          showCountryPicker(
                              context: context,
                              countryListTheme: CountryListThemeData(
                                backgroundColor: AppConst.white,
                                bottomSheetHeight: AppConst.height * 0.6,
                                borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(AppConst.radius),
                                  topRight: Radius.circular(AppConst.radius),
                                ),
                              ),
                              onSelect: (code) {
                                setState(() {
                                  country = code;
                                });

                              });
                        },
                        child: ReusableText(
                            text: "${country.flagEmoji}+${country.phoneCode}",
                            style:
                                appStyle(18, AppConst.black, FontWeight.bold)),
                      ),
                    ),
                    keyboardType: TextInputType.phone,
                    hintText: "enter phone number",
                    hintStyle: appStyle(18, AppConst.black, FontWeight.w600),
                    controller: phone,
                  ),
                ),
                const HeightSpacer(height: 30),
                CustomBtn(
                  onTap: () {
                    sendCodeToUser();
                  },
                  width: AppConst.width * 0.9,
                  height: AppConst.height * 0.07,
                  color: AppConst.black,
                  text: "send code",
                  color2: AppConst.lightPurple,
                ),
              ],
            )),
      ),
    );
  }
}

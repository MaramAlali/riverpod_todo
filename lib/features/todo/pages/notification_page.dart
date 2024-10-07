import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:riverpod_todo/common/widgets/app_style.dart';
import 'package:riverpod_todo/common/widgets/height_spacer.dart';
import 'package:riverpod_todo/common/widgets/reusable.dart';
import 'package:riverpod_todo/common/widgets/width_spacer.dart';

import '../../../common/utlis/app_const.dart';

class NotificationPage extends StatelessWidget {
  const NotificationPage({super.key, this.payload});

  final String? payload;

  @override
  Widget build(BuildContext context) {
    var title = payload!.split(('|')[0]);
    var desc =payload!.split(('|')[1]);
    // var date =payload!.split(('|')[2]);
    var start =payload!.split(('|')[3]);
    var end =payload!.split(('|')[4]);

    return Scaffold(
      appBar: AppBar(
          elevation: 0,
          backgroundColor: AppConst.lightPurple,
          title: Text(
            "Notifications",
            style: appStyle(25, AppConst.white, FontWeight.normal),
          ),
          leading: InkWell(
            child: const Icon(
              AntDesign.back,
              color: AppConst.white,
            ),
            onTap: () {
              Navigator.pop(context);
            },
          )),
      body: SafeArea(
        child: Stack(
          clipBehavior: Clip.none,
          children: [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 10.h, vertical: 20.w),
              child: Container(
                width: AppConst.width,
                height: AppConst.height * 0.7,
                decoration: BoxDecoration(
                  color: AppConst.lightGrey,
                  borderRadius: BorderRadius.circular(AppConst.radius),
                ),
                child: Padding(
                  padding: EdgeInsets.all(12.h),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ReusableText(
                          style: appStyle(
                              40, AppConst.lightPurple, FontWeight.bold),
                          text: "Reminder"),
                      const HeightSpacer(height: 5),
                      Container(
                        width: AppConst.width,
                        padding: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          color: AppConst.grey,
                          borderRadius: BorderRadius.all(Radius.circular(9.h)),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            ReusableText(
                                style: appStyle(
                                    16, AppConst.beige, FontWeight.w600),
                                text: "today |"),
                            const WidthSpacer(width: 15),
                            ReusableText(
                                style: appStyle(
                                    16, AppConst.beige, FontWeight.bold),
                                text: "From: $start To $end"),
                          ],
                        ),
                      ),
                      ReusableText(
                          style: appStyle(30, AppConst.pink, FontWeight.bold),
                          text:title.toString()),
                      const HeightSpacer(height: 10),
                      Text(
                        desc.toString(),
                        textAlign: TextAlign.justify,
                        maxLines: 8,
                        style: appStyle(16, AppConst.black, FontWeight.normal),
                      ),
                      const HeightSpacer(height: 10),
                    ],
                  ),
                ),
              ),
            ),
            Positioned(
                right: 0.w,
                top: 10.h,
                child: Image.asset(
                  'assets/images/bell.png',
                  width: 80.w,
                  height: 80.h,
                )),
            Positioned(
                bottom: AppConst.width * 0.2,
                left: 0,
                right: AppConst.width * 0.1,
                child: Image.asset(
                  'assets/images/11.png',
                  width: 400.w,
                  height: 400.h,
                )),
          ],
        ),
      ),
    );
  }
}

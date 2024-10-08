import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:riverpod_todo/common/utlis/app_const.dart';
import 'package:riverpod_todo/common/widgets/app_style.dart';
import 'package:riverpod_todo/common/widgets/height_spacer.dart';
import 'package:riverpod_todo/common/widgets/reusable.dart';
import 'package:riverpod_todo/common/widgets/width_spacer.dart';

class TodoTile extends StatelessWidget {
  const TodoTile(
      {super.key, required this.color, this.title, this.description, this.start, this.end, this.editWidget, this.delete, this.switcher});

  final Color? color;
  final String? title;
  final String? description;
  final String? start;
  final String? end;
  final Widget? editWidget;
  final void Function()? delete;
  final Widget? switcher;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: Stack(
        children: [
          Container(
            padding: EdgeInsets.all(8.h),
            width: AppConst.width,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(AppConst.radius),
              color: AppConst.lightPurple,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Container(
                      height: 80,
                      width: 6,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(AppConst.radius),
                          color: color ?? AppConst.pink),
                    ),
                    const HeightSpacer(height: 15),
                    Padding(
                      padding: EdgeInsets.only(left:18.h,top: 10.h,bottom: 10.h),
                      child: SizedBox(
                        width: AppConst.width*0.6,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            ReusableText(
                                text: title ?? "Title of task ",
                                style: appStyle(
                                    20, AppConst.black, FontWeight.bold)),
                            const HeightSpacer(height: 15),
                            ReusableText(
                                text: description ?? "Description of task ",
                                style: appStyle(
                                    15, AppConst.grey, FontWeight.bold)),
                            const HeightSpacer(height: 12),
                            SizedBox(
                              width:AppConst.width*0.6,
                              child: Row(
                                children: [
                                  Container(
                                    width: AppConst.width * 0.3,
                                    height: 25.h,
                                    decoration: BoxDecoration(
                                      border: Border.all(
                                          width: 0.3, color: AppConst.grey),
                                      borderRadius:
                                      BorderRadius.circular(AppConst.radius),
                                      color: AppConst.lightGrey,
                                    ),
                                    child: Center(
                                        child: ReusableText(
                                            text: "$start | $end", style: appStyle(15, AppConst.black, FontWeight.normal))),
                                  ),

                                  Row(
                                    children: [
                                      SizedBox(
                                        child: editWidget,
                                      ),
                                       WidthSpacer(width: 40.h),
                                      GestureDetector(
                                        onTap:delete ,
                                        child:  const Icon(MaterialCommunityIcons.delete_circle,color: AppConst.lightGrey,size: 30,),
                                      )

                                    ],
                                  ),
                                ],
                              ),
                            ),

                          ],
                        ),
                      ),
                    )
                  ],
                ),
                Container(
                  padding: EdgeInsets.only(bottom: 0.h),
                  child: switcher,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:riverpod_todo/common/utlis/app_const.dart';
import 'package:riverpod_todo/common/widgets/app_style.dart';
import 'package:riverpod_todo/common/widgets/reusable.dart';
import 'package:riverpod_todo/common/widgets/width_spacer.dart';

import '../../features/todo/controllers/todo/todo_provider.dart';

class BottomTitles extends StatelessWidget {
  const BottomTitles({super.key, required this.text, required this.text2,  this.color});
  final String text;
  final String text2;
  final Color? color;


  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: AppConst.width,
      child: Padding(
        padding: const EdgeInsets.all(8),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Consumer(
              builder: (context, ref, child) {
             var color= ref.read(todoStateProvider.notifier).getRandomColor();
                return Container(
                  height: 80,
                  width: 5,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(AppConst.radius),
                    color: color,
                  ),
                );
              },
            ),
            const WidthSpacer(width: 15),
            Padding(
              padding: const EdgeInsets.all(8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ReusableText(
                    text: text,
                    style: appStyle(24, AppConst.black, FontWeight.bold),
                  ),
                  ReusableText(
                    text: text2,
                    style: appStyle(12, AppConst.black, FontWeight.normal),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

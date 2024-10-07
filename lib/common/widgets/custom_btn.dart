import 'package:flutter/material.dart';
import 'package:riverpod_todo/common/widgets/reusable.dart';

import 'app_style.dart';

class CustomBtn extends StatelessWidget {
  const CustomBtn(
      {super.key,
      required this.width,
      required this.height,
      required this.color,
      this.color2,
      required this.text,
      this.onTap});

  final void Function()? onTap;
  final double width;
  final double height;
  final Color? color2;
  final Color color;
  final String text;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
     child:
      Container(
        alignment: Alignment.center,
        width: width,
        height: height,
        decoration: BoxDecoration(
          color: color2,
          borderRadius: const BorderRadius.all(Radius.circular(15)),
          border: Border.all(width: 1,color: color,style: BorderStyle.solid)
        ),
        child: ReusableText(
            text: text, style: appStyle(18, color, FontWeight.bold)),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:riverpod_todo/common/utlis/app_const.dart';
import 'package:riverpod_todo/common/widgets/titles.dart';

class XpansionTile extends StatelessWidget {
  const XpansionTile(
      {super.key, required this.text, required this.text2, this.onExpansionChanged, this.trailing, required this.children});

  final String text;
  final String text2;
  final void Function(bool)? onExpansionChanged;
  final Widget? trailing;
  final List<Widget>children;


  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppConst.white,
        borderRadius: BorderRadius.circular(AppConst.radius),
      ),
      child: Theme(
        data: Theme.of(context).copyWith(dividerColor: Colors.transparent),
        child: ExpansionTile(
          title: BottomTitles(
              text: text,
              text2: text2),
          tilePadding: EdgeInsets.zero,
          children: children,
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:riverpod_todo/common/utlis/app_const.dart';
import 'package:riverpod_todo/common/widgets/app_style.dart';
import 'package:riverpod_todo/common/widgets/reusable.dart';
import 'package:riverpod_todo/features/todo/controllers/code_provider.dart';

class TestPage extends ConsumerWidget {
  const TestPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    String code=ref.watch(codeStateProvider);
    return Scaffold(
      appBar:AppBar(),
      body: Center(
        child: Column(
          children: [
            ReusableText(text: code, style: appStyle(30, AppConst.white, FontWeight.bold)),
            TextButton(
              onPressed: () {
                ref.read(codeStateProvider.notifier).setStart("hello ");
              },
              child: const Text("press me"),
            ),
          ],
        ),

      ),
    );
  }
}

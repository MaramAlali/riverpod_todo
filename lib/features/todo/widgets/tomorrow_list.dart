import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:riverpod_todo/features/todo/controllers/todo/todo_provider.dart';
import 'package:riverpod_todo/features/todo/pages/update_page.dart';
import 'package:riverpod_todo/features/todo/widgets/todo_tile.dart';
import '../../../common/utlis/app_const.dart';
import '../../../common/widgets/xpansion_tile.dart';
import '../controllers/xpansion_provider.dart';

class TomorrowList extends ConsumerWidget {
  const TomorrowList({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final todos = ref.watch(todoStateProvider);
    var color = ref.read(todoStateProvider.notifier).getRandomColor();
    String tomorrow = ref.read(todoStateProvider.notifier).getTomorrow();

    var tomorrowTasks =
        todos.where((element) => element.date!.contains(tomorrow));
    return XpansionTile(
        text: "tomorrow task",
        text2: "expanded to show tomorrow task",
        onExpansionChanged: (bool expanded) {
          ref.read(xpansionStateProvider.notifier).setStart(expanded);
        },
        trailing: Padding(
          padding: EdgeInsets.only(right: 12.0.w),
          child: ref.watch(xpansionStateProvider)
              ? const Icon(
                  AntDesign.circledown,
                  color: AppConst.white,
                )
              : const Icon(
                  AntDesign.closecircleo,
                  color: AppConst.brown,
                ),
        ),
        children: [
          for (final todo in tomorrowTasks)
            TodoTile(
              title: todo.title,
              description: todo.description,
              start: todo.startTime,
              end: todo.endTime,
              color: color,
              delete: () {
                ref.read(todoStateProvider.notifier).deleteTodo(todo.id??0);
              },
              editWidget: GestureDetector(
                onTap: () {
                  titles=todo.title.toString();
                  descriptions=todo.description.toString();
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>  UpdateTask( id:todo.id??0)));
                },
                  child:
                  SizedBox(width: 40.w,
                    child: const Icon(MaterialCommunityIcons.circle_edit_outline,color: AppConst.lightGrey,),)
              ),
              switcher: const SizedBox.shrink(),
            ),
        ]);
  }
}

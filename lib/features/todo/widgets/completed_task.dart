import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:riverpod_todo/features/todo/widgets/todo_tile.dart';
import '../../../common/models/task_model.dart';
import '../../../common/utlis/app_const.dart';
import '../controllers/todo/todo_provider.dart';

class CompletedTask extends ConsumerWidget {
  const CompletedTask({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    List<TaskModel> listData = ref.read(todoStateProvider);
    List last30days = ref.read(todoStateProvider.notifier).last30Days();
    var completedList = listData
        .where((element) =>
    element.isCompleted == 1 || last30days.contains(element.date!.substring(0,10))).toList();
    return ListView.builder(
        itemCount: completedList.length,
        itemBuilder: (context, index) {
          final data = completedList[index];
          dynamic color=ref.read(todoStateProvider.notifier).getRandomColor();
          return TodoTile(
            delete: () {
              ref.read(todoStateProvider.notifier).deleteTodo(data.id??0);
            },
              editWidget:const SizedBox.shrink(),
              title: data.title,
              description: data.description,
              start: data.startTime,
              end: data.endTime,
              color: color,
              switcher: const Icon(AntDesign.checkcircle,color: AppConst.lightGreen,),
          );
        });
  }
}

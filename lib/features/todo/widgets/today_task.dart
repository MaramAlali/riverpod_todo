import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:riverpod_todo/features/todo/widgets/todo_tile.dart';
import '../../../common/models/task_model.dart';
import '../../../common/utlis/app_const.dart';
import '../controllers/todo/todo_provider.dart';
import '../pages/update_page.dart';

class TodayTasks extends ConsumerWidget {
  const TodayTasks({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    List<TaskModel> listData = ref.read(todoStateProvider);
    String today = ref.read(todoStateProvider.notifier).getToday();
    var todayList = listData
        .where((element) =>
            element.isCompleted == 0 && element.date!.contains(today))
        .toList();
    return ListView.builder(
        itemCount: todayList.length,
        itemBuilder: (context, index) {
          final data = todayList[index];
          bool isCompleted =
              ref.read(todoStateProvider.notifier).getStatus(data);
          dynamic color = ref.read(todoStateProvider.notifier).getRandomColor();
          return TodoTile(
              delete: () {
                ref.read(todoStateProvider.notifier).deleteTodo(data.id ?? 0);
              },
              editWidget: GestureDetector(
                onTap: () {
                  titles=data.title.toString();
                  descriptions=data.description.toString();


                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>  UpdateTask( id:data.id??0)));
                },
                child: const Padding(
                  padding: EdgeInsets.only(left: 8.0),
                  child: Icon(MaterialCommunityIcons.circle_edit_outline,color: AppConst.white,),
                ),
              ),
              title: data.title,
              description: data.description,
              start: data.startTime,
              end: data.endTime,
              color: color,
              switcher: Switch(
                  value: isCompleted,
                  onChanged: (value) {
                    ref.read(todoStateProvider.notifier).markIsCompleted(
                        data.id ?? 0,
                        data.title.toString(),
                        data.description.toString(),
                        1,
                        data.date.toString(),
                        data.startTime.toString(),
                        data.endTime.toString());
                  }));
        });
  }
}

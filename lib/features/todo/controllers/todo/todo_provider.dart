import 'dart:math';

import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:riverpod_todo/common/helpers/dp_helper.dart';
import 'package:riverpod_todo/common/models/task_model.dart';

import '../../../../common/utlis/app_const.dart';

part 'todo_provider.g.dart';

@riverpod
class TodoState extends _$TodoState {
  @override
  List<TaskModel> build() {
    return [];
  }

  void refresh() async {
    final data = await DBHelper.getItems();
    state = data.map((e) => TaskModel.fromJson(e)).toList();
  }

  void addItem(TaskModel taskModel) async {
    await DBHelper.createItem(taskModel);
    refresh();
  }

  dynamic getRandomColor(){
    Random random=Random();
    int randomIndex=random.nextInt(colors.length);
    return colors[randomIndex];


  }

  void updateItem(int id, String title, String desc, int isCompleted,
      String date, String startTime, String endTime) async {
    await DBHelper.updateItem(
        id, title, desc, isCompleted, date, startTime, endTime);
    refresh();
  }

  Future<void> deleteTodo(int id) async {
    await DBHelper.deleteItem(id);
    refresh();
  }

  void markIsCompleted(int id, String title, String desc, int isCompleted,
      String date, String startTime, String endTime) async {
    await DBHelper.updateItem(id, title, desc, 1, date, startTime, endTime);
    refresh();
  }

//today
  String getToday() {
    DateTime today = DateTime.now();
    return today.toString().substring(0, 10);
  }

  //today
  String getTomorrow() {
    DateTime tomorrow = DateTime.now().add(const Duration(days: 1));
    return tomorrow.toString().substring(0, 10);
  }
  String getDaysAfterTomorrow() {
    DateTime tomorrow = DateTime.now().add(const Duration(days: 2));
    return tomorrow.toString().substring(0, 10);
  }

  List<String> last30Days() {
    DateTime today = DateTime.now();
    DateTime oneMonthAgo = today.subtract(const Duration(days: 30));
    List<String> dates = [];
    for (int i = 0; i < 30; i++) {
      DateTime date = oneMonthAgo.add(Duration(days: i));
      dates.add(date.toString().substring(0, 10));
    }
    return dates;
  }

  bool getStatus(TaskModel taskModel){
    bool? isCompleted;

    if(taskModel.isCompleted==0){
      isCompleted=false;
    }else {
      isCompleted=true;
    }
    return isCompleted;
  }
}

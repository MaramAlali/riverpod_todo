import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:riverpod_todo/common/models/task_model.dart';
import 'package:riverpod_todo/common/utlis/app_const.dart';
import 'package:riverpod_todo/common/widgets/app_style.dart';
import 'package:riverpod_todo/common/widgets/custom_btn.dart';
import 'package:riverpod_todo/common/widgets/custom_text_field.dart';
import 'package:riverpod_todo/common/widgets/height_spacer.dart';
import 'package:flutter_datetime_picker_plus/flutter_datetime_picker_plus.dart'
    as picker;
import 'package:riverpod_todo/features/todo/controllers/todo/todo_provider.dart';
import '../../../common/helpers/notification_helper.dart';
import '../../../common/widgets/show_dialog.dart';
import '../controllers/dates/dates_provider.dart';
import 'home_page.dart';

class AddTask extends ConsumerStatefulWidget {
  const AddTask({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _AddTaskState();
}

class _AddTaskState extends ConsumerState<AddTask> {
  final TextEditingController title = TextEditingController();
  final TextEditingController desc = TextEditingController();
  late NotificationHelper notificationHelper;
  late NotificationHelper controller;
  final TextEditingController search = TextEditingController();
  List<int> notification = [];

  @override
  void initState() {
    notificationHelper = NotificationHelper(ref: ref);
    Future.delayed(const Duration(seconds: 0), () {
      controller = NotificationHelper(ref: ref);
    });
    notificationHelper.initializeNotification();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var scheduleDate = ref.watch(dateStateProvider);
    var startTime = ref.watch(startTimeStateProvider);
    var endTime = ref.watch(finishTimeStateProvider);
    return Scaffold(
      appBar: AppBar(
          backgroundColor: AppConst.lightPurple,
          title: Text(
            "Add Task",
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
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.w),
        child: ListView(
          children: [
            const HeightSpacer(height: 20),
            CustomTextField(
              hintText: "    Add Title",
              controller: title,
              hintStyle: appStyle(16, AppConst.black, FontWeight.w600),
            ),
            const HeightSpacer(height: 20),
            CustomTextField(
              hintText: "    Add description",
              controller: desc,
              hintStyle: appStyle(16, AppConst.black, FontWeight.w600),
            ),
            const HeightSpacer(height: 20),
            CustomBtn(
              width: AppConst.width,
              height: 52.h,
              color: AppConst.white,
              color2: AppConst.lightPurple,
              text: scheduleDate == ""
                  ? "set Date"
                  : scheduleDate.substring(0, 10),
              onTap: () {
                picker.DatePicker.showDatePicker(context,
                    showTitleActions: true,
                    minTime: DateTime.now(),
                    theme: const picker.DatePickerTheme(
                        doneStyle: TextStyle(
                            color: AppConst.lightGreen,
                            fontSize: 16)), onConfirm: (date) {
                  ref.read(dateStateProvider.notifier).setDate(date.toString());
                }, currentTime: DateTime.now(), locale: picker.LocaleType.en);
              },
            ),
            const HeightSpacer(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                CustomBtn(
                  onTap: () {
                    picker.DatePicker.showDateTimePicker(context,
                        showTitleActions: true, onConfirm: (date) {
                      notification =
                          ref.read(startTimeStateProvider.notifier).dates(date);
                      ref.read(startTimeStateProvider.notifier).setStart(date.toString());
                    }, locale: picker.LocaleType.en);
                  },
                  width: AppConst.width * 0.4,
                  height: 52.h,
                  color: AppConst.white,
                  color2: AppConst.lightPurple,
                  text: startTime == ""
                      ? "start time"
                      : startTime.substring(10, 16),
                ),
                CustomBtn(
                  onTap: () {
                    picker.DatePicker.showDateTimePicker(context,
                        showTitleActions: true, onConfirm: (date) {
                      ref
                          .read(finishTimeStateProvider.notifier)
                          .setStart(date.toString());
                    }, locale: picker.LocaleType.en);
                  },
                  width: AppConst.width * 0.4,
                  height: 52.h,
                  color: AppConst.white,
                  color2: AppConst.lightPurple,
                  text: endTime == "" ? "end time" : endTime.substring(10, 16),
                ),
              ],
            ),
            const HeightSpacer(height: 20),
            CustomBtn(
              onTap: () {
                if (title.text.isNotEmpty &&
                    scheduleDate.isNotEmpty &&
                    startTime.isNotEmpty &&
                    endTime.isNotEmpty &&
                    desc.text.isNotEmpty) {
                  TaskModel task = TaskModel(
                      title: title.text,
                      description: desc.text,
                      date: scheduleDate,
                      startTime: startTime.substring(10, 16),
                      endTime: endTime.substring(10, 16),
                      isCompleted: 0,
                      remind: 0,
                      repeat: "yes");

                  notificationHelper.scheduledNotifications(notification[0],
                      notification[1], notification[2], notification[3], task);

                  ref.read(todoStateProvider.notifier).addItem(task);
                  ref.read(finishTimeStateProvider.notifier).setStart('');
                  ref.read(startTimeStateProvider.notifier).setStart('');
                  ref.read(dateStateProvider.notifier).setDate('');
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const HomePage()));
                } else {
                  showAlertDialog(
                      context: context, message: "Failed to add task");
                }
              },
              width: AppConst.width,
              height: 52.h,
              color: AppConst.white,
              color2: AppConst.pink,
              text: "save",
            ),
          ],
        ),
      ),
    );
  }
}

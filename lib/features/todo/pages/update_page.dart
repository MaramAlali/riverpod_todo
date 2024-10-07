import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:riverpod_todo/common/utlis/app_const.dart';
import 'package:riverpod_todo/common/widgets/app_style.dart';
import 'package:riverpod_todo/common/widgets/custom_btn.dart';
import 'package:riverpod_todo/common/widgets/custom_text_field.dart';
import 'package:riverpod_todo/common/widgets/height_spacer.dart';
import 'package:flutter_datetime_picker_plus/flutter_datetime_picker_plus.dart'
    as picker;
import 'package:riverpod_todo/features/todo/controllers/dates/dates_provider.dart';
import 'package:riverpod_todo/features/todo/controllers/todo/todo_provider.dart';

class UpdateTask extends ConsumerStatefulWidget {
  const UpdateTask({super.key, required this.id});

  final int id;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _AddTaskState();
}

class _AddTaskState extends ConsumerState<UpdateTask> {
  TextEditingController title = TextEditingController(text: titles);
  TextEditingController desc = TextEditingController(text: descriptions);

  @override
  Widget build(BuildContext context) {
    var scheduleDate = ref.watch(dateStateProvider);
    var startTime = ref.watch(startTimeStateProvider);
    var endTime = ref.watch(finishTimeStateProvider);
    return Scaffold(
      appBar: AppBar(
          backgroundColor: AppConst.lightPurple,
          title: Text(
            "Update Task",
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
              hintText: "    Update Title",
              controller: title,
              hintStyle: appStyle(16, AppConst.black, FontWeight.w600),
            ),
            const HeightSpacer(height: 20),
            CustomTextField(
              hintText: "    Update description",
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
                      ref
                          .read(startTimeStateProvider.notifier)
                          .setStart(date.toString());
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
                  ref.read(todoStateProvider.notifier).updateItem(
                      widget.id,
                      title.text,
                      desc.text,
                      0,
                      scheduleDate,
                      startTime.substring(10, 16),
                      endTime.substring(10, 16));
                  ref.read(finishTimeStateProvider.notifier).setStart('');
                  ref.read(startTimeStateProvider.notifier).setStart('');
                  ref.read(dateStateProvider.notifier).setDate('');
                  Navigator.pop(context);
                } else {}
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

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:riverpod_todo/common/utlis/app_const.dart';
import 'package:riverpod_todo/common/widgets/height_spacer.dart';
import 'package:riverpod_todo/features/todo/controllers/todo/todo_provider.dart';
import 'package:riverpod_todo/features/todo/widgets/today_task.dart';
import 'package:riverpod_todo/features/todo/widgets/tomorrow_list.dart';
import '../../../common/helpers/notification_helper.dart';
import '../../../common/widgets/app_style.dart';
import '../../../common/widgets/reusable.dart';
import '../../../common/widgets/width_spacer.dart';
import '../widgets/completed_task.dart';
import 'add_page.dart';
import '../widgets/day_after_tomorrow.dart';

class HomePage extends ConsumerStatefulWidget {
  const HomePage({super.key});

  @override
  ConsumerState<HomePage> createState() => _HomePage();
}

class _HomePage extends ConsumerState<HomePage> with TickerProviderStateMixin {
  late final TabController tabController =
      TabController(length: 2, vsync: this);
  final TextEditingController search = TextEditingController();
  late NotificationHelper notificationHelper;
  late NotificationHelper controller;

  @override
  void initState() {
    notificationHelper = NotificationHelper(ref: ref);
    Future.delayed(const Duration(milliseconds: 500 ), () {
      controller = NotificationHelper(ref: ref);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    ref.watch(todoStateProvider.notifier).refresh();

    return Scaffold(
        appBar: AppBar(
          backgroundColor: AppConst.lightPurple,
          automaticallyImplyLeading: false,
          bottom: PreferredSize(
              preferredSize: Size.fromHeight(20.h),
              child: Column(
                children: [
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20.w),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Image.asset(
                          "assets/images/icon.png",
                          width:65 ,
                          height: 50,
                        ),
                        ReusableText(
                            text: "TaskTracker",
                            style:
                                appStyle(35, AppConst.pink, FontWeight.normal)),
                        Container(
                          width: 30,
                          height: 30,
                          decoration: const BoxDecoration(
                            color: AppConst.lightGrey,
                            borderRadius: BorderRadius.all(Radius.circular(9)),
                          ),
                          child: InkWell(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => const AddTask()));
                            },
                            child: const Icon(
                              Icons.add,
                              color: AppConst.black,
                              size: 20,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  HeightSpacer(height: 20.h),
                  // Padding(
                  //   padding: EdgeInsets.all(18.h),
                  //   child: CustomTextField(
                  //     hintText: "Search",
                  //     hintStyle: appStyle(20, AppConst.grey, FontWeight.normal),
                  //     controller: search,
                  //     prefixIcon: Container(
                  //       padding: EdgeInsets.all(10.h),
                  //       child: GestureDetector(
                  //         onTap: () {},
                  //         child: const Icon(
                  //           AntDesign.search1,
                  //           color: AppConst.black,
                  //         ),
                  //       ),
                  //     ),
                  //     suffixIcon:Container(
                  //       padding: EdgeInsets.all(10.h),
                  //     child: GestureDetector(
                  //       onTap: () {
                  //         Navigator.push(
                  //             context,
                  //             MaterialPageRoute(
                  //                 builder: (context) => HomePage()));
                  //       },
                  //       child:  const Icon(
                  //         FontAwesome.sliders,
                  //         color: AppConst.black,
                  //       ),
                  //     ),
                  //   ),
                  //
                  //
                  //   ),
                  // ),
                ],
              )),
        ),
        body: SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.w),
            child: ListView(
              children: [
                const HeightSpacer(height: 25),
                Row(
                  children: [
                    const Icon(
                      FontAwesome.tasks,
                      size: 18,
                      color: AppConst.lightGrey,
                    ),
                    const WidthSpacer(width: 10),
                    ReusableText(
                        text: "Today Tasks",
                        style: appStyle(30, AppConst.white, FontWeight.normal)),
                  ],
                ),
                const HeightSpacer(height: 25),
                Container(
                  decoration: BoxDecoration(
                    color: AppConst.grey,
                    borderRadius:
                        BorderRadius.all(Radius.circular(AppConst.radius)),
                  ),
                  child: TabBar(
                      indicatorSize: TabBarIndicatorSize.label,
                      indicator: BoxDecoration(
                        color: AppConst.pink,
                        borderRadius: BorderRadius.circular(AppConst.radius),
                      ),
                      controller: tabController,
                      labelPadding: EdgeInsets.zero,
                      isScrollable: false,
                      labelColor: AppConst.grey,
                      tabs: [
                        Tab(
                          child: SizedBox(
                            width: AppConst.width * 0.5,
                            child: Center(
                              child: ReusableText(
                                  text: "Pending",
                                  style: appStyle(
                                      16, AppConst.black, FontWeight.bold)),
                            ),
                          ),
                        ),
                        Tab(
                          child: Container(
                            padding: EdgeInsets.only(left: 30.w),
                            width: AppConst.width * 0.5,
                            child: Center(
                              child: ReusableText(
                                  text: "Completed",
                                  style: appStyle(
                                      16, AppConst.black, FontWeight.bold)),
                            ),
                          ),
                        ),
                      ]),
                ),
                const HeightSpacer(height: 20),
                SizedBox(
                  height: AppConst.height * 0.3,
                  width: AppConst.width,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(AppConst.radius),
                    child: TabBarView(controller: tabController, children: [
                      Container(
                          height: AppConst.height * 0.3,
                          color: AppConst.lightGrey,
                          child: const TodayTasks()),
                      Container(
                        height: AppConst.height * 0.3,
                        color: AppConst.lightGrey,
                        child: const CompletedTask(),
                      ),
                    ]),
                  ),
                ),
                const HeightSpacer(height: 20),
                ReusableText(
                    text: "Tomorrow Tasks",
                    style: appStyle(30, AppConst.white, FontWeight.normal)),
                const HeightSpacer(height: 25),
                const TomorrowList(),
                const HeightSpacer(height: 20),
                ReusableText(
                    text: "Soon Tasks",
                    style: appStyle(30, AppConst.white, FontWeight.normal)),
                const HeightSpacer(height: 25),
                const DaysAfterTomorrow(),
                const HeightSpacer(height: 20),
              ],
            ),
          ),
        ));
  }
}

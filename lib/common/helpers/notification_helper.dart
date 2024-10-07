import 'package:flutter/cupertino.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:riverpod_todo/common/models/task_model.dart';
import 'package:rxdart/rxdart.dart';
import 'package:timezone/timezone.dart' as tz;
import 'package:timezone/data/latest.dart' as tz;
import 'package:flutter/material.dart';
import '../../features/todo/pages/notification_page.dart';

class NotificationHelper {
  final WidgetRef ref;

  NotificationHelper({required this.ref});

  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
  FlutterLocalNotificationsPlugin();
  String? selectNotificationPayload;
  final BehaviorSubject<String?> selectNotificationSubject =
  BehaviorSubject<String?>();

  initializeNotification() async {
    _configureSelectNotificationSubject();
    await _configureLocalTimeZone();
    final DarwinInitializationSettings initializationSettingsIOS =
    DarwinInitializationSettings(
        requestAlertPermission: false,
        requestBadgePermission: false,
        requestSoundPermission: false,
        onDidReceiveLocalNotification: onDidReceiveLocalNotification);

    const AndroidInitializationSettings androidInitializationSettings =
    AndroidInitializationSettings("logo");
    final InitializationSettings initializationSettings =
    InitializationSettings(
      android: androidInitializationSettings,
      iOS: initializationSettingsIOS,
    );

    await flutterLocalNotificationsPlugin.initialize(initializationSettings,
        onDidReceiveNotificationResponse: (data) async {
          debugPrint('Notification payload: ${data.payload}');
          selectNotificationSubject.add(data.payload);
        });
  }

  void requestIOSPermissions() {
    flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<
        IOSFlutterLocalNotificationsPlugin>()
        ?.requestPermissions(
      alert: true,
      badge: true,
      sound: true,
    );
  }

  Future<void> _configureLocalTimeZone() async {
    tz.initializeTimeZones();
    const String timeZoneName = 'Asia/Damascus';
    tz.setLocalLocation(tz.getLocation(timeZoneName));


  }

  Future onDidReceiveLocalNotification(int id, String? title, String? body,
      String? payload) async {
    showDialog(
        context: ref.context,
        builder: (BuildContext context) =>
            CupertinoAlertDialog(
              title: Text(title ?? ""),
              content: Text(body ?? ""),
              actions: [
                CupertinoDialogAction(
                  isDestructiveAction: true,
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Text("Close"),
                ),
                CupertinoDialogAction(
                  isDestructiveAction: true,
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Text("view"),
                )
              ],
            ));
  }

  scheduledNotifications(int days, int hours, int minutes, int seconds,
      TaskModel taskModel) async {
    await flutterLocalNotificationsPlugin.zonedSchedule(
        taskModel.id ?? 0,
        taskModel.title,
        taskModel.description,
        tz.TZDateTime.now(tz.local).add(Duration(
            days: days, hours: hours, minutes: minutes, seconds: seconds)),
        const NotificationDetails(
            android: AndroidNotificationDetails("channelId", "channelName")),
        uiLocalNotificationDateInterpretation:
        UILocalNotificationDateInterpretation.absoluteTime,
        androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
        matchDateTimeComponents: DateTimeComponents.time,
        payload:
        "${taskModel.title}|${taskModel.description}|${taskModel
            .date}|${taskModel.startTime}|${taskModel.endTime}");
  }

  void _configureSelectNotificationSubject() {
    selectNotificationSubject.stream.listen((String? payload) async {
      var title = payload!.split(('|')[0]);
      var body = payload.split(('|')[1]);
      showDialog(
          context: ref.context,
          builder: (BuildContext context) =>
              CupertinoAlertDialog(
                title: Text(title.toString()),
                content: Text(
                  body.toString(),
                  textAlign: TextAlign.justify,
                  maxLines: 4,
                ),
                actions: [
                  CupertinoDialogAction(
                    isDestructiveAction: true,
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: const Text("Close"),
                  ),
                  CupertinoDialogAction(
                    isDestructiveAction: true,
                    child: const Text("view"),
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  NotificationPage(payload: payload)));
                    },

                  )
                ],
              ));
    });
  }
}

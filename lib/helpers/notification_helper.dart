import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class NotificationHelper {
  FlutterLocalNotificationsPlugin notification =
      FlutterLocalNotificationsPlugin();

  NotificationHelper() {
    var initializationSettingsAndroid =
        new AndroidInitializationSettings('@mipmap/ic_launcher');
    var initializationSettingsIOS = new IOSInitializationSettings();
    var initializationSettings = new InitializationSettings(
        initializationSettingsAndroid, initializationSettingsIOS);
    notification.initialize(initializationSettings);
  }

  deleteNoti(int id)
{
  notification.cancel(id);
}


  showDailyNotification(int id, {Time time, String medication}) async {
    print("here");

    var androidPlatformChannelSpecifics = new AndroidNotificationDetails(
        'you,n id', 'your jkb name', 'your hjbb description',
        importance: Importance.Max, priority: Priority.High);
    var iOSPlatformChannelSpecifics = IOSNotificationDetails();

    var platformChannelSpecifics = new NotificationDetails(
        androidPlatformChannelSpecifics, iOSPlatformChannelSpecifics);
    await notification
        .showDailyAtTime(
      id,
      medication,
      'dont forget your medicine',
      time,
      platformChannelSpecifics,
    )
        .catchError((onError) {
      print(onError.toString());
    });
  }

  showWeaklyNotification(int id,
      {Time time, String medication, Day day}) async {
    print("here week");
    var androidPlatformChannelSpecifics = new AndroidNotificationDetails(
        'you 2 id', 'your 2 name', 'your 2 description',
        importance: Importance.Max, priority: Priority.High);
    var iOSPlatformChannelSpecifics = IOSNotificationDetails();

    var platformChannelSpecifics = new NotificationDetails(
        androidPlatformChannelSpecifics, iOSPlatformChannelSpecifics);

    await notification
        .showWeeklyAtDayAndTime(
      id,
      medication,
      'dont forget your medicine',
      day,
      time,
      platformChannelSpecifics,
    )
        .catchError((onError) {
      print(onError.toString());
    });
  }
}

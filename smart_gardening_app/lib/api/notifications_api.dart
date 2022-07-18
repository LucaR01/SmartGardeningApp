import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class NotificationsAPI {
  static final _notifications = FlutterLocalNotificationsPlugin();
  //static final onNotifications = BehaviorSubject<String?>(); //TODO: uncomment

  static Future _notificationsDetails() async {
    return NotificationDetails(
      android: AndroidNotificationDetails(
        'channel id',
        'channel name',
        //'channel description', //TODO: remove?
        //channelDescription: 'channel description', // Questo da errore!
        importance: Importance.max,
      ),
      iOS: IOSNotificationDetails(),
    );
  }

  //TODO: uncomment
  /*static Future init({bool initScheduled = false}) async {
    final android = AndroidInitializationSettings('@mipmap/ic_launcher');
    final iOS = IOSInitializationSettings();
    final settings = InitializationSettings(android: android, iOS: iOS);

    await _notifications.initialize(
      settings,
      onSelectNotification: (payload) async {
        //onNotifications.add(payload); //TODO: uncomment
      },
    );
  }*/

  static Future showNotification({
    int id = 0,
    String? title,
    String? body,
    String? payload,
  }) async => _notifications.show(id, title, body, await _notificationsDetails(), payload: payload);

}
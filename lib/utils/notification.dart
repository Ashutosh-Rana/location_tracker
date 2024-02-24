import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:location_tracker/main.dart';

Future<void> initializeNotifications() async {

  const AndroidInitializationSettings initializationSettingsAndroid =
      AndroidInitializationSettings('location_tracker_icon');
  final InitializationSettings initializationSettings = InitializationSettings(
    android: initializationSettingsAndroid,
  );

  flutterLocalNotificationsPlugin.initialize(initializationSettings);

}

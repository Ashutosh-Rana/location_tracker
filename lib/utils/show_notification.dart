import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:location_tracker/main.dart';

void showNotification(String title, String body) async {
  const AndroidNotificationDetails androidPlatformChannelSpecifics =
      AndroidNotificationDetails(
    'location_update_channel', // Change this channel ID as needed
    'Location Update',
    // 'Channel for location updates',
    importance: Importance.defaultImportance,
    priority: Priority.defaultPriority,
  );
  const NotificationDetails platformChannelSpecifics =
      NotificationDetails(android: androidPlatformChannelSpecifics);

  await flutterLocalNotificationsPlugin.show(
    0, // Notification ID
    title,
    body,
    platformChannelSpecifics,
    payload: 'location_update',
  );
}

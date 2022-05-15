import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:rxdart/rxdart.dart';

class NotificationApi {

  static final _notifications = FlutterLocalNotificationsPlugin();
  // static final onNotifications = BehaviorSubject<String?>();

  static Future init({bool scheduled = false}) async {
    var initAndroidSettings = AndroidInitializationSettings('mipmap/ic_launcher');
    var ios = IOSInitializationSettings();
    final settings = InitializationSettings(android: initAndroidSettings,iOS: ios);
    // when app is closed 
    // final details = await _notifications.getNotificationAppLaunchDetails();
    // if(details != null && details.didNotificationLaunchApp) {
    //   onNotifications.add(details.payload);
    // }
    await _notifications.initialize(
      settings,
      // onSelectNotification: (payload) async {
      //   onNotifications.add(payload);
      // }
    );
  }

  static notificationDetails() async {
    return NotificationDetails(
      android: AndroidNotificationDetails(
        'channel id',
        'channel name',
        'channel description',
        importance: Importance.max
      ),
      iOS: IOSNotificationDetails()
    );
  }

  static Future showNotification({
    var id = 0,
    var title,
    var body,
    var payload,
  }) async =>
      _notifications.show(
        id,
        title,
        body,
        await notificationDetails(),
        payload: payload
      );
}
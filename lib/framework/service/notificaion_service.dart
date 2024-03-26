import 'dart:convert';

import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:food_fly/framework/model/notification_model.dart';
import 'package:food_fly/framework/service/auth_service.dart';
import 'package:food_fly/framework/service/fire_store_service.dart';
import 'package:food_fly/main.dart';
import 'package:http/http.dart' as http;
import 'package:food_fly/ui/utils/theme/app_routes.dart';

Future<void> _onBackgroundMessage(RemoteMessage message) async {
  print(message.data);
}

class NotificationService {
  static late AwesomeNotifications awesomeNotifications;
  static late FirebaseMessaging firebaseMessaging;

  static init() {
    awesomeNotifications = AwesomeNotifications();
    firebaseMessaging = FirebaseMessaging.instance;
    awesomeNotifications.initialize(
        'resource://drawable/logo',
        [
          NotificationChannel(
              channelGroupKey: 'foodFlyChannel',
              channelKey: 'foodFly',
              channelName: 'Food fly ',
              channelDescription: 'Food fly food delviery applications',
              playSound: false,
              enableVibration: true,
              defaultRingtoneType: DefaultRingtoneType.Notification,
              importance: NotificationImportance.High,
              defaultPrivacy: NotificationPrivacy.Public,
              channelShowBadge: true)
        ],
        debug: true);
    firebaseMessaging.requestPermission(alert: true, sound: true, badge: true);
    FirebaseMessaging.onBackgroundMessage(_onBackgroundMessage);
    FirebaseMessaging.onMessageOpenedApp.listen(onNotificationTap);
    FirebaseMessaging.onMessage.listen((message) async {
      // print('message.data');
      // print(message.data);
      // await FireStoreService.fireStoreService.addNotificationToFirebase(
      //     NotificationDataModel(
      //         id: message.messageId.toString(),
      //         title: message.notification?.title ?? '',
      //         body: message.notification?.body ?? '',
      //         uid: AuthService.authService.auth.currentUser?.uid ?? ''));
      showNotification(message);
    });
    awesomeNotifications.setListeners(
        onActionReceivedMethod: onActionReceivedMethod);
    firebaseMessaging.getToken().then(
      (value) {
        print(value);
        print('fcm');
      },
    );
  }

  static Future<void> showNotification(RemoteMessage message) async {
    awesomeNotifications.createNotification(
        content: NotificationContent(
            id: message.hashCode,
            channelKey: 'foodFly',
            ticker: 'ticker',
            title: message.notification?.title,
            body: message.notification?.body,
            displayOnBackground: true,
            displayOnForeground: true,
            category: NotificationCategory.Message,
            notificationLayout: NotificationLayout.BigText));
  }

  static void onNotificationTap(RemoteMessage event) {
    MyApp.navigatorKey.currentState!.pushNamed(AppRoutes.notificationRoute);
  }

  static Future<void> onActionReceivedMethod(
      ReceivedAction receivedAction) async {
    MyApp.navigatorKey.currentState!.pushNamed(AppRoutes.notificationRoute);
  }

  static void sendNotification(String fcm, String title, String body) async {
    // Define the headers
    Map<String, String> headers = {
      'Content-Type': 'application/json',
      'Authorization':
          'key=AAAAvuI1jQs:APA91bGZllENvITHWFEmz-HseJwABegtjAz1WXtexR5Vg1mvOuzf9BWOe_nz-DQIFdmnogRULTFtiKOxLCydyb5AEL2Fk8EGdSCo4uARxe587eYFSSX0-1OW_3eYqGzCdDbZ7mCZKiZa'
    };

    // Define the request body
    Map<String, dynamic> requestBody = {
      "notification": {"title": title, "body": body},
      "priority": "high",
      "data": {"click_action": "FLUTTER_NOTIFICATION_CLICK"},
      "to": fcm
    };

    // Convert the request body to JSON
    String jsonBody = jsonEncode(requestBody);

    // Make the HTTP POST request
    try {
      http.Response response = await http.post(
        Uri.parse('https://fcm.googleapis.com/fcm/send'),
        headers: headers,
        body: jsonBody,
      );

      // Check the status code of the response
      if (response.statusCode == 200) {
        print('Notification sent successfully');
      } else {
        print(
            'Failed to send notification. Status code: ${response.statusCode}');
      }
    } catch (e) {
      print('Error sending notification: $e');
    }
  }
}

import 'dart:async';
import 'dart:convert';
import 'dart:math';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:send_me/_lib.dart';
import 'package:send_me/core/model/base_response.dart';
import 'package:http/http.dart' as http;
import 'package:send_me/core/services/navigation_service.dart';
import 'package:timezone/timezone.dart' as tz;

class NotificationHelper {
  final NavigationService _navigationService = locator<NavigationService>();
  final ProgressService _progressService = locator<ProgressService>();
  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();
  final FirebaseMessaging firebaseMessaging = FirebaseMessaging.instance;
  final String serverToken =
      'AAAAYXxLmjE:APA91bEeERbXPx1WkMw0tKYLHZ5mkx0k5eWBAeYmmscBFBrtZHzLAEKxQRrAyAzgnwUDqdJFA2mRygYRxp1NQyMSR2YtLTxvarEJrBNzwXoKcIu4Kw3GQ7fhC8qMCPc16TXqLjKQbnT3';
  String? _fcmToken;
  String? get fcmToken => _fcmToken;

  static const AndroidNotificationChannel channel = AndroidNotificationChannel(
    'high_importance_channel', // id
    'High Importance Notifications', // name
    description:
        'This channel is used for important notifications.', // description
    importance: Importance.max,
    ledColor: AppColors.primaryColor,
  );

  initialize() async {
    await firebaseMessaging.requestPermission(
        sound: true, badge: true, alert: true, provisional: false);
  }

  createChannel() async {
    await flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin>()!
        .createNotificationChannel(channel);
  }

  getFcmToken() async {
    var deviceToken = await FirebaseMessaging.instance.getToken();
    _fcmToken = deviceToken.toString();
    return deviceToken;
  }

  Future<void> init() async {
    const AndroidInitializationSettings initializationSettingsAndroid =
        AndroidInitializationSettings('launcher_icon');

    const IOSInitializationSettings initializationSettingsIOS =
        IOSInitializationSettings(
      requestSoundPermission: false,
      requestBadgePermission: false,
      requestAlertPermission: false,
      // onDidReceiveLocalNotification: onDidReceiveLocalNotification,
    );

    const InitializationSettings initializationSettings =
        InitializationSettings(
            android: initializationSettingsAndroid,
            iOS: initializationSettingsIOS,
            macOS: null);

    await flutterLocalNotificationsPlugin.initialize(initializationSettings,
        onSelectNotification: selectNotification);
  }

  Future selectNotification(String? message) {
    if (message != null) {
      return _navigationService.navigateReplacementTo(dashboardViewRoute);
    } else {
      throw BaseResponse(title: '', message: '');
    }
  }

  // Future onDidReceiveLocalNotification(int i, String j, k, l) {
  //   return _navigationService.navigateReplacementTo(HomePageRoute);
  // }

  Future<void> createSheduledAwesome(
      {DateTime? date, String? title, String? body}) async {
    var id = Random.secure().nextInt(50);
    await flutterLocalNotificationsPlugin.zonedSchedule(
        id,
        title,
        body,
        tz.TZDateTime.parse(tz.UTC, date.toString()),
        const NotificationDetails(
            android: AndroidNotificationDetails(
                'high_importance_channel', 'High Importance Notifications',
                channelDescription:
                    'This channel is used for important notifications.')),
        androidAllowWhileIdle: true,
        uiLocalNotificationDateInterpretation:
            UILocalNotificationDateInterpretation.absoluteTime);
  }

  Future<void> onMessage(BuildContext context) async {
    // Get any messages which caused the application to open from
    // a terminated state.
    RemoteMessage? initialMessage =
        await FirebaseMessaging.instance.getInitialMessage();
    if (initialMessage != null) {
      _handleMessage(initialMessage);
    }

    FirebaseMessaging.onMessage.listen((message) {
      if (message.notification != null) {
        RemoteNotification notification = message.notification!;
        AndroidNotification? android = message.notification?.android;
        if (notification != null && android != null) {
          flutterLocalNotificationsPlugin.show(
              notification.hashCode,
              notification.title,
              notification.body,
              NotificationDetails(
                android: AndroidNotificationDetails(
                  channel.id,
                  channel.name,
                  channelDescription: channel.description,
                  icon: android.smallIcon,
                  // other properties...
                ),
              ));
        }
        _progressService.showDialog(
            title: message.notification!.title,
            description: message.notification!.body);
      }
    });
  }

  Future<void> onMessageOpenApp() async {
    // Get any messages which caused the application to open from
    // a terminated state.
    RemoteMessage? initialMessage =
        await FirebaseMessaging.instance.getInitialMessage();

    // If the message also contains a data property with a "type" of "chat",
    // navigate to a chat screen
    if (initialMessage != null) {
      _handleMessage(initialMessage);
    }

    // Also handle any interaction when the app is in the background via a
    // Stream listener
    FirebaseMessaging.onMessageOpenedApp.listen(_handleMessage);
  }

  Future<void> onBackgroungMessage() async {
    RemoteMessage? initialMessage =
        await FirebaseMessaging.instance.getInitialMessage();

    // If the message also contains a data property with a "type" of "chat",
    // navigate to a chat screen
    if (initialMessage != null) {
      _handleMessage(initialMessage);
    }

    // Also handle any interaction when the app is in the background via a
    // Stream listener
    FirebaseMessaging.onBackgroundMessage(_handleMessage);
  }

  Future<void> _handleMessage(RemoteMessage message) async {
    if (message.notification!.body != null) {
      _navigationService.navigateReplacementTo(dashboardViewRoute);
    } else {
      return;
    }
  }

  sendAndRetrieveMessage(
      {String? title, String? body, bool? isSch, String? date}) async {
    initialize();
    http.Response response = await http.post(
      Uri.parse('https://fcm.googleapis.com/fcm/send'),
      headers: <String, String>{
        'Content-Type': 'application/json',
        'Authorization': 'key=$serverToken',
      },
      body: jsonEncode(
        <String, dynamic>{
          'notification': <String, dynamic>{'body': body, 'title': title},
          'priority': 'high',
          'data': <String, dynamic>{
            'click_action': 'FLUTTER_NOTIFICATION_CLICK',
            'id': '1',
            'status': 'done',
            "isScheduled": isSch,
            if (isSch == true) "scheduledTime": date
          },
          'to': fcmToken,
        },
      ),
    );
    if (kDebugMode) {
      print(response.body);
    }
    return response;

    // final Completer<Map<String, dynamic>> completer =
    //     Completer<Map<String, dynamic>>();

    // firebaseMessaging..configure(
    //   onMessage: (Map<String, dynamic> message) async {
    //     completer.complete(message);
    //   },
    // );

    // return completer.future;
  }
}

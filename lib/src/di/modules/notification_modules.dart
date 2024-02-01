import 'dart:convert';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import '../../features/detail_order/detail_order_view_model.dart';
import '../../features/profile/profile_view_model.dart';
import '../../models/shared_models/noti_res_model.dart';
import '../../utils/helpers/logger.dart';
import '../injection/injection.dart';

class NotificationModules extends DIModule {
  @override
  Future<void> register() async {
    FirebaseMessaging fcm = FirebaseMessaging.instance;
    NotificationSettings settings = await fcm.requestPermission(
      alert: true,
      announcement: true,
      badge: true,
      carPlay: false,
      criticalAlert: true,
      provisional: false,
      sound: true,
    );
    Logger.d('User granted permission', '${settings.authorizationStatus}');
    const android = AndroidInitializationSettings('@mipmap/ic_launcher');
    const iOS = DarwinInitializationSettings(
      requestAlertPermission: true,
      requestBadgePermission: true,
      requestSoundPermission: true,
    );
    const initSetttings = InitializationSettings(android: android, iOS: iOS);
    _flutterLocalNotificationsPlugin.initialize(
      initSetttings,
      onDidReceiveNotificationResponse: _onSelectNotification,
    );
    await _flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin>()
        ?.createNotificationChannel(channel);

    FirebaseMessaging.instance.getInitialMessage().then((value) {});
    FirebaseMessaging.onMessage.listen(_showFlutterNotification);
    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      Logger.d('A new onMessageOpenedApp event was published!', message);
    });
  }
}

enum NotificationType {
  order('order'),
  payment('payment');

  final String typeName;
  const NotificationType(this.typeName);

  factory NotificationType.fromName(String? name) {
    return values.firstWhere((element) => element.typeName == name);
  }
}

void _onSelectNotification(NotificationResponse details) {
  // if (details.payload?.isNotEmpty ?? false) {
  //   final noti = NotiResModel.fromJson(jsonDecode(details.payload!) as Map<String, dynamic>);
  //   final type = NotificationType.fromName(noti.theLoai);
  //   switch (type) {
  //     case NotificationType.order:
  // AppNavigator.push(Routes.detailOrder, arguments: noti.transactionId);
  //       break;
  //     default:
  //   }
  //   Logger.d('PAYLOAD', noti);
  // }
}

const AndroidNotificationChannel channel = AndroidNotificationChannel(
  'high_importance_channel',
  'High Importance Notifications',
  description: 'This channel is used for important notifications.',
  importance: Importance.max,
);
final FlutterLocalNotificationsPlugin _flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();

Future<void> firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp();
  _setupFlutterNotifications();
  _showFlutterNotification(message);
}

Future<void> _setupFlutterNotifications() async {
  await _flutterLocalNotificationsPlugin
      .resolvePlatformSpecificImplementation<
          AndroidFlutterLocalNotificationsPlugin>()
      ?.createNotificationChannel(channel);
  await FirebaseMessaging.instance.setForegroundNotificationPresentationOptions(
    alert: true,
    badge: true,
    sound: true,
  );
}

void _showFlutterNotification(RemoteMessage message) {
  Logger.d('Show Flutter Notification', message.toMap());
  RemoteNotification? notification = message.notification;
  if (notification != null) {
    _flutterLocalNotificationsPlugin.show(
      notification.hashCode,
      notification.title,
      notification.body,
      NotificationDetails(
        android: AndroidNotificationDetails(
          channel.id,
          channel.name,
          channelDescription: channel.description,
          icon: '@mipmap/ic_launcher',
        ),
      ),
      payload: jsonEncode(message.data),
    );
  }
  _handleReceiveNotification(message);
}

void _handleReceiveNotification(RemoteMessage message) async {
  final noti = NotiResModel.fromJson(message.data);
  final type = NotificationType.fromName(noti.theLoai);
  switch (type) {
    case NotificationType.payment:
      await getIt<ProfileViewModel>().getProfile();
      break;
    case NotificationType.order:
      await getIt<DetailOrderViewModel>().getDetailOrder();
      break;
    default:
      break;
  }
}

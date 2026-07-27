import 'dart:async';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

/// Runs when a push arrives while the app is terminated or backgrounded.
/// Must be a top-level function so the Dart VM can call it in isolation.
@pragma('vm:entry-point')
Future<void> firebaseMessagingBackgroundHandler(RemoteMessage message) async {}

typedef PushTokenCallback = void Function(String token);

class PushNotificationService {
  PushNotificationService({FirebaseMessaging? messaging, this.onToken})
    : _messaging = messaging ?? FirebaseMessaging.instance;

  final FirebaseMessaging _messaging;

  /// Called with the FCM token on startup and whenever it refreshes, so the
  /// app can register/update it on the backend.
  final PushTokenCallback? onToken;
  final FlutterLocalNotificationsPlugin _localNotifications =
      FlutterLocalNotificationsPlugin();

  static const _androidChannel = AndroidNotificationChannel(
    'high_importance_channel',
    'Уведомления',
    description: 'Основной канал для push-уведомлений',
    importance: Importance.high,
  );

  final _messageTapController = StreamController<RemoteMessage>.broadcast();

  /// Emits whenever the user taps a push notification (from background
  /// or from a cold start), so the app can navigate accordingly.
  Stream<RemoteMessage> get onNotificationTap => _messageTapController.stream;

  String? _token;
  String? get token => _token;

  Future<void> initialize() async {
    FirebaseMessaging.onBackgroundMessage(firebaseMessagingBackgroundHandler);

    await _messaging.requestPermission(
      alert: true,
      badge: true,
      sound: true,
    );

    await _messaging.setForegroundNotificationPresentationOptions(
      alert: true,
      badge: true,
      sound: true,
    );

    await _initLocalNotifications();

    _token = await _messaging.getToken();
    if (kDebugMode) {
      debugPrint('FCM token: $_token');
    }
    final initialToken = _token;
    if (initialToken != null) {
      onToken?.call(initialToken);
    }
    _messaging.onTokenRefresh.listen((newToken) {
      _token = newToken;
      onToken?.call(newToken);
    });

    FirebaseMessaging.onMessage.listen(_showLocalNotification);
    FirebaseMessaging.onMessageOpenedApp.listen(_messageTapController.add);

    final initialMessage = await _messaging.getInitialMessage();
    if (initialMessage != null) {
      _messageTapController.add(initialMessage);
    }
  }

  Future<void> _initLocalNotifications() async {
    const androidInit = AndroidInitializationSettings('@mipmap/ic_launcher');
    const iosInit = DarwinInitializationSettings();

    await _localNotifications.initialize(
      settings: const InitializationSettings(
        android: androidInit,
        iOS: iosInit,
      ),
      onDidReceiveNotificationResponse: (response) {
        final message = response.payload;
        if (message != null) {
          // Local taps carry the message id only; onMessageOpenedApp /
          // getInitialMessage cover full RemoteMessage delivery.
        }
      },
    );

    await _localNotifications
        .resolvePlatformSpecificImplementation<
          AndroidFlutterLocalNotificationsPlugin
        >()
        ?.createNotificationChannel(_androidChannel);
  }

  Future<void> _showLocalNotification(RemoteMessage message) async {
    final notification = message.notification;
    if (notification == null) return;

    await _localNotifications.show(
      id: notification.hashCode,
      title: notification.title,
      body: notification.body,
      notificationDetails: NotificationDetails(
        android: AndroidNotificationDetails(
          _androidChannel.id,
          _androidChannel.name,
          channelDescription: _androidChannel.description,
          importance: Importance.high,
          priority: Priority.high,
        ),
        iOS: const DarwinNotificationDetails(),
      ),
      payload: message.messageId,
    );
  }

  void dispose() {
    _messageTapController.close();
  }
}

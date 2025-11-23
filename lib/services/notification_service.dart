import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class NotificationService {
  static final FlutterLocalNotificationsPlugin _notifications =
      FlutterLocalNotificationsPlugin();

  static bool _initialized = false;

  static Future<void> initialize() async {
    if (_initialized) return;

    const androidSettings = AndroidInitializationSettings('@mipmap/ic_launcher');
    const initSettings = InitializationSettings(android: androidSettings);

    await _notifications.initialize(
      initSettings,
      onDidReceiveNotificationResponse: _onNotificationTapped,
    );

    _initialized = true;
  }

  static void _onNotificationTapped(NotificationResponse response) {
    // Handle notification tap - navigate to review screen
    // This will be implemented when we add navigation
  }

  static Future<void> showAnalysisCompleteNotification(
    String foodName,
    int calories,
  ) async {
    await initialize();

    const androidDetails = AndroidNotificationDetails(
      'analysis_complete',
      'Food Analysis',
      channelDescription: 'Notifications when food analysis is complete',
      importance: Importance.high,
      priority: Priority.high,
      showWhen: true,
    );

    const details = NotificationDetails(android: androidDetails);

    await _notifications.show(
      DateTime.now().millisecondsSinceEpoch % 100000,
      'Food Analyzed: $foodName',
      '$calories kcal detected. Tap to review and approve.',
      details,
    );
  }

  static Future<void> showLowConfidenceNotification(String foodName) async {
    await initialize();

    const androidDetails = AndroidNotificationDetails(
      'analysis_warning',
      'Food Analysis Warnings',
      channelDescription: 'Warnings about food analysis',
      importance: Importance.defaultImportance,
      priority: Priority.defaultPriority,
    );

    const details = NotificationDetails(android: androidDetails);

    await _notifications.show(
      DateTime.now().millisecondsSinceEpoch % 100000,
      'Low Confidence Detection',
      'Could not clearly identify: $foodName. Please try again.',
      details,
    );
  }

  static Future<void> showAnalysisFailedNotification() async {
    await initialize();

    const androidDetails = AndroidNotificationDetails(
      'analysis_error',
      'Analysis Errors',
      channelDescription: 'Errors during food analysis',
      importance: Importance.defaultImportance,
      priority: Priority.defaultPriority,
    );

    const details = NotificationDetails(android: androidDetails);

    await _notifications.show(
      DateTime.now().millisecondsSinceEpoch % 100000,
      'Analysis Failed',
      'Failed to analyze food photo. Please try again.',
      details,
    );
  }

  static Future<void> showDeficiencyAlert(
    String nutrient,
    String message,
  ) async {
    await initialize();

    const androidDetails = AndroidNotificationDetails(
      'deficiency_alert',
      'Nutrient Deficiencies',
      channelDescription: 'Alerts about nutrient deficiencies',
      importance: Importance.high,
      priority: Priority.high,
      styleInformation: BigTextStyleInformation(''),
    );

    const details = NotificationDetails(android: androidDetails);

    await _notifications.show(
      DateTime.now().millisecondsSinceEpoch % 100000,
      '$nutrient Deficiency Detected',
      message,
      details,
    );
  }

  static Future<void> requestPermissions() async {
    await initialize();

    final androidPlugin = _notifications.resolvePlatformSpecificImplementation<
        AndroidFlutterLocalNotificationsPlugin>();

    if (androidPlugin != null) {
      await androidPlugin.requestNotificationsPermission();
    }
  }
}

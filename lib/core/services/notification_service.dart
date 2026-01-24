import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class NotificationService {
  static final _client = Supabase.instance.client;

  /// Convert "08:30 AM" → UTC "03:00"
  static String istToUtc(String time12h) {
    final parts = time12h.split(RegExp(r'[: ]'));
    int hour = int.parse(parts[0]);
    final minute = int.parse(parts[1]);
    final isAm = parts[2] == 'AM';

    if (!isAm && hour != 12) hour += 12;
    if (isAm && hour == 12) hour = 0;

    final totalMinutes = hour * 60 + minute - 330;
    final utcHour = ((totalMinutes ~/ 60) % 24 + 24) % 24;
    final utcMinute = (totalMinutes % 60 + 60) % 60;

    return '${utcHour.toString().padLeft(2, '0')}:${utcMinute.toString().padLeft(2, '0')}';
  }

  /// Save notification preference
  static Future<void> saveReminder({
    required String userId,
    required bool enabled,
    required String time12h,
  }) async {
    final utcTime = istToUtc(time12h);

    await _client.from('user_notification_settings').upsert({
      'user_id': userId,
      'enabled': enabled,
      'notify_time': utcTime,
    });
  }

  /// Save FCM token
  static Future<void> saveFcmToken(String userId) async {
    final token = await FirebaseMessaging.instance.getToken();
    if (token == null) return;

    await _client.from('device_tokens').upsert({
      'user_id': userId,
      'fcm_token': token,
    });
  }
}

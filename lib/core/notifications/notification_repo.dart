import 'package:supabase_flutter/supabase_flutter.dart';

class NotificationRepository {
  final SupabaseClient _client = Supabase.instance.client;

  Future<void> saveFcmToken(String userId, String token) async {
    await _client.from('device_tokens').upsert({
      'user_id': userId,
      'fcm_token': token,
      'updated_at': DateTime.now().toIso8601String(),
    });
  }

  Future<void> saveNotifyTime({
    required String userId,
    required String notifyTimeUtc, // HH:mm (UTC)
    bool enabled = true,
  }) async {
    await _client.from('user_notification_settings').upsert({
      'user_id': userId,
      'enabled': enabled,
      'notify_time': notifyTimeUtc,
    });
  }
}

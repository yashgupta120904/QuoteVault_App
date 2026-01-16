import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../../../../core/config/supabase_config.dart';
import '../../../../core/utils/app_prefs.dart';
import '../../../../routes/app_routes.dart';

class AuthRemoteDataSource {
  final SupabaseClient _client = SupabaseConfig.client;

  // Login
  Future<AuthResponse> login({
    required String email,
    required String password,
  }) async {
    return await _client.auth.signInWithPassword(
      email: email,
      password: password,
    );
  }

  // Signup
  Future<AuthResponse> signup({
    required String email,
    required String password,
    required String name,
  }) async {
    return await _client.auth.signUp(
      email: email,
      password: password,
      data: {'name': name},
      emailRedirectTo: 'quotevault://verify-email'

    );
  }
   Future<bool> checkEmailExists(String email) async {
  debugPrint('📡 Repository called: checkEmailExists');

  final response = await _client.functions.invoke(
    'check-email-exists',
    body: {'email': email},
  );

  debugPrint('📥 Edge response: ${response.data}');
  debugPrint('📥 Status: ${response.status}');

  if (response.status != 200) {
    throw Exception(response.data);
  }

  return response.data['exists'] as bool;
}

  // Forgot password
  Future<void> sendResetLink(String email) async {
    await _client.auth.resetPasswordForEmail(email, redirectTo: 'quotevault://reset-password',);
  }

  // Update password
  Future<void> updatePassword(String password) async {
    await _client.auth.updateUser(
      UserAttributes(password: password),
    );
  }

  // Logout
  Future<void> logout(BuildContext context) async {
  await Supabase.instance.client.auth.signOut();
  await AppPrefs.clear();

  Navigator.pushNamedAndRemoveUntil(
    context,
    AppRoutes.welcome,
    (_) => false,
  );
}

}

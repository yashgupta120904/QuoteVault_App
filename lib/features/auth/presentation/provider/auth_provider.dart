
import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../../../../core/errors/failure.dart';
import '../../../../core/utils/app_prefs.dart';
import '../../domain/repositories/auth_repository_impl.dart';

class AuthProvider extends ChangeNotifier {
  final AuthRepository repository;

  AuthProvider(this.repository);
  User? get user => Supabase.instance.client.auth.currentUser;

  bool isLoading = false;
  bool isSuccess = false; // ✅ success flag
  bool emailExists = false; // ✅ NEW
  String? errorMessage;

  // ---------------- LOGIN ----------------

  
  Future<void> login(String email, String password) async {
  _startLoading();

  try {
    final failure = await repository.login(email, password);

    if (failure != null) {
      errorMessage = failure.message;
      isSuccess = false;
    } else {
      isSuccess = true;

      /// ✅ SAVE LOGIN STATE
      await AppPrefs.setLoggedIn(true);
    }
  } finally {
    isLoading = false;
    notifyListeners();
  }
}

  
  
   





  // ---------------- EMAILEXISTS ----------------
  // Future<bool> checkEmailExists(String email) async {
  //   try {
  //     return await repository.checkEmailExists(email);
  //   } catch (e) {
  //     return false; // fallback safety
  //   }
  // }
  Future<bool> checkEmailExists(String email) async {
  debugPrint('🚀 checkEmailExists called with: $email');

  try {
    return await repository.checkEmailExists(email);
  } catch (e, stack) {
    debugPrint('❌ checkEmailExists failed: $e');
    debugPrintStack(stackTrace: stack);
    rethrow;
  }
}


  // ---------------- SIGNUP ----------------
  Future<void> signup(String name, String email, String password) async {
    _startLoading();
    final failure = await repository.signup(name, email, password);
    _handleResult(failure);
  }




  // ---------------- FORGOT PASSWORD ----------------
  Future<void> forgotPassword(String email) async {
    _startLoading();
    final failure = await repository.forgotPassword(email);
    _handleResult(failure);
  }

  // ---------------- RESET PASSWORD ----------------
Future<void> resetPassword(String password) async {
  _startLoading();

  try {
    final client = Supabase.instance.client;
    final session = client.auth.currentSession;

    if (session == null) {
      throw const AuthException('No recovery session found');
    }

    await client.auth.updateUser(
      UserAttributes(password: password),
    );

    isSuccess = true;
  } on AuthException catch (e) {
    // ✅ REAL SUPABASE ERROR
    debugPrint('SUPABASE ERROR: ${e.message}');
    errorMessage = e.message;
  } catch (e) {
    // ❌ NON-SUPABASE ERROR
    debugPrint('UNKNOWN ERROR: $e');
    errorMessage = e.toString();
  } finally {
    isLoading = false;
    notifyListeners();
  }




  notifyListeners();
}

  // ================== HELPERS ==================

  void _startLoading() {
    isLoading = true;
    isSuccess = false;      // ✅ reset success
    errorMessage = null;
    notifyListeners();
  }

  void _handleResult(Failure? failure) {
    isLoading = false;

    if (failure != null) {
      // ❌ FAILED
      errorMessage = failure.message;
      isSuccess = false;
    } else {
      // ✅ SUCCESS
      errorMessage = null;
      isSuccess = true;
    }

    notifyListeners();
  }

  void clearError() {
  errorMessage = null;
}

  
}

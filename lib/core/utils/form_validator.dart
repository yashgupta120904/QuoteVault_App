import 'package:flutter/material.dart';

import '../constants/app_colors.dart';

class FormValidators {
  FormValidators._(); // private constructor

  /// Email Validator
  static String? email(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Email is required';
    }

    final emailRegex =
        RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w]{2,4}$');

    if (!emailRegex.hasMatch(value.trim())) {
      return 'Enter a valid email address';
    }

    return null;
  }
  /// Email OR Mobile Number Validator
static String? emailOrMobile(String? value) {
  if (value == null || value.trim().isEmpty) {
    return 'Email or mobile number is required';
  }

  final input = value.trim();

  final emailRegex =
      RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w]{2,4}$');

  final mobileRegex = RegExp(r'^[0-9]{10}$');

  if (!emailRegex.hasMatch(input) && !mobileRegex.hasMatch(input)) {
    return 'Enter a valid email or 10-digit mobile number';
  }

  return null;
}


  /// Password Validator (Login)
static String? loginPassword(String? value) {
  if (value == null || value.isEmpty) {
    return 'Password is required';
  }
  return null;
}


  /// Password Validator
  static String? password(String? value) {
    if (value == null || value.isEmpty) {
      return 'Password is required';
    }

    if (value.length < 6) {
      return 'Password must be at least 6 characters';
    }

    return null;
  }

  /// Name Validator
  static String? name(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'This field is required';
    }
    return null;
  }

  /// Mobile Number Validator (10 digits)
  static String? mobile(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Mobile number is required';
    }

    final mobileRegex = RegExp(r'^[0-9]{10}$');

    if (!mobileRegex.hasMatch(value.trim())) {
      return 'Enter a valid 10-digit mobile number';
    }

    return null;
  }

  /// OTP Validator (4 digits)
  static String? otp(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'OTP is required';
    }

    final otpRegex = RegExp(r'^[0-9]{4}$');

    if (!otpRegex.hasMatch(value.trim())) {
      return 'Enter a valid 4-digit OTP';
    }

    return null;
  }
}






class PasswordStrength {
  final bool hasMinLength;
  final bool hasNumber;
  final bool hasSymbol;
  final String strength;

  PasswordStrength({
    required this.hasMinLength,
    required this.hasNumber,
    required this.hasSymbol,
    required this.strength,
  });

  /// Password is valid only if ALL minimum requirements are met
  bool get isValid => hasMinLength && hasNumber && hasSymbol;

  /// Color for UI (strength indicator)
  Color getStrengthColor() {
    switch (strength) {
      case 'Strong':
        return AppColors.successColor;
      case 'Medium':
        return AppColors.warningColor;
      default:
        return AppColors.errorColor;
    }
  }

  /// Progress value for strength bar
  double getStrengthProgress() {
    switch (strength) {
      case 'Strong':
        return 1.0;
      case 'Medium':
        return 0.66;
      default:
        return 0.33;
    }
  }
}

class PasswordValidator {
  PasswordValidator._();

  /// Default empty state
  static PasswordStrength getDefaultPasswordStrength() {
    return PasswordStrength(
      hasMinLength: false,
      hasNumber: false,
      hasSymbol: false,
      strength: 'Weak',
    );
  }

  /// Validate password & calculate strength
  static PasswordStrength validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return getDefaultPasswordStrength();
    }

    final hasMinLength = value.length >= 8;
    final hasNumber = RegExp(r'[0-9]').hasMatch(value);
    final hasSymbol =
        RegExp(r'[!@#$%^&*()_+\-=\[\]{};:,.<>?]').hasMatch(value);

    int score = 0;
    if (hasMinLength) score++;
    if (hasNumber) score++;
    if (hasSymbol) score++;

    /// Strength logic (correct thinking)
    /// Weak   → invalid password
    /// Medium → acceptable but not ideal
    /// Strong → valid & secure
    String strength;
    if (score < 2) {
      strength = 'Weak';
    } else if (score == 2) {
      strength = 'Medium';
    } else {
      strength = 'Strong';
    }

    return PasswordStrength(
      hasMinLength: hasMinLength,
      hasNumber: hasNumber,
      hasSymbol: hasSymbol,
      strength: strength,
    );
  }

  /// Form-level validation (submission blocking)
  static String?validatePasswordForm(String? value) {
    if (value == null || value.isEmpty) {
      return 'Password is required';
    }

    final result = validatePassword(value);

    if (!result.isValid) {
      return 'Password must be at least 8 characters and include a number and a symbol';
    }

    return null;
  }
}

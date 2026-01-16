
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../core/constants/app_colors.dart';
import '../../../../core/widgets/custom_back_button.dart';
import '../../../../core/utils/custom_snackbar.dart';
import '../../../../core/utils/form_validator.dart';
import '../../../../core/utils/size_config.dart';
import '../../../../routes/app_routes.dart';
import '../provider/auth_provider.dart';
import '../widgets/auth_password_requirement_item.dart';
import '../widgets/auth_button.dart';
import '../widgets/custom_textfield.dart';

class ResetPasswordScreen extends StatefulWidget {
  const ResetPasswordScreen({super.key});

  @override
  State<ResetPasswordScreen> createState() => _ResetPasswordScreenState();
}

class _ResetPasswordScreenState extends State<ResetPasswordScreen> {
  final _formKey = GlobalKey<FormState>();
  late final TextEditingController _passwordController;
  late final TextEditingController _confirmPasswordController;
  late AuthProvider _authProvider;

  bool _obscurePassword = true;
  bool _obscureConfirmPassword = true;

  late PasswordStrength _passwordStrength;
  bool _showPasswordStrengthIndicator = false;

  @override
  void initState() {
    super.initState();

    _passwordController = TextEditingController();
    _confirmPasswordController = TextEditingController();

    _passwordStrength = PasswordValidator.getDefaultPasswordStrength();
    _passwordController.addListener(_updatePasswordStrength);

    /// 🔥 Listen to provider OUTSIDE build
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _authProvider = context.read<AuthProvider>();
      context.read<AuthProvider>().addListener(_authListener);
    });
  }

  void _updatePasswordStrength() {
    setState(() {
      _passwordStrength =
          PasswordValidator.validatePassword(_passwordController.text);
      _showPasswordStrengthIndicator = _passwordController.text.isNotEmpty;
    });
  }

  void _authListener() {
    final auth = context.read<AuthProvider>();
    if (!mounted) return;

    /// 🔴 ERROR
    if (auth.errorMessage != null) {
      showCustomSnackbar(
    
        type: SnackbarType.error,
        title: 'Reset Failed',
        message: auth.errorMessage!,
      );
      auth.errorMessage = null;
    }

    /// 🟢 SUCCESS
    if (auth.isSuccess) {
      showCustomSnackbar(
  
        type: SnackbarType.success,
        title: 'Password Updated',
        message: 'You can login now',
      );

      auth.isSuccess = false;

      Navigator.pushReplacementNamed(
        context,
        AppRoutes.login,
      );
    }
  }

  void _handleResetPassword() {
    if (_formKey.currentState?.validate() ?? false) {
      context
          .read<AuthProvider>()
          .resetPassword(_passwordController.text);
    }
  }

  @override
  void dispose() {
    _authProvider.removeListener(_authListener); 
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: SizeConfig.blockWidth * 6,
          ),
          child: Form(
            key: _formKey,
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CustomCircularBackButton(isDark: isDark),
                  SizedBox(height: SizeConfig.blockHeight * 2),

                  /// Logo
                  Center(
                    child: Container(
                      width: SizeConfig.blockWidth * 22,
                      height: SizeConfig.blockWidth * 22,
                      decoration: BoxDecoration(
                        color: AppColors.primaryColor,
                        borderRadius: BorderRadius.circular(28),
                      ),
                      alignment: Alignment.center,
                      child: const Icon(
                        Icons.format_quote_rounded,
                        color: Colors.white,
                        size: 48,
                      ),
                    ),
                  ),
                  SizedBox(height: SizeConfig.blockHeight * 2.5),

                  /// Title
                  Center(
                    child: Column(
                      children: [
                        Text(
                          'Secure your vault with a \nnew password.',
                          textAlign: TextAlign.center,
                          style: Theme.of(context)
                              .textTheme
                              .headlineSmall
                              ?.copyWith(
                                fontSize: SizeConfig.blockWidth * 7.2,
                              ),
                        ),
                        Text(
                          'Your new password must be different \nfrom previous used passwords.',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: isDark
                                ? AppColors.darkTextSecondary
                                : AppColors.lightTextSecondary,
                            fontSize: SizeConfig.blockWidth * 4.5,
                            height: 1.6,
                          ),
                        ),
                      ],
                    ),
                  ),

                  SizedBox(height: SizeConfig.blockHeight * 2.5),

                  /// New Password
                  Text(
                    'New Password',
                    style: TextStyle(
                      color: isDark
                          ? AppColors.darkTextPrimary
                          : AppColors.lightTextPrimary,
                      fontSize: SizeConfig.blockWidth * 4.2,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  SizedBox(height: SizeConfig.blockHeight * 1.5),
                  CustomTextField(
                    controller: _passwordController,
                    hintText: 'Enter new password',
                    icon: Icons.lock_outlined,
                    isPassword: true,
                    obscureText: _obscurePassword,
                    onVisibilityToggle: () {
                      setState(() {
                        _obscurePassword = !_obscurePassword;
                      });
                    },
                    validator: PasswordValidator.validatePasswordForm,
                  ),

                  if (_showPasswordStrengthIndicator) ...[
                    SizedBox(height: SizeConfig.blockHeight * 2),
                    AuthPasswordRequirementItem(
                      icon: Icons.check_circle,
                      text: 'At least 8 characters',
                      isChecked: _passwordStrength.hasMinLength,
                      isDark: isDark,
                    ),
                    AuthPasswordRequirementItem(
                      icon: Icons.check_circle,
                      text: 'Contains a number',
                      isChecked: _passwordStrength.hasNumber,
                      isDark: isDark,
                    ),
                    AuthPasswordRequirementItem(
                      icon: Icons.check_circle,
                      text: 'Contains a symbol',
                      isChecked: _passwordStrength.hasSymbol,
                      isDark: isDark,
                    ),
                  ],

                  SizedBox(height: SizeConfig.blockHeight * 2.5),

                  /// Confirm Password
                  Text(
                    'Confirm New Password',
                    style: TextStyle(
                      color: isDark
                          ? AppColors.darkTextPrimary
                          : AppColors.lightTextPrimary,
                      fontSize: SizeConfig.blockWidth * 4.2,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  SizedBox(height: SizeConfig.blockHeight * 1.5),
                  CustomTextField(
                    controller: _confirmPasswordController,
                    hintText: 'Re-enter password',
                    icon: Icons.lock_outlined,
                    isPassword: true,
                    obscureText: _obscureConfirmPassword,
                    onVisibilityToggle: () {
                      setState(() {
                        _obscureConfirmPassword =
                            !_obscureConfirmPassword;
                      });
                    },
                    validator: FormValidators.password,
                  ),

                  SizedBox(height: SizeConfig.blockHeight * 3),

                  /// Button
                  CustomButton(
                    text: 'Reset Password',
                    onPressed: _handleResetPassword,
                  ),

                  SizedBox(height: SizeConfig.blockHeight * 2.5),

                  /// Back to Login
                  Align(
                    alignment: Alignment.center,
                    child: RichText(
                      text: TextSpan(
                        children: [
                          TextSpan(
                            text: 'Take me back? ',
                            style: TextStyle(
                              color: isDark
                                  ? AppColors.darkTextTertiary
                                  : AppColors.lightTextTertiary,
                            ),
                          ),
                          TextSpan(
                            text: 'Login',
                            style: TextStyle(
                              color: AppColors.primaryColor,
                              fontWeight: FontWeight.w700,
                            ),
                            recognizer: TapGestureRecognizer()
                              ..onTap = () {
                                Navigator.pushNamed(
                                    context, AppRoutes.login);
                              },
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

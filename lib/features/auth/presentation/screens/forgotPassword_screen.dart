
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
import '../widgets/auth_button.dart';
import '../widgets/custom_textfield.dart';

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({super.key});

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  final _formKey = GlobalKey<FormState>();
  late final TextEditingController _emailController;

  bool _actionHandled = false;
  late AuthProvider _authProvider;

  @override
  void initState() {
    super.initState();
    _emailController = TextEditingController();

    /// 🔥 Attach provider listener SAFELY
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _authProvider = context.read<AuthProvider>();
      _authProvider.addListener(_authListener);
    });
  }

  /// 🔥 HANDLE PROVIDER RESULT (SIDE EFFECTS ONLY)
  void _authListener() {
  if (!mounted || _actionHandled || _authProvider.isLoading) return;

  /// ❌ REAL ERROR (network / rate limit / server)
  if (_authProvider.errorMessage != null) {
    showCustomSnackbar(

      type: SnackbarType.error,
      title: 'Reset Failed',
      message: _authProvider.errorMessage!,
    );

    _actionHandled = true;
    return;
  }

  /// ✅ SUCCESS (EMAIL SENT)
  showCustomSnackbar(

    type: SnackbarType.success,
    title: 'Email Sent',
    message:
        'Check your email to reset your password.',
  );

  _actionHandled = true;
}


  void _handleSendResetLink() async {
  if (!(_formKey.currentState?.validate() ?? false)) return;

  _actionHandled = false;

  final auth = context.read<AuthProvider>();
  final email = _emailController.text.trim();

  /// 🔍 STEP 1: CHECK EMAIL EXISTS (EDGE FUNCTION)
  final exists = await auth.checkEmailExists(email);

  if (!exists) {
    showCustomSnackbar(

      type: SnackbarType.error,
      title: 'Email Not Found',
      message: 'This email is not registered.',
    );
    _actionHandled = true;
    return;
  }

  /// 📩 STEP 2: SEND RESET EMAIL
  await auth.forgotPassword(email);
}

  @override
  void dispose() {
    _authProvider.removeListener(_authListener);
    _emailController.dispose();
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
                          'Forgot Password?',
                          style: Theme.of(context).textTheme.headlineSmall,
                        ),
                        SizedBox(height: SizeConfig.blockHeight * 1.5),
                        Text(
                          'Don\'t worry, it happens. Enter the email\nassociated with your QuoteVault account.',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: isDark
                                ? AppColors.darkTextSecondary
                                : AppColors.lightTextSecondary,
                            fontSize: SizeConfig.blockWidth * 3.8,
                            fontWeight: FontWeight.w400,
                            height: 1.6,
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: SizeConfig.blockHeight * 2.5),

                  /// Email Field Label
                  Text(
                    'Email Address',
                    style: TextStyle(
                      color: isDark
                          ? AppColors.darkTextPrimary
                          : AppColors.lightTextPrimary,
                      fontSize: SizeConfig.blockWidth * 4,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  SizedBox(height: SizeConfig.blockHeight * 1.5),

                  /// Email TextField
                  CustomTextField(
                    controller: _emailController,
                    hintText: 'Enter your email address',
                    icon: Icons.email_outlined,
                    keyboardType: TextInputType.emailAddress,
                    validator: FormValidators.email,
                  ),
                  SizedBox(height: SizeConfig.blockHeight * 2.5),

                  /// Send Reset Link Button
                  CustomButton(
                    text: 'Send Reset Link',
                    onPressed: _handleSendResetLink,
                  ),
                  SizedBox(height: SizeConfig.blockHeight * 2.5),

                  /// Login Link
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

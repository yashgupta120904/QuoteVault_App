import "package:flutter/gestures.dart";
import "package:flutter/material.dart";
import "package:provider/provider.dart";
import "package:quotevault/core/widgets/custom_back_button.dart";

import "../../../../core/constants/app_colors.dart";
import "../../../../core/utils/custom_snackbar.dart";
import "../../../../core/utils/form_validator.dart";
import "../../../../core/utils/size_config.dart";

import "../../../../routes/app_routes.dart";
import "../provider/auth_provider.dart";
import "../widgets/auth_button.dart";
import "../widgets/custom_textfield.dart";

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  late final TextEditingController _emailController;
  late final TextEditingController _passwordController;
  bool _obscurePassword = true;
  bool _actionHandled = false;


  @override
  void initState() {
    super.initState();
    _emailController = TextEditingController();
    _passwordController = TextEditingController();
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _handleSignIn() {
    if (_formKey.currentState?.validate() ?? false) {
       _actionHandled = false; // reset before action
      context.read<AuthProvider>().login(
            _emailController.text.trim(),
         _passwordController.text.trim()
         
          );
           
    }
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Consumer<AuthProvider>(
      builder: (context, auth, _) {
           if (!_actionHandled && !auth.isLoading) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        /// 🔴 ERROR SNACKBAR
        /// 
        if (auth.errorMessage != null) {
          showCustomSnackbar(
       
            type: SnackbarType.error,
            title: 'Login Failed',
            message: auth.errorMessage!,
          );
            context.read<AuthProvider>().clearError();
        }

        /// 🟢 SUCCESS SNACKBAR + NAVIGATION
        if (auth.isSuccess) {
          showCustomSnackbar(
   
            type: SnackbarType.success,
            title: 'Welcome',
            message: 'Login successful',
          );
            Navigator.pushReplacementNamed(context, AppRoutes.bottombar);
        }_actionHandled = true; // 🔒 LOCK IT
      });
    }


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
                  CustomCircularBackButton(
                    isDark: isDark,
                    onPressed: () {
                      Navigator.pushNamed(context, AppRoutes.welcome);
                    },
                  ),
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

                  /// Welcome Text
                  Center(
                    child: Column(
                      children: [
                        Text(
                          'Welcome back.',
                          style: Theme.of(context).textTheme.headlineSmall,
                        ),
                        Text(
                          'Let\'s get inspired.',
                          style: TextStyle(
                            color: isDark
                                ? AppColors.darkTextSecondary
                                : AppColors.lightTextSecondary,
                            fontSize: SizeConfig.blockWidth * 4.5,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: SizeConfig.blockHeight * 2.5),

                  /// Email Field Label
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      'Email',
                      style: TextStyle(
                        color: isDark
                            ? AppColors.darkTextPrimary
                            : AppColors.lightTextPrimary,
                        fontSize: SizeConfig.blockWidth * 4,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  SizedBox(height: SizeConfig.blockHeight * 1.5),

                  /// Email TextField
                  CustomTextField(
                    controller: _emailController,
                    hintText: 'Enter your email',
                    icon: Icons.email_outlined,
                    keyboardType: TextInputType.emailAddress,
                    validator: FormValidators.email,
                  ),
                  SizedBox(height: SizeConfig.blockHeight * 2.5),

                  /// Password Field Label
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Password',
                        style: TextStyle(
                          color: isDark
                              ? AppColors.darkTextPrimary
                              : AppColors.lightTextPrimary,
                          fontSize: SizeConfig.blockWidth * 4,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      TextButton(
                        onPressed: () {
                          Navigator.pushNamed(
                              context, AppRoutes.forgotpassword);
                        },
                        style: TextButton.styleFrom(
                          padding: EdgeInsets.zero,
                          minimumSize: const Size(0, 0),
                          tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                        ),
                        child: Text(
                          'Forgot Password?',
                          style: TextStyle(
                            color: AppColors.primaryColor,
                            fontSize: SizeConfig.blockWidth * 3.5,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: SizeConfig.blockHeight * 1.5),

                  /// Password TextField
                  CustomTextField(
                    controller: _passwordController,
                    hintText: 'Enter your password',
                    icon: Icons.lock_outlined,
                    isPassword: true,
                    obscureText: _obscurePassword,
                    onVisibilityToggle: () {
                      setState(() {
                        _obscurePassword = !_obscurePassword;
                      });
                    },
                    validator: FormValidators.loginPassword,
                  ),
                  SizedBox(height: SizeConfig.blockHeight * 4),

                  /// Sign In Button
                  CustomButton(
                    text: 'Sign In',
                    onPressed: _handleSignIn,
                  ),
                  SizedBox(height: SizeConfig.blockHeight * 2.5),

                  /// Divider
                  Row(
                    children: [
                      Expanded(
                        child: Divider(
                          color: isDark
                              ? AppColors.darkBorder
                              : AppColors.lightBorder,
                        ),
                      ),
                      SizedBox(width: SizeConfig.blockWidth * 4),
                      Text(
                        'OR CONTINUE WITH',
                        style: TextStyle(
                          color: isDark
                              ? AppColors.darkTextTertiary
                              : AppColors.lightTextTertiary,
                          fontSize: SizeConfig.blockWidth * 3,
                          fontWeight: FontWeight.w600,
                          letterSpacing: 0.5,
                        ),
                      ),
                      SizedBox(width: SizeConfig.blockWidth * 4),
                      Expanded(
                        child: Divider(
                          color: isDark
                              ? AppColors.darkBorder
                              : AppColors.lightBorder,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: SizeConfig.blockHeight * 2.5),

                  /// Social Buttons
                  Row(
                    children: [
                      Expanded(
                        child: OutlinedButton(
                          onPressed: () {},
                          style: OutlinedButton.styleFrom(
                            padding: EdgeInsets.symmetric(
                              vertical: SizeConfig.blockWidth * 3,
                            ),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Image.asset(
                                'assets/images/google_logo.png',
                                width: SizeConfig.blockWidth * 5,
                                height: SizeConfig.blockWidth * 5,
                                fit: BoxFit.fill,
                              ),
                              SizedBox(width: SizeConfig.blockWidth * 2),
                              Text(
                                'Google',
                                style: TextStyle(
                                  fontSize: SizeConfig.blockWidth * 4,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: SizeConfig.blockHeight * 2.5),

                  /// Sign Up Link
                  Align(
                    alignment: Alignment.center,
                    child: RichText(
                      text: TextSpan(
                        children: [
                          TextSpan(
                            text: 'Don\'t have an account? ',
                            style: TextStyle(
                              color: isDark
                                  ? AppColors.darkTextTertiary
                                  : AppColors.lightTextTertiary,
                              fontSize: SizeConfig.blockWidth * 3.5,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          TextSpan(
                            text: 'Sign Up',
                            style: TextStyle(
                              color: AppColors.primaryColor,
                              fontSize: SizeConfig.blockWidth * 3.5,
                              fontWeight: FontWeight.w700,
                            ),
                            recognizer: TapGestureRecognizer()
                              ..onTap = () {
                                Navigator.pushNamed(context, AppRoutes.signup);
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
        )));
      },
    );
  }
}

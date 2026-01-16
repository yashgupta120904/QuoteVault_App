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



class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final _formKey = GlobalKey<FormState>();
  late final TextEditingController _nameController;
  late final TextEditingController _emailController;
  late final TextEditingController _passwordController;
  bool _obscurePassword = true;
  late PasswordStrength _passwordStrength;
  bool _showPasswordStrengthIndicator = false;
  bool _actionHandled = false;


  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController();
    _emailController = TextEditingController();
    _passwordController = TextEditingController();
    _passwordStrength = PasswordValidator.getDefaultPasswordStrength();
    _passwordController.addListener(_updatePasswordStrength);
  }

  void _updatePasswordStrength() {
    setState(() {
      _passwordStrength = PasswordValidator.validatePassword(_passwordController.text);
      _showPasswordStrengthIndicator = _passwordController.text.isNotEmpty;
    });
  }

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

 Future<void> _handleSignUp() async {
  if (!(_formKey.currentState?.validate() ?? false)) return;

  final auth = context.read<AuthProvider>();

  _actionHandled = false;

  // ✅ CHECK EMAIL EXISTS
  final exists = await context
    .read<AuthProvider>()
    .checkEmailExists(_emailController.text.trim());

  if (exists) {
    showCustomSnackbar(
   
      type: SnackbarType.error,
      title: 'Email Already Registered',
      message: 'Please login using this email.',
    );
    return; // ⛔ STOP HERE
  }

  // ✅ ONLY IF NOT EXISTS → SIGNUP
  auth.signup(
    _nameController.text.trim(),
    _emailController.text.trim(),
    _passwordController.text.trim(),
  );
}


  @override
  Widget build(BuildContext context) {

    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Consumer<AuthProvider>(
      builder: (context, auth, _) {
          if (!_actionHandled && !auth.isLoading) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        /// 🔴 ERROR  EXISTS
       

        // ❌ OTHER ERROR
        if (auth.errorMessage != null) {
          showCustomSnackbar(
          
            type: SnackbarType.error,
            title: 'Signup Failed',
            message: auth.errorMessage!,
          );
        }

        /// 🟢 SUCCESS SNACKBAR + NAVIGATION
        else if (auth.isSuccess) {
  showCustomSnackbar(

    type: SnackbarType.success,
    title: 'Verify Your Email',
    message: 'A verification link has been sent to your email.',
  );

}
        
        _actionHandled = true; // 🔒 LOCK IT
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
                  CustomCircularBackButton(isDark: isDark),
               
                    
             

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
                          'Join QuoteVault',
                          style: Theme.of(context).textTheme.headlineSmall,
                        ),
         
                        Text(
                          'Start your journey of inspiration.',
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

                  /// Full Name Field
                  Text(
                    'Name',
                    style: TextStyle(
                      color: isDark
                          ? AppColors.darkTextPrimary
                          : AppColors.lightTextPrimary,
                      fontSize: SizeConfig.blockWidth * 4,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  SizedBox(height: SizeConfig.blockHeight * 1.5),
                  CustomTextField(
                    controller: _nameController,
                    hintText: 'Enter your full name',
                    icon: Icons.person_outlined,
                    validator: FormValidators.name,
                  ),
                  SizedBox(height: SizeConfig.blockHeight * 2.5),

                  /// Email Field
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
                  CustomTextField(
                    controller: _emailController,
                    hintText: 'Enter your email address',
                    icon: Icons.email_outlined,
                    keyboardType: TextInputType.emailAddress,
                    validator: FormValidators.email,
                  ),
                  SizedBox(height: SizeConfig.blockHeight * 2.5),

                  /// Password Field
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
                  SizedBox(height: SizeConfig.blockHeight * 1.5),
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
                    validator: PasswordValidator.validatePasswordForm,
                  ),
                  SizedBox(height: SizeConfig.blockHeight * 3),

                  /// Password Strength Indicator
                  if (_showPasswordStrengthIndicator)
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        /// Strength Bar
                        Row(
                          children: [
                            Expanded(
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(4),
                                child: LinearProgressIndicator(
                                  value: _passwordStrength.getStrengthProgress(),
                                  minHeight: 6,
                                  backgroundColor: isDark
                                      ? AppColors.darkBorder
                                      : AppColors.lightBorder,
                                  valueColor: AlwaysStoppedAnimation<Color>(
                                    _passwordStrength.getStrengthColor(),
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(width: SizeConfig.blockWidth * 3),
                            Text(
                              'Password Strength',
                              style: TextStyle(
                                color: isDark
                                    ? AppColors.darkTextSecondary
                                    : AppColors.lightTextSecondary,
                                fontSize: SizeConfig.blockWidth * 3,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            SizedBox(width: SizeConfig.blockWidth * 2),
                            Text(
                              _passwordStrength.strength,
                              style: TextStyle(
                                color: _passwordStrength.getStrengthColor(),
                                fontSize: SizeConfig.blockWidth * 3.5,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: SizeConfig.blockHeight * 2),

                        /// Requirements Checklist
                        _PasswordRequirementItem(
                          icon: Icons.check_circle,
                          text: 'At least 8 characters',
                          isChecked: _passwordStrength.hasMinLength,
                          isDark: isDark,
                        ),
                        SizedBox(height: SizeConfig.blockHeight * 1),
                        _PasswordRequirementItem(
                          icon: Icons.check_circle,
                          text: 'Contains a number',
                          isChecked: _passwordStrength.hasNumber,
                          isDark: isDark,
                        ),
                        SizedBox(height: SizeConfig.blockHeight * 1),
                        _PasswordRequirementItem(
                          icon: Icons.check_circle,
                          text: 'Contains a symbol',
                          isChecked: _passwordStrength.hasSymbol,
                          isDark: isDark,
                        ),
                        SizedBox(height: SizeConfig.blockHeight * 3),
                      ],
                    ),

                  /// Create Account Button
                  CustomButton(
                    text: 'Create Account',
                    onPressed: _handleSignUp,
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
                              width: SizeConfig.blockWidth * 6,
                              height: SizeConfig.blockWidth * 6,
                              fit: BoxFit.cover,
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
                  SizedBox(height: SizeConfig.blockHeight * 2),

                  /// Sign In Link
                  Center(
                    child: RichText(
                      text: TextSpan(
                        children: [
                          TextSpan(
                            text: 'Already a member? ',
                            style: TextStyle(
                              color: isDark
                                  ? AppColors.darkTextTertiary
                                  : AppColors.lightTextTertiary,
                              fontSize: SizeConfig.blockWidth * 3.5,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                           TextSpan(
                          text: 'Login',
                          style: TextStyle(
                            color: AppColors.primaryColor,
                            fontSize: SizeConfig.blockWidth * 3.5,
                            fontWeight: FontWeight.w700,
                          ),
                          recognizer: TapGestureRecognizer()
                            ..onTap = () {
                              Navigator.pushNamed(context, AppRoutes.login);
                            },
                        ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: SizeConfig.blockHeight * 2),
                ],
              ),
            ),
          ),
        )));
      },
    );
  }
}

class _PasswordRequirementItem extends StatelessWidget {
  final IconData icon;
  final String text;
  final bool isChecked;
  final bool isDark;

  const _PasswordRequirementItem({
    required this.icon,
    required this.text,
    required this.isChecked,
    required this.isDark,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(
          icon,
          size: SizeConfig.blockWidth * 4.5,
          color: isChecked ? AppColors.successColor : AppColors.darkTextTertiary,
        ),
        SizedBox(width: SizeConfig.blockWidth * 3),
        Text(
          text,
          style: TextStyle(
            color: isChecked
                ? (isDark
                    ? AppColors.darkTextSecondary
                    : AppColors.lightTextSecondary)
                : (isDark
                    ? AppColors.darkTextTertiary
                    : AppColors.lightTextTertiary),
            fontSize: SizeConfig.blockWidth * 3.5,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }
}
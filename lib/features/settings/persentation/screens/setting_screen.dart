import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/utils/custom_snackbar.dart';
import '../../../../core/utils/size_config.dart';
import '../../../../core/services/notification_service.dart';
import '../../../auth/data/datasources/auth_repository.dart';
import '../../../profile/presentation/provider/profile_provider.dart';
import '../../../profile/presentation/screens/edit_profile_screen.dart';
import '../widgets/custom_time_diallog.dart';
import '../widgets/notification_tile.dart';
import '../widgets/profile_header.dart';
import '../widgets/settings_tile.dart';
import 'provider/theme_provider.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  late final String userId;


  bool notificationsEnabled = true;
  bool biometricEnabled = false;
  double fontSize = 16;
  String reminderTime = '08:30 AM';
  
  bool isLoading = false;

  final supabase = Supabase.instance.client;

  /* ================= SIGN OUT ================= */

  Future<void> _signOut() async {
     final bool isDark =
      context.read<ThemeProvider>().isDark;
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (_) => AlertDialog(
        backgroundColor:
            isDark ? AppColors.darkSurfaceLight : AppColors.lightSurfaceLight,
        title: Text(
          'Sign Out?',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: isDark
                ? AppColors.darkTextPrimary
                : AppColors.lightTextPrimary,
          ),
        ),
        content: Text(
          'Are you sure you want to sign out?',
          style: TextStyle(
            color: isDark
                ? AppColors.darkTextSecondary
                : AppColors.lightTextSecondary,
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () => Navigator.pop(context, true),
            child: Text(
              'Sign Out',
              style: TextStyle(color: AppColors.errorColor),
            ),
          ),
        ],
      ),
    );

    if (confirmed == true) {
      try {
        setState(() => isLoading = true);
        
        final authDataSource = AuthRemoteDataSource();
        await authDataSource.logout(context);
        
        debugPrint("✅ User signed out successfully");
      } catch (e) {
        setState(() => isLoading = false);
        debugPrint("❌ Error signing out: $e");

        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text("Error signing out: $e"),
              backgroundColor: Colors.red,
            ),
          );
        }
      }
    }
  }

  @override
  void initState() {
    super.initState();


     
    final user = supabase.auth.currentUser;
    
    if (user != null) {
      userId = user.id;
    }

    // Load profile using WidgetsBinding to avoid build phase issues
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted) {
        context.read<ProfileProvider>().loadProfile();
        _initializeSettings();
      }
    });
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    SizeConfig.init(context);
  }

  /* ================= INITIALIZE SETTINGS ================= */

  Future<void> _initializeSettings() async {
    try {
      await _loadNotificationSettings();
      await NotificationService.saveFcmToken(userId);
      debugPrint("✅ Settings initialized successfully");
    } catch (e) {
      showCustomSnackbar(
    type: SnackbarType.error,
    title: 'Server Error',
    message: 'Unable to load. Please try again later',
  );
      if (mounted) {
     showCustomSnackbar(
    type: SnackbarType.error,
    title: 'Network Error',
    message: 'Unable to load. Please check your internet connection.',
  );
      }
    }
  }

  /* ================= LOAD NOTIFICATION SETTINGS ================= */

  Future<void> _loadNotificationSettings() async {
    try {
      final response = await supabase
          .from('user_notification_settings')
          .select()
          .eq('user_id', userId)
          .maybeSingle();

      if (response != null) {
        setState(() {
          notificationsEnabled = response['enabled'] ?? true;
          // Convert 24h to 12h format
          final time24h = response['notify_time'] ?? '08:30';
          reminderTime = _convert24hTo12h(time24h);
        });
      }
      debugPrint("✅ Loaded notifications: enabled=$notificationsEnabled, time=$reminderTime");
    } catch (e) {
      debugPrint("❌ Error loading notification settings: $e");
    }
  }

  /* ================= TIME CONVERSION ================= */

  String _convert24hTo12h(String time24h) {
    try {
      // Handle "08:30" format
      final parts = time24h.split(':');
      if (parts.length != 2) return '08:30 AM';

      final hour = int.parse(parts[0]);
      final minute = parts[1];

      final period = hour >= 12 ? 'PM' : 'AM';
      final displayHour = hour == 0 ? 12 : (hour > 12 ? hour - 12 : hour);

      return '${displayHour.toString().padLeft(2, '0')}:$minute $period';
    } catch (e) {
      debugPrint("❌ Error converting 24h to 12h: $e");
      return '08:30 AM';
    }
  }

  String _convert12hTo24h(String time12h) {
    try {
      // Handle "08:30 AM" or "08:30AM" format
      final cleanTime = time12h.trim();
      final parts = cleanTime.split(RegExp(r'[: ]'));
      
      if (parts.length < 3) {
        debugPrint("❌ Invalid time format: $time12h");
        return '08:30';
      }

      int hour = int.parse(parts[0]);
      final minute = parts[1];
      final period = parts[2].toUpperCase();

      // Convert to 24h
      if (period == 'PM' && hour != 12) {
        hour += 12;
      } else if (period == 'AM' && hour == 12) {
        hour = 0;
      }

      return '${hour.toString().padLeft(2, '0')}:$minute';
    } catch (e) {
      debugPrint("❌ Error converting 12h to 24h: $e");
      return '08:30';
    }
  }

  /* ================= TIME PICKER DIALOG ================= */

  void _openTimeDialog() {
     final bool isDark =
      context.read<ThemeProvider>().isDark;
    showDialog(
      context: context,
      builder: (_) => CustomTimeDialog(
        isDark: isDark,
        initialTime: reminderTime,
        onConfirm: (time) async {
          setState(() => reminderTime = time);

          // Convert to 24h format for storage
          final time24h = _convert12hTo24h(time);

          try {
            await supabase.from('user_notification_settings').upsert({
              'user_id': userId,
              'enabled': notificationsEnabled,
              'notify_time': time24h,
            });

            if (mounted) {
            
            }
            debugPrint("✅ Reminder time saved: $time (24h: $time24h)");
          } catch (e) {
            debugPrint("❌ Error saving reminder time: $e");
            if (mounted) {
            
            }
          }
        },
      ),
    );
  }

  /* ================= EDIT PROFILE ================= */

  void _openEditProfile() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => const EditProfileScreen(),
      ),
    );
  }

  /* ================= TOGGLE NOTIFICATIONS ================= */

  Future<void> _toggleNotifications(bool value) async {
    setState(() => isLoading = true);
    final previousValue = notificationsEnabled;

    try {
      setState(() => notificationsEnabled = value);

      // Convert time to 24h format
      final time24h = _convert12hTo24h(reminderTime);

      // Save to Supabase
      await supabase.from('user_notification_settings').upsert({
        'user_id': userId,
        'enabled': value,
        'notify_time': time24h,
      });

      if (value) {
        await NotificationService.saveFcmToken(userId);
      }

      if (mounted) {
      if (mounted) {
  showCustomSnackbar(
    type: SnackbarType.success,
    title: 'Notifications',
    message: value
        ? 'Notifications enabled'
        : 'Notifications disabled',
  );
}

      }

      debugPrint("✅ Notifications toggled: $value");
    } catch (e) {
      debugPrint("❌ Error toggling notifications: $e");

      // Revert on error
      setState(() => notificationsEnabled = previousValue);

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text("Error: $e"),
            backgroundColor: Colors.red,
          ),
        );
      }
    } finally {
      setState(() => isLoading = false);
    }
  }



  /* ================= UI HELPERS ================= */

  Widget _topBar() {
     final bool isDark =
      context.read<ThemeProvider>().isDark;
    return Padding(
      padding: EdgeInsets.all(SizeConfig.blockWidth * 3),
      child: Row(
        children: [
          Icon(
            Icons.settings,
            color: isDark
                ? AppColors.darkTextPrimary
                : AppColors.lightTextPrimary,
            size: SizeConfig.blockWidth * 7,
          ),
          const SizedBox(width: 10),
          Text(
            'Settings',
            style: TextStyle(
              fontSize: SizeConfig.blockWidth * 6,
              fontWeight: FontWeight.bold,
              color: isDark
                  ? AppColors.darkTextPrimary
                  : AppColors.lightTextPrimary,
            ),
          ),
        ],
      ),
    );
  }

  Widget _section(String title, List<Widget> children) {
     final bool isDark =
      context.read<ThemeProvider>().isDark;
    return Padding(
      padding: EdgeInsets.all(SizeConfig.blockWidth * 4),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title.toUpperCase(),
            style: TextStyle(
              fontSize: SizeConfig.blockWidth * 2.8,
              fontWeight: FontWeight.w600,
              color: isDark
                  ? AppColors.darkTextSecondary
                  : AppColors.lightTextSecondary,
            ),
          ),
          SizedBox(height: SizeConfig.blockHeight * 1),
          Container(
            decoration: BoxDecoration(
              color: isDark
                  ? AppColors.darkSurfaceLight
                  : AppColors.lightSurfaceLight,
              borderRadius:
                  BorderRadius.circular(SizeConfig.blockWidth * 3),
            ),
            child: Column(children: children),
          ),
        ],
      ),
    );
  }

  Widget _signOutButton() {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: SizeConfig.blockWidth * 4,
        vertical: SizeConfig.blockHeight * 3,
      ),
      child: GestureDetector(
        onTap: _signOut,
        child: Container(
          width: double.infinity,
          padding: EdgeInsets.symmetric(
            vertical: SizeConfig.blockHeight * 2,
          ),
          decoration: BoxDecoration(
            color: AppColors.errorColor.withOpacity(0.1),
            borderRadius:
                BorderRadius.circular(SizeConfig.blockWidth * 3),
            border: Border.all(
              color: AppColors.errorColor.withOpacity(0.3),
            ),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.logout,
                color: AppColors.errorColor,
                size: SizeConfig.blockWidth * 5,
              ),
              SizedBox(width: SizeConfig.blockWidth * 2),
              Text(
                'Sign Out',
                style: TextStyle(
                  fontSize: SizeConfig.blockWidth * 4,
                  fontWeight: FontWeight.w600,
                  color: AppColors.errorColor,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
      final themeProvider = context.watch<ThemeProvider>();
    final bool isDark = themeProvider.isDark;
    final provider = context.watch<ProfileProvider>();
    final profile = provider.profile;

    if (provider.loading || profile == null) {
      return Scaffold(
        backgroundColor: isDark ? AppColors.darkBg : AppColors.lightBg,
        body: const Center(child: CircularProgressIndicator()),
      );
    }

    return Scaffold(
      backgroundColor: isDark ? AppColors.darkBg : AppColors.lightBg,
      body: SafeArea(
        child: Stack(
          children: [
            SingleChildScrollView(
              child: Column(
                children: [
                  _topBar(),

                  /// ================= PROFILE =================
                  ProfileHeader(
                    isDark: isDark,
                    name: profile.name,
                    email: profile.email,
                    imageUrl: profile.avatarUrl,
                    onTap: _openEditProfile,
                  ),

                  /// ================= APPEARANCE =================
                  _section(
                    'Appearance',
                    [
                      SettingsTile(
                        icon: Icons.dark_mode,
                        iconBg: AppColors.accentPurple.withOpacity(0.15),
                        iconColor: AppColors.accentPurple,
                        title: 'Dark Mode',
                        isDark: isDark,
                        trailing: Switch.adaptive(
                      value: isDark,
                      activeColor: AppColors.primaryColor,
                      onChanged: themeProvider.toggleTheme, // ✅ GLOBAL
                    ),
                      ),
                 
                    ],
                  ),

                  /// ================= NOTIFICATIONS =================
                  _section(
                    'Notifications',
                    [
                      NotificationTile(
                        isDark: isDark,
                        enabled: notificationsEnabled,
                        onChanged: _toggleNotifications,
                      ),
                      SettingsTile(
                        icon: Icons.schedule,
                        iconBg: AppColors.accentGreen.withOpacity(0.15),
                        iconColor: AppColors.accentGreen,
                        title: 'Reminder Time',
                        isDark: isDark,
                        onTap:
                            notificationsEnabled ? _openTimeDialog : null,
                        trailing: Opacity(
                          opacity: notificationsEnabled ? 1 : 0.4,
                          child: Container(
                            padding: EdgeInsets.symmetric(
                              horizontal: SizeConfig.blockWidth * 3,
                              vertical: SizeConfig.blockHeight * 0.8,
                            ),
                            decoration: BoxDecoration(
                              color: isDark
                                  ? AppColors.darkSurfaceLight
                                  : AppColors.lightSurfaceDark,
                              borderRadius: BorderRadius.circular(
                                SizeConfig.blockWidth * 2,
                              ),
                            ),
                            child: Text(
                              reminderTime,
                              style: TextStyle(
                                color: AppColors.primaryColor,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),

                 


                  _signOutButton(),
                  const SizedBox(height: 24),
                ],
              ),
            ),
            if (isLoading)
              Container(
                color: Colors.black.withOpacity(0.3),
                child: const Center(
                  child: CircularProgressIndicator(),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
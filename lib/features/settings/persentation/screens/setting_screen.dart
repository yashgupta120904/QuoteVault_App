import 'dart:io';

import 'package:flutter/material.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../profile/data/model/user_profile.dart';
import '../../../profile/presentation/edit_profile_screen.dart';
import '../widgets/custom_time_diallog.dart';
import '../widgets/font_size_tile.dart';
import '../widgets/notification_tile.dart';
import '../widgets/profile_header.dart';
import '../widgets/settings_tile.dart';
import '../widgets/time_till.dart';


/* ---------------- SIZE CONFIG ---------------- */

// class SizeConfig {
//   static double screenWidth = 0;
//   static double screenHeight = 0;
//   static double blockWidth = 0;
//   static double blockHeight = 0;

//   static void init(BuildContext context) {
//     final mq = MediaQuery.of(context);
//     screenWidth = mq.size.width;
//     screenHeight = mq.size.height;
//     blockWidth = screenWidth / 100;
//     blockHeight = screenHeight / 100;
//   }
// }

// /* ---------------- SETTINGS SCREEN ---------------- */

// class SettingsScreen extends StatefulWidget {
//   const SettingsScreen({super.key});

//   @override
//   State<SettingsScreen> createState() => _SettingsScreenState();
// }

// class _SettingsScreenState extends State<SettingsScreen> {
//   bool isDark = true;
//   bool notificationsEnabled = true;
//   bool biometricEnabled = false;
//   String reminderTime = '08:30 AM';

//   @override
//   void didChangeDependencies() {
//     super.didChangeDependencies();
//     SizeConfig.init(context);
//   }

//   void _openTimeDialog() {
//     showDialog(
//       context: context,
//       builder: (_) => CustomTimeDialog(
//         initialTime: reminderTime,
//         isDark: isDark,
//         onConfirm: (time) {
//           setState(() => reminderTime = time);
//         },
//       ),
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor:
//           isDark ? AppColors.darkBg : AppColors.lightBg,
//       body: SafeArea(
//         child: SingleChildScrollView(
//           child: Column(
//             children: [
//               _header(),
//               _section(
//                 'Appearance',
//                 [
//                   SettingsTile(
//                     icon: Icons.dark_mode,
//                     iconBg: AppColors.accentPurple.withOpacity(0.15),
//                     iconColor: AppColors.accentPurple,
//                     title: 'Dark Mode',
//                     isDark: isDark,
//                     trailing: Switch.adaptive(
//                       value: isDark,
//                       activeColor: AppColors.primaryColor,
//                       onChanged: (v) =>
//                           setState(() => isDark = v),
//                     ),
//                   ),
//                 ],
//               ),
//               _section(
//                 'Notifications',
//                 [
//                   NotificationTile(
//                     enabled: notificationsEnabled,
//                     isDark: isDark,
//                     onChanged: (v) =>
//                         setState(() => notificationsEnabled = v),
//                   ),
//                   TimeTile(
//                     time: reminderTime,
//                     enabled: notificationsEnabled,
//                     isDark: isDark,
//                     onTap: _openTimeDialog,
//                   ),
//                 ],
//               ),
//               _section(
//                 'Security',
//                 [
//                   SettingsTile(
//                     icon: Icons.fingerprint,
//                     iconBg: AppColors.accentOrange.withOpacity(0.15),
//                     iconColor: AppColors.accentOrange,
//                     title: 'Face ID / Touch ID',
//                     isDark: isDark,
//                     trailing: Switch.adaptive(
//                       value: biometricEnabled,
//                       activeColor: AppColors.primaryColor,
//                       onChanged: (v) =>
//                           setState(() => biometricEnabled = v),
//                     ),
//                     hasDivider: true,
//                   ),
//                   SettingsTile(
//                     icon: Icons.lock,
//                     iconBg: AppColors.accentPurple.withOpacity(0.15),
//                     iconColor: AppColors.accentPurple,
//                     title: 'Privacy Policy',
//                     isDark: isDark,
//                     trailing: const Icon(Icons.chevron_right),
//                   ),
//                 ],
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }

//   Widget _header() {
//     return Padding(
//       padding: EdgeInsets.all(SizeConfig.blockWidth * 4),
//       child: Row(
//         children: [
//           const BackButton(),
//           Expanded(
//             child: Text(
//               'Settings',
//               textAlign: TextAlign.center,
//               style: TextStyle(
//                 fontWeight: FontWeight.bold,
//                 fontSize: SizeConfig.blockWidth * 4.2,
//                 color: isDark
//                     ? AppColors.darkTextPrimary
//                     : AppColors.lightTextPrimary,
//               ),
//             ),
//           ),
//           const SizedBox(width: 40),
//         ],
//       ),
//     );
//   }

//   Widget _section(String title, List<Widget> children) {
//     return Padding(
//       padding: EdgeInsets.all(SizeConfig.blockWidth * 4),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Text(
//             title.toUpperCase(),
//             style: TextStyle(
//               fontSize: SizeConfig.blockWidth * 2.8,
//               fontWeight: FontWeight.w600,
//               color: isDark
//                   ? AppColors.darkTextSecondary
//                   : AppColors.lightTextSecondary,
//             ),
//           ),
//           SizedBox(height: SizeConfig.blockHeight * 1),
//           Container(
//             decoration: BoxDecoration(
//               color: isDark
//                   ? AppColors.darkSurfaceLight
//                   : AppColors.lightSurfaceLight,
//               borderRadius:
//                   BorderRadius.circular(SizeConfig.blockWidth * 3),
//             ),
//             child: Column(children: children),
//           ),
//         ],
//       ),
//     );
//   }
// }



/* ---------------- SIZE CONFIG ---------------- */

// class SizeConfig {
//   static double screenWidth = 0;
//   static double screenHeight = 0;
//   static double blockWidth = 0;
//   static double blockHeight = 0;

//   static void init(BuildContext context) {
//     final mq = MediaQuery.of(context);
//     screenWidth = mq.size.width;
//     screenHeight = mq.size.height;
//     blockWidth = screenWidth / 100;
//     blockHeight = screenHeight / 100;
//   }
// }

// /* ---------------- SETTINGS SCREEN ---------------- */

// class SettingsScreen extends StatefulWidget {
//   const SettingsScreen({super.key});

//   @override
//   State<SettingsScreen> createState() => _SettingsScreenState();
// }

// class _SettingsScreenState extends State<SettingsScreen> {
//   bool isDark = true;
//   bool notificationsEnabled = true;
//   bool biometricEnabled = false;
//   double fontSize = 16;
//   String reminderTime = '08:30 AM';

//   @override
//   void didChangeDependencies() {
//     super.didChangeDependencies();
//     SizeConfig.init(context);
//   }

//   void _openTimeDialog() {
//     showDialog(
//       context: context,
//       builder: (_) => CustomTimeDialog(
//         isDark: isDark,
//         initialTime: reminderTime,
//         onConfirm: (time) {
//           setState(() => reminderTime = time);
//         },
//       ),
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor:
//           isDark ? AppColors.darkBg : AppColors.lightBg,
//       body: SafeArea(
//         child: SingleChildScrollView(
//           child: Column(
//             children: [
//               _topBar(),

//               /// PROFILE
//               ProfileHeader(
//                 isDark: isDark,
//                 name: 'Alex Rivera',
//                 email: 'alex.rivera@example.com',
//                 imageUrl: 'https://i.pravatar.cc/300',
//                 onTap: () {},
//               ),

//               /// APPEARANCE
//               _section(
//                 'Appearance',
//                 [
//                   SettingsTile(
//                     icon: Icons.dark_mode,
//                     iconBg:
//                         AppColors.accentPurple.withOpacity(0.15),
//                     iconColor: AppColors.accentPurple,
//                     title: 'Dark Mode',
//                     isDark: isDark,
//                     trailing: Switch.adaptive(
//                       value: isDark,
//                       activeColor: AppColors.primaryColor,
//                       onChanged: (v) =>
//                           setState(() => isDark = v),
//                     ),
//                   ),
//                   FontSizeTile(
//                     isDark: isDark,
//                     fontSize: fontSize,
//                     onChanged: (v) =>
//                         setState(() => fontSize = v),
//                   ),
//                 ],
//               ),

//               /// NOTIFICATIONS
//               _section(
//                 'Notifications',
//                 [
//                   NotificationTile(
//                     isDark: isDark,
//                     enabled: notificationsEnabled,
//                     onChanged: (v) =>
//                         setState(() => notificationsEnabled = v),
//                   ),
//                   SettingsTile(
//                     icon: Icons.schedule,
//                     iconBg:
//                         AppColors.accentGreen.withOpacity(0.15),
//                     iconColor: AppColors.accentGreen,
//                     title: 'Reminder Time',
//                     isDark: isDark,
//                     onTap:
//                         notificationsEnabled ? _openTimeDialog : null,
//                     trailing: Opacity(
//                       opacity: notificationsEnabled ? 1 : 0.4,
//                       child: Container(
//                         padding: EdgeInsets.symmetric(
//                           horizontal:
//                               SizeConfig.blockWidth * 3,
//                           vertical:
//                               SizeConfig.blockHeight * 0.8,
//                         ),
//                         decoration: BoxDecoration(
//                           color: isDark
//                               ? AppColors.darkSurfaceLight
//                               : AppColors.lightSurfaceDark,
//                           borderRadius:
//                               BorderRadius.circular(
//                                   SizeConfig.blockWidth * 2),
//                         ),
//                         child: Text(
//                           reminderTime,
//                           style: TextStyle(
//                             color: AppColors.primaryColor,
//                             fontWeight: FontWeight.bold,
//                           ),
//                         ),
//                       ),
//                     ),
//                   ),
//                 ],
//               ),

//               /// SECURITY
//               _section(
//                 'Security',
//                 [
//                   SettingsTile(
//                     icon: Icons.fingerprint,
//                     iconBg:
//                         AppColors.accentOrange.withOpacity(0.15),
//                     iconColor: AppColors.accentOrange,
//                     title: 'Face ID / Touch ID',
//                     isDark: isDark,
//                     trailing: Switch.adaptive(
//                       value: biometricEnabled,
//                       activeColor: AppColors.primaryColor,
//                       onChanged: (v) =>
//                           setState(() => biometricEnabled = v),
//                     ),
//                     hasDivider: true,
//                   ),
//                   SettingsTile(
//                     icon: Icons.lock,
//                     iconBg:
//                         AppColors.accentPurple.withOpacity(0.15),
//                     iconColor: AppColors.accentPurple,
//                     title: 'Privacy Policy',
//                     isDark: isDark,
//                     trailing: const Icon(Icons.chevron_right),
//                   ),
//                 ],
//               ),

//               const SizedBox(height: 24),
//             ],
//           ),
//         ),
//       ),
//     );
//   }

//   Widget _topBar() {
//     return Padding(
//       padding: EdgeInsets.all(SizeConfig.blockWidth * 4),
//       child: Row(
//         children: [
//           const BackButton(),
//           Expanded(
//             child: Text(
//               'Settings',
//               textAlign: TextAlign.center,
//               style: TextStyle(
//                 fontSize: SizeConfig.blockWidth * 4.2,
//                 fontWeight: FontWeight.bold,
//                 color: isDark
//                     ? AppColors.darkTextPrimary
//                     : AppColors.lightTextPrimary,
//               ),
//             ),
//           ),
//           const SizedBox(width: 40),
//         ],
//       ),
//     );
//   }

//   Widget _section(String title, List<Widget> children) {
//     return Padding(
//       padding: EdgeInsets.all(SizeConfig.blockWidth * 4),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Text(
//             title.toUpperCase(),
//             style: TextStyle(
//               fontSize: SizeConfig.blockWidth * 2.8,
//               fontWeight: FontWeight.w600,
//               color: isDark
//                   ? AppColors.darkTextSecondary
//                   : AppColors.lightTextSecondary,
//             ),
//           ),
//           SizedBox(height: SizeConfig.blockHeight * 1),
//           Container(
//             decoration: BoxDecoration(
//               color: isDark
//                   ? AppColors.darkSurfaceLight
//                   : AppColors.lightSurfaceLight,
//               borderRadius:
//                   BorderRadius.circular(SizeConfig.blockWidth * 3),
//             ),
//             child: Column(children: children),
//           ),
//         ],
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';

// 🔁 assumes these already exist in your project
// import 'app_colors.dart';
// import 'widgets/profile_header.dart';
// import 'widgets/settings_tile.dart';
// import 'widgets/font_size_tile.dart';
// import 'widgets/notification_tile.dart';
// import 'widgets/custom_time_dialog.dart';

class SizeConfig {
  static double screenWidth = 0;
  static double screenHeight = 0;
  static double blockWidth = 0;
  static double blockHeight = 0;

  static void init(BuildContext context) {
    final mq = MediaQuery.of(context);
    screenWidth = mq.size.width;
    screenHeight = mq.size.height;
    blockWidth = screenWidth / 100;
    blockHeight = screenHeight / 100;
  }
}

/* ---------------- SETTINGS SCREEN ---------------- */

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  bool isDark = true;
  bool notificationsEnabled = true;
  bool biometricEnabled = false;
  double fontSize = 16;
  String reminderTime = '08:30 AM';

  /// ✅ LOCAL PROFILE STATE
  UserProfile profile = UserProfile(
    name: 'Alex Rivera',
    email: 'alex.rivera@example.com',
    imagePath: null,
  );

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    SizeConfig.init(context);
  }

  void _openTimeDialog() {
    showDialog(
      context: context,
      builder: (_) => CustomTimeDialog(
        isDark: isDark,
        initialTime: reminderTime,
        onConfirm: (time) {
          setState(() => reminderTime = time);
        },
      ),
    );
  }

  void _openEditProfile() async {
    final updatedProfile = await Navigator.push<UserProfile>(
      context,
      MaterialPageRoute(
        builder: (_) => EditProfileScreen(profile: profile),
      ),
    );

    if (updatedProfile != null) {
      setState(() {
        profile = updatedProfile;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: isDark ? AppColors.darkBg : AppColors.lightBg,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              _topBar(),

              /// ================= PROFILE =================
              ProfileHeader(
                isDark: isDark,
                name: profile.name,
                email: profile.email,
                imageUrl: profile.imagePath != null
                    ? File(profile.imagePath!).path
                    : null,
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
                      onChanged: (v) => setState(() => isDark = v),
                    ),
                  ),
                  FontSizeTile(
                    isDark: isDark,
                    fontSize: fontSize,
                    onChanged: (v) => setState(() => fontSize = v),
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
                    onChanged: (v) =>
                        setState(() => notificationsEnabled = v),
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
                              SizeConfig.blockWidth * 2),
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

              /// ================= SECURITY =================
              _section(
                'Security',
                [
                  SettingsTile(
                    icon: Icons.fingerprint,
                    iconBg:
                        AppColors.accentOrange.withOpacity(0.15),
                    iconColor: AppColors.accentOrange,
                    title: 'Face ID / Touch ID',
                    isDark: isDark,
                    trailing: Switch.adaptive(
                      value: biometricEnabled,
                      activeColor: AppColors.primaryColor,
                      onChanged: (v) =>
                          setState(() => biometricEnabled = v),
                    ),
                    hasDivider: true,
                  ),
                  SettingsTile(
                    icon: Icons.lock,
                    iconBg:
                        AppColors.accentPurple.withOpacity(0.15),
                    iconColor: AppColors.accentPurple,
                    title: 'Privacy Policy',
                    isDark: isDark,
                    trailing: const Icon(Icons.chevron_right),
                  ),
                ],
              ),

              /// ================= SIGN OUT =================
              _signOutButton(),

              const SizedBox(height: 24),
            ],
          ),
        ),
      ),
    );
  }

  /* ---------------- UI HELPERS ---------------- */

  Widget _topBar() {
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

  /* ---------------- SIGN OUT ---------------- */

  Widget _signOutButton() {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: SizeConfig.blockWidth * 4,
        vertical: SizeConfig.blockHeight * 3,
      ),
      child: GestureDetector(
        onTap: () {
          showDialog(
            context: context,
            builder: (context) => AlertDialog(
              backgroundColor: isDark
                  ? AppColors.darkSurfaceLight
                  : AppColors.lightSurfaceLight,
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
                  onPressed: () => Navigator.pop(context),
                  child: const Text('Cancel'),
                ),
                TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                    // TODO: real logout
                  },
                  child: Text(
                    'Sign Out',
                    style:
                        TextStyle(color: AppColors.errorColor),
                  ),
                ),
              ],
            ),
          );
        },
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
}

import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

import '../../../../../core/constants/app_colors.dart';
import '../../../../../core/utils/size_config.dart';
import '../../../../../core/utils/custom_snackbar.dart';
import '../../../../../core/widgets/custom_back_button.dart';
import '../../../auth/presentation/widgets/auth_button.dart';
import '../provider/profile_provider.dart';

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({super.key});

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  late TextEditingController _nameController;

  File? _imageFile;
  String _initialName = '';
  bool _hasChanges = false;

  bool get isDark => Theme.of(context).brightness == Brightness.dark;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    SizeConfig.init(context);

    final profile = context.read<ProfileProvider>().profile!;
    _initialName = profile.name;

    _nameController = TextEditingController(text: profile.name);
    _nameController.addListener(_checkForChanges);
  }

  void _checkForChanges() {
    final name = _nameController.text.trim();

    final nameChanged = name.isNotEmpty && name != _initialName;
    final imageChanged = _imageFile != null;

    setState(() {
      _hasChanges = nameChanged || imageChanged;
    });
  }

  /* ---------------- IMAGE PICKER ---------------- */

  Future<void> _pickImage() async {
    try {
      final picked = await ImagePicker().pickImage(
        source: ImageSource.gallery,
        imageQuality: 85,
      );

      if (picked != null) {
        setState(() {
          _imageFile = File(picked.path);
          _hasChanges = true;
        });
      }
    } catch (_) {
      showCustomSnackbar(
        type: SnackbarType.error,
        title: 'Error',
        message: 'Failed to pick image',
      );
    }
  }

  /* ---------------- SAVE PROFILE ---------------- */

  Future<void> _saveProfile() async {
    final name = _nameController.text.trim();
    if (name.isEmpty) return;

    await context.read<ProfileProvider>().updateProfile(
          name: name,
          avatarFile: _imageFile,
        );

    showCustomSnackbar(
      type: SnackbarType.success,
      title: 'Profile Updated',
      message: 'Your profile was updated successfully',
    );

    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    final profile = context.watch<ProfileProvider>().profile!;

    return Scaffold(
      backgroundColor: isDark ? AppColors.darkBg : AppColors.lightBg,
      body: SafeArea(
        child: Column(
          children: [
            _topBar(),

            Expanded(
              child: SingleChildScrollView(
                padding: EdgeInsets.all(SizeConfig.blockWidth * 6),
                child: Column(
                  children: [
                    _avatar(profile),

                    SizedBox(height: SizeConfig.blockHeight * 4),

                    _label('FULL NAME'),
                    TextField(
                      controller: _nameController,
                      decoration:
                          _inputDecoration(hint: 'Enter your name'),
                    ),

                    SizedBox(height: SizeConfig.blockHeight * 3),

                    _label('EMAIL'),
                    TextField(
                      readOnly: true,
                      enabled: false,
                      decoration: _inputDecoration(
                        hint: profile.email,
                        suffixIcon: Icons.lock,
                      ),
                    ),
                  ],
                ),
              ),
            ),

            Padding(
              padding: EdgeInsets.all(SizeConfig.blockWidth * 5),
              child: CustomButton(
                text: 'Save Changes',
                isEnabled: _hasChanges,
                onPressed: _hasChanges ? _saveProfile : null,
              ),
            ),
          ],
        ),
      ),
    );
  }

  /* ---------------- UI PARTS ---------------- */

  Widget _topBar() {
    return Padding(
      padding: EdgeInsets.all(SizeConfig.blockWidth * 4),
      child: Row(
        children: [
          CustomCircularBackButton(isDark: isDark),
          SizedBox(width: SizeConfig.blockWidth * 4),
          Text(
            'Edit Profile',
            style: TextStyle(
              fontSize: SizeConfig.blockWidth * 5,
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

  Widget _avatar(profile) {
    return GestureDetector(
      onTap: _pickImage,
      child: Stack(
        alignment: Alignment.bottomRight,
        children: [
          CircleAvatar(
            radius: SizeConfig.blockWidth * 18,
            backgroundImage: _imageFile != null
                ? FileImage(_imageFile!)
                : profile.avatarUrl != null
                    ? NetworkImage(profile.avatarUrl!)
                    : null,
            child: _imageFile == null && profile.avatarUrl == null
                ? Icon(
                    Icons.person,
                    size: SizeConfig.blockWidth * 14,
                  )
                : null,
          ),
          CircleAvatar(
            radius: SizeConfig.blockWidth * 4,
            backgroundColor: AppColors.primaryColor,
            child: const Icon(
              Icons.camera_alt,
              color: Colors.white,
            ),
          ),
        ],
      ),
    );
  }

  Widget _label(String text) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Text(
        text,
        style: TextStyle(
          fontSize: SizeConfig.blockWidth * 3,
          color: AppColors.darkTextSecondary,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }

  InputDecoration _inputDecoration({
    required String hint,
    IconData? suffixIcon,
  }) {
    return InputDecoration(
      filled: true,
      fillColor:
          isDark ? AppColors.darkSurfaceLight : AppColors.lightSurfaceLight,
      hintText: hint,
      suffixIcon:
          suffixIcon != null ? Icon(suffixIcon, size: 18) : null,
      border: OutlineInputBorder(
        borderRadius:
            BorderRadius.circular(SizeConfig.blockWidth * 3),
        borderSide: BorderSide.none,
      ),
    );
  }
}

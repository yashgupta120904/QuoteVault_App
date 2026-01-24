import 'dart:io';
import 'package:flutter/material.dart';
import '../../data/model/user_profile.dart';
import '../../data/repository/profile_repository.dart';


class ProfileProvider extends ChangeNotifier {
  final ProfileRepository _repo = ProfileRepository();

  UserProfile? profile;
  bool loading = false;

  Future<void> loadProfile() async {
    loading = true;
    notifyListeners();

    profile = await _repo.fetchProfile();

    loading = false;
    notifyListeners();
  }

  Future<void> updateProfile({
    required String name,
    File? avatarFile,
  }) async {
    profile = await _repo.updateProfile(
      name: name,
      avatarFile: avatarFile,
    );
    notifyListeners();
  }
}

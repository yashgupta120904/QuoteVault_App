
// // import 'dart:io';
// // import 'package:quotevault/core/config/supabase_config.dart';
// // import '../model/user_profile.dart';

// // class ProfileRepository {
// //   final _client = SupabaseConfig.client;

// //   /// ================= FETCH PROFILE =================
// //   Future<UserProfile> fetchProfile() async {
// //     final user = _client.auth.currentUser;

// //     if (user == null) {
// //       throw Exception('User not logged in');
// //     }

// //     final data =
// //         await _client.from('profiles').select().eq('id', user.id).single();

// //     return UserProfile(
// //       id: user.id,
// //       name: data['name'] ?? '',
// //       email: user.email ?? '', // ✅ FIX HERE
// //       avatarUrl: data['avatar_url'], // ✅ FIX HERE
// //     );
// //   }

// //   Future<UserProfile> updateProfile({
// //     required String name,
// //     File? avatarFile,
// //   }) async {
// //     final user = _client.auth.currentUser;

// //     if (user == null) {
// //       throw Exception('User not logged in');
// //     }

// //     String? avatarUrl;

// //     if (avatarFile != null) {
// //       final bytes = await avatarFile.readAsBytes();
// //       final path = '${user.id}.png';

// //       // 🔥 Delete old avatar if exists (ignore failure)
// //       await _client.storage.from('avatars').remove([path]);

// //       // ✅ Upload new avatar
// //       await _client.storage.from('avatars').uploadBinary(path, bytes);

// //       avatarUrl = _client.storage.from('avatars').getPublicUrl(path);
// //     }

// //     await _client.from('profiles').update({
// //       'name': name,
// //       if (avatarUrl != null) 'avatar_url': avatarUrl,
// //     }).eq('id', user.id);

// //     return fetchProfile();
// //   }
// // }
// import 'dart:io';
// import 'package:flutter/material.dart';
// import 'package:quotevault/core/config/supabase_config.dart';
// import '../model/user_profile.dart';

// class ProfileRepository {
//   final _client = SupabaseConfig.client;
//   static const String _avatarBucket = 'avatars';

//   /// ================= FETCH PROFILE =================
//   Future<UserProfile> fetchProfile() async {
//     try {
//       final user = _client.auth.currentUser;

//       if (user == null) {
//         throw Exception('User not logged in');
//       }

//       final data = await _client
//           .from('profiles')
//           .select()
//           .eq('id', user.id)
//           .single();

//       debugPrint("✅ Profile fetched successfully");

//       return UserProfile(
//         id: user.id,
//         name: data['name'] ?? '',
//         email: user.email ?? '',
//         avatarUrl: data['avatar_url'],
//       );
//     } catch (e) {
//       debugPrint("❌ Error fetching profile: $e");
//       rethrow;
//     }
//   }

//   /// ================= UPDATE PROFILE =================
//   Future<UserProfile> updateProfile({
//     required String name,
//     File? avatarFile,
//   }) async {
//     try {
//       final user = _client.auth.currentUser;

//       if (user == null) {
//         throw Exception('User not logged in');
//       }

//       if (name.isEmpty) {
//         throw Exception('Name cannot be empty');
//       }

//       String? avatarUrl;

//       // Upload new avatar if provided
//       if (avatarFile != null) {
//         avatarUrl = await _uploadAvatar(user.id, avatarFile);
//       }

//       // Update profile in database
//       await _client.from('profiles').update({
//         'name': name,
//         if (avatarUrl != null) 'avatar_url': avatarUrl,
//       }).eq('id', user.id);

//       debugPrint("✅ Profile updated successfully");

//       // Fetch and return updated profile
//       return fetchProfile();
//     } catch (e) {
//       debugPrint("❌ Error updating profile: $e");
//       rethrow;
//     }
//   }

//   /// ================= UPLOAD AVATAR =================
//   Future<String> _uploadAvatar(String userId, File avatarFile) async {
//     try {
//       final bytes = await avatarFile.readAsBytes();
//       final path = '$userId.png';

//       debugPrint("📤 Uploading avatar: $path");

//       // Delete old avatar if exists (ignore failure)
//       try {
//         await _client.storage.from(_avatarBucket).remove([path]);
//         debugPrint("🗑️ Old avatar deleted");
//       } catch (e) {
//         debugPrint("⚠️ No old avatar to delete: $e");
//       }

//       // Upload new avatar
//       await _client.storage.from(_avatarBucket).uploadBinary(path, bytes);

//       // Get public URL
//       final avatarUrl =
//           _client.storage.from(_avatarBucket).getPublicUrl(path);

//       debugPrint("✅ Avatar uploaded: $avatarUrl");
//       return avatarUrl;
//     } catch (e) {
//       debugPrint("❌ Error uploading avatar: $e");
//       rethrow;
//     }
//   }

//   /// ================= DELETE PROFILE =================
//   Future<void> deleteProfile() async {
//     try {
//       final user = _client.auth.currentUser;

//       if (user == null) {
//         throw Exception('User not logged in');
//       }

//       // Delete avatar
//       try {
//         await _client.storage
//             .from(_avatarBucket)
//             .remove(['${user.id}.png']);
//         debugPrint("🗑️ Avatar deleted");
//       } catch (e) {
//         debugPrint("⚠️ Avatar deletion failed: $e");
//       }

//       // Delete profile record
//       await _client.from('profiles').delete().eq('id', user.id);

//       debugPrint("✅ Profile deleted successfully");
//     } catch (e) {
//       debugPrint("❌ Error deleting profile: $e");
//       rethrow;
//     }
//   }
// }


import 'dart:io';
import 'package:flutter/material.dart';
import 'package:quotevault/core/config/supabase_config.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../model/user_profile.dart';

class ProfileRepository {
  final _client = SupabaseConfig.client;
  static const String _avatarBucket = 'avatars';

  /// ================= FETCH PROFILE =================
  Future<UserProfile> fetchProfile() async {
    try {
      final user = _client.auth.currentUser;

      if (user == null) {
        throw Exception('User not logged in');
      }

      final data = await _client
          .from('profiles')
          .select()
          .eq('id', user.id)
          .single();

      debugPrint("✅ Profile fetched successfully");

      return UserProfile(
        id: user.id,
        name: data['name'] ?? '',
        email: user.email ?? '',
        avatarUrl: data['avatar_url'],
      );
    } catch (e) {
      debugPrint("❌ Error fetching profile: $e");
      rethrow;
    }
  }

  /// ================= UPDATE PROFILE =================
  Future<UserProfile> updateProfile({
    required String name,
    File? avatarFile,
  }) async {
    try {
      final user = _client.auth.currentUser;

      if (user == null) {
        throw Exception('User not logged in');
      }

      if (name.isEmpty) {
        throw Exception('Name cannot be empty');
      }

      String? avatarUrl;

      // Upload new avatar if provided
      if (avatarFile != null) {
        avatarUrl = await _uploadAvatar(user.id, avatarFile);
      }

      // Update profile in database
      await _client.from('profiles').update({
        'name': name,
        if (avatarUrl != null) 'avatar_url': avatarUrl,
      }).eq('id', user.id);

      debugPrint("✅ Profile updated successfully");

      // Fetch and return updated profile
      return fetchProfile();
    } catch (e) {
      debugPrint("❌ Error updating profile: $e");
      rethrow;
    }
  }

  /// ================= UPLOAD AVATAR =================
  Future<String> _uploadAvatar(String userId, File avatarFile) async {
    try {
      final bytes = await avatarFile.readAsBytes();
      
      // Use unique filename with timestamp to avoid conflicts
      final timestamp = DateTime.now().millisecondsSinceEpoch;
      final path = '$userId/$userId-$timestamp.png';

      debugPrint("📤 Uploading avatar: $path");

      // Upload new avatar with upsert: false (create new, don't overwrite)
      await _client.storage.from(_avatarBucket).uploadBinary(
        path,
        bytes,
        fileOptions: const FileOptions(upsert: false),
      );

      // Get public URL
      final avatarUrl =
          _client.storage.from(_avatarBucket).getPublicUrl(path);

      debugPrint("✅ Avatar uploaded: $avatarUrl");

      // Delete old avatars in background (don't block upload)
      _deleteOldAvatars(userId).ignore();

      return avatarUrl;
    } catch (e) {
      debugPrint("❌ Error uploading avatar: $e");
      rethrow;
    }
  }

  /// ================= DELETE OLD AVATARS =================
  Future<void> _deleteOldAvatars(String userId) async {
    try {
      // List all avatars for this user
      final files =
          await _client.storage.from(_avatarBucket).list(path: userId);

      // Keep only the most recent, delete the rest
      if (files.length > 1) {
        // Sort by creation time (newest first)
        files.sort((a, b) => (b.createdAt)!.compareTo(a.createdAt!));

        // Delete all but the newest
        for (var i = 1; i < files.length; i++) {
          try {
            await _client.storage
                .from(_avatarBucket)
                .remove(['$userId/${files[i].name}']);
            debugPrint("🗑️ Deleted old avatar: ${files[i].name}");
          } catch (e) {
            debugPrint("⚠️ Failed to delete old avatar: $e");
          }
        }
      }
    } catch (e) {
      debugPrint("⚠️ Error cleaning old avatars: $e");
      // Don't rethrow - this is a background task
    }
  }

  /// ================= DELETE PROFILE =================
  Future<void> deleteProfile() async {
    try {
      final user = _client.auth.currentUser;

      if (user == null) {
        throw Exception('User not logged in');
      }

      // Delete all avatars for this user
      try {
        final files =
            await _client.storage.from(_avatarBucket).list(path: user.id);
        
        for (var file in files) {
          await _client.storage
              .from(_avatarBucket)
              .remove(['${user.id}/${file.name}']);
        }
        debugPrint("🗑️ All avatars deleted");
      } catch (e) {
        debugPrint("⚠️ Avatar deletion failed: $e");
      }

      // Delete profile record
      await _client.from('profiles').delete().eq('id', user.id);

      debugPrint("✅ Profile deleted successfully");
    } catch (e) {
      debugPrint("❌ Error deleting profile: $e");
      rethrow;
    }
  }
}
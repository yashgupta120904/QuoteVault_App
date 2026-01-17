class UserProfile {
  final String name;
  final String email;
  final String? imagePath;

  UserProfile({
    required this.name,
    required this.email,
    this.imagePath,
  });

  UserProfile copyWith({
    String? name,
    String? imagePath,
  }) {
    return UserProfile(
      name: name ?? this.name,
      email: email,
      imagePath: imagePath ?? this.imagePath,
    );
  }
}

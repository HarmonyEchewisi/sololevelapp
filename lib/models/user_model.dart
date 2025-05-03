/// Data model representing a user in the application.
class UserModel {
  /// The user's unique identifier.
  final String uid;

  /// The user's email address (optional).
  final String? email;

  /// The user's display name (optional).
  final String? displayName;

  /// The user's current XP (experience points).
  final int xp;

  /// The user's current level.
  final int level;

  UserModel({
    required this.uid,
    this.email,
    this.displayName,
    this.xp = 0,
    this.level = 1,
  });

  /// Creates a [UserModel] from a [Map] (e.g., from Firestore or navigation).
  factory UserModel.fromMap(Map<String, dynamic> data) {
    return UserModel(
      uid: data['uid'] ?? '',
      email: data['email'],
      displayName: data['displayName'],
      xp: data['xp'] ?? 0,
      level: data['level'] ?? 1,
    );
  }

  /// Converts this [UserModel] to a [Map] (e.g., for Firestore or navigation).
  Map<String, dynamic> toMap() {
    return {
      'uid': uid,
      'email': email,
      'displayName': displayName,
      'xp': xp,
      'level': level,
    };
  }
}

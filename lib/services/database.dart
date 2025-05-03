import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/user_model.dart';

/// Service class for handling user data in Firestore.
///
/// Provides methods to update XP, mark workouts as completed, and stream user data.
class DatabaseService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  /// Updates the user's XP and level in Firestore.
  ///
  /// If the user document does not exist, it is created with default values.
  /// XP is incremented by [xp], and level is incremented by [xp] divided by 100.
  Future<void> updateXP(String userId, int xp) async {
    if (userId.isEmpty) {
      throw Exception('User ID is empty');
    }

    DocumentReference userRef = _firestore.collection('users').doc(userId);
    DocumentSnapshot userDoc = await userRef.get();

    if (!userDoc.exists) {
      // Create user document if it doesn't exist
      await userRef.set({'xp': 0, 'level': 1, 'completedWorkouts': []});
    }

    // Update XP & Level
    await userRef.update({
      'xp': FieldValue.increment(xp),
      'level': FieldValue.increment(xp ~/ 100),
    });
  }

  /// Marks a workout as completed for the user in Firestore.
  ///
  /// If the user document does not exist, it is created with default values.
  /// The [workoutDay] is added to the user's list of completed workouts.
  Future<void> markWorkoutCompleted(String userId, String workoutDay) async {
    if (userId.isEmpty) {
      throw Exception('User ID is empty');
    }

    DocumentReference userRef = _firestore.collection('users').doc(userId);
    DocumentSnapshot userDoc = await userRef.get();

    if (!userDoc.exists) {
      // Create user document if it doesn't exist
      await userRef.set({'xp': 0, 'level': 1, 'completedWorkouts': []});
    }

    // Mark workout as completed
    await userRef.update({
      'completedWorkouts': FieldValue.arrayUnion([workoutDay]),
    });
  }

  /// Streams the user's data as a [UserModel] from Firestore.
  ///
  /// If the user document does not exist, returns a [UserModel] with default values.
  Stream<UserModel> getUser(String userId) {
    if (userId.isEmpty) {
      throw Exception('User ID is empty');
    }

    return _firestore.collection('users').doc(userId).snapshots().map((
      snapshot,
    ) {
      if (snapshot.exists && snapshot.data() != null) {
        return UserModel.fromMap(snapshot.data()!);
      } else {
        return UserModel(uid: userId, xp: 0, level: 1); // Default values
      }
    });
  }
}

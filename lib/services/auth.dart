import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import '../models/user_model.dart';

/// Service class for handling user authentication, including Google sign-in and sign-out.
///
/// Provides a stream of [UserModel] for authentication state changes.
class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn();

  /// Returns the currently signed-in Firebase [User], or null if not signed in.
  User? get currentUser => _auth.currentUser;

  /// Stream of [UserModel] reflecting authentication state changes.
  ///
  /// Emits a new [UserModel] when the user signs in or out.
  Stream<UserModel?> get userStream {
    return _auth.authStateChanges().map((user) {
      if (user == null) return null;
      return UserModel(
        uid: user.uid,
        email: user.email,
        displayName: user.displayName,
      );
    });
  }

  /// Signs in the user using Google authentication.
  ///
  /// Returns a [UserModel] on success, or null if sign-in was cancelled or failed.
  Future<UserModel?> signInWithGoogle() async {
    try {
      await _googleSignIn.signOut(); // Allow selecting another account
      final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();
      if (googleUser == null) return null;

      final GoogleSignInAuthentication googleAuth =
          await googleUser.authentication;
      final AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      final UserCredential userCredential = await _auth.signInWithCredential(
        credential,
      );
      return UserModel(
        uid: userCredential.user!.uid,
        email: userCredential.user!.email,
        displayName: userCredential.user!.displayName,
      );
    } catch (e) {
      print("Google sign-in error: $e");
      return null;
    }
  }

  /// Signs out the current user from both Firebase and Google.
  Future<void> signOut() async {
    await _auth.signOut();
    await _googleSignIn.signOut();
  }
}

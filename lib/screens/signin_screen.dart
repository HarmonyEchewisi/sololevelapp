import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../services/auth.dart';

/// The sign-in screen for the application.
///
/// Allows users to sign in using Google authentication.
/// On successful sign-in, navigates to the home screen.
class SignInScreen extends StatelessWidget {
  const SignInScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Obtain the AuthService from the provider (no need to listen for changes here)
    final authService = Provider.of<AuthService>(context, listen: false);

    return Scaffold(
      backgroundColor: Colors.black,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // App title
            const Text(
              "Level Up: Solo Fitness",
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            const SizedBox(height: 20),
            // Google sign-in button
            ElevatedButton(
              onPressed: () async {
                // Attempt Google sign-in
                await authService.signInWithGoogle();
                // If the widget is still in the tree, navigate to home
                if (context.mounted) {
                  Navigator.pushReplacementNamed(context, '/home');
                }
              },
              child: const Text("Sign in with Google"),
            ),
          ],
        ),
      ),
    );
  }
}

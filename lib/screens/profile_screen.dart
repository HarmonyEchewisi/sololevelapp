import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/user_model.dart';
import '../services/auth.dart';

/// The profile screen displays user information and provides sign-out functionality.
///
/// Shows the user's avatar, name, and email. Allows navigation back to home or signing out.
class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Obtain the AuthService for sign-out functionality
    final authService = Provider.of<AuthService>(context, listen: false);
    // Obtain the current user from the provider
    final user = Provider.of<UserModel?>(context);

    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(title: const Text("Profile")),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // User avatar (uses displayName as a network image if available)
            CircleAvatar(
              radius: 50,
              backgroundImage:
                  user?.displayName != null
                      ? NetworkImage(user!.displayName!)
                      : null,
              child:
                  user?.displayName == null
                      ? const Icon(Icons.person, size: 50, color: Colors.white)
                      : null,
            ),
            const SizedBox(height: 10),
            // User name
            Text(
              user?.displayName ?? "User",
              style: const TextStyle(fontSize: 20, color: Colors.white),
            ),
            // User email
            Text(
              user?.email ?? "",
              style: const TextStyle(fontSize: 16, color: Colors.grey),
            ),

            const SizedBox(height: 20),

            // Button to return to the home screen
            ElevatedButton(
              onPressed: () {
                Navigator.pushReplacementNamed(context, '/home');
              },
              child: const Text("Back to Home"),
            ),

            const SizedBox(height: 20),

            // Sign Out Button
            TextButton(
              onPressed: () async {
                await authService.signOut();
                if (context.mounted) {
                  Navigator.pushReplacementNamed(context, '/signin');
                }
              },
              child: const Text(
                "Sign Out",
                style: TextStyle(color: Colors.redAccent, fontSize: 16),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

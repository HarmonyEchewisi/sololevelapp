import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/user_model.dart';
import '../widgets/bottom_navigation.dart'; // ✅ Import Fix

/// The login (or home) screen displaying user profile information and navigation.
///
/// Shows the user's avatar, name, and level, and includes the bottom navigation bar.
class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Retrieve the current user from the provider.
    final user = Provider.of<UserModel?>(context);

    return Scaffold(
      backgroundColor: Colors.black,
      body: Column(
        children: [
          const SizedBox(height: 50),
          // User Info & Profile section
          Center(
            child: Column(
              children: [
                // User avatar (uses displayName as a network image if available)
                CircleAvatar(
                  radius: 50,
                  backgroundImage:
                      user?.displayName != null
                          ? NetworkImage(user!.displayName!)
                          : const AssetImage("assets/default_avatar.png")
                              as ImageProvider,
                ),
                const SizedBox(height: 10),
                // User name
                Text(
                  user?.displayName ?? "Unknown User",
                  style: const TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                // User level
                Text(
                  "Level ${user?.level ?? 1}",
                  style: const TextStyle(fontSize: 18, color: Colors.grey),
                ),
              ],
            ),
          ),
          const Spacer(),
          // Bottom Navigation Bar, with Home selected
          const BottomNavigation(selectedIndex: 0),
        ],
      ),
    );
  }
}

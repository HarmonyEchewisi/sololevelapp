import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/user_model.dart';
import '../widgets/bottom_navigation.dart';
import '../widgets/progress_bar.dart';

/// The main landing screen of the application.
///
/// Displays user profile information, XP progress, an anime character image,
/// and the bottom navigation bar. Uses [UserModel] from Provider for user data.
class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Retrieve the current user from the provider.
    final user = Provider.of<UserModel?>(context);

    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        children: [
          // Background gradient animation (placeholder for future animated effect)
          Positioned.fill(
            child: Container(
              decoration: BoxDecoration(
                gradient: RadialGradient(
                  colors: [Colors.blueAccent.withOpacity(0.2), Colors.black],
                  center: Alignment.topCenter,
                  radius: 1.5,
                ),
              ),
            ),
          ),

          Column(
            children: [
              const SizedBox(height: 50),

              // User profile section
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CircleAvatar(
                    radius: 40,
                    // If user has a displayName, use it as a network image (profile picture),
                    // otherwise use a default local asset.
                    backgroundImage:
                        user?.displayName != null
                            ? NetworkImage(user!.displayName!)
                            : const AssetImage("assets/default_avatar.png")
                                as ImageProvider,
                  ),
                  const SizedBox(width: 15),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Display user's name or a fallback
                      Text(
                        user?.displayName ?? "Unknown User",
                        style: const TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                      // Display user's level or default to 1
                      Text(
                        "Level ${user?.level ?? 1}",
                        style: const TextStyle(
                          fontSize: 18,
                          color: Colors.grey,
                        ),
                      ),
                    ],
                  ),
                ],
              ),

              const SizedBox(height: 20),

              // XP Progress Bar
              ProgressBar(currentXP: user?.xp ?? 0),

              const SizedBox(height: 20),

              // Anime character image (replace with your own asset as needed)
              Expanded(
                child: Image.asset(
                  "assets/hero_character.png",
                  fit: BoxFit.contain,
                ),
              ),

              // Bottom navigation bar, with Home selected
              const BottomNavigation(selectedIndex: 0),
            ],
          ),
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/user_model.dart';
import '../widgets/progress_bar.dart';

/// Screen that displays the user's current level and XP progress.
///
/// Shows a progress bar and level information. If user data is not available, shows a loading indicator.
class ProgressScreen extends StatelessWidget {
  const ProgressScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Retrieve the current user from the provider.
    final user = Provider.of<UserModel?>(context);

    // Show a loading indicator if user data is not yet available.
    if (user == null) {
      return const Center(child: CircularProgressIndicator());
    }

    return Scaffold(
      appBar: AppBar(title: const Text("Progress Tracker")),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Display user's current level
            Text("Level: ${user.level}", style: const TextStyle(fontSize: 24)),
            const SizedBox(height: 20),
            // Display XP progress bar
            ProgressBar(currentXP: user.xp),
          ],
        ),
      ),
    );
  }
}

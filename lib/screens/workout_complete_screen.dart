import 'package:flutter/material.dart';

/// Screen displayed when the user completes a workout session.
///
/// Shows a congratulatory message and provides a button to return to the home screen.
class WorkoutCompleteScreen extends StatelessWidget {
  /// The user's unique identifier.
  final String userId;

  const WorkoutCompleteScreen({required this.userId, super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Workout Completed!")),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Congratulatory message
            const Text(
              "🎉 Congratulations! You leveled up!",
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            // Button to return to the home screen
            ElevatedButton(
              onPressed: () {
                Navigator.popUntil(context, ModalRoute.withName('/'));
              },
              child: const Text("Back to Home"),
            ),
          ],
        ),
      ),
    );
  }
}

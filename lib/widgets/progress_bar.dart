import 'package:flutter/material.dart';

/// A widget that displays the user's XP progress towards the next level.
///
/// Shows a linear progress bar and the current XP out of 100.
class ProgressBar extends StatelessWidget {
  /// The user's current XP value.
  final int currentXP;

  const ProgressBar({required this.currentXP, super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Linear progress bar showing progress towards next level (out of 100 XP)
        LinearProgressIndicator(
          value: (currentXP % 100) / 100.0,
          backgroundColor: Colors.white,
          color: Colors.blueAccent,
        ),
        const SizedBox(height: 10),
        // XP text display
        Text("XP: $currentXP / 100", style: const TextStyle(fontSize: 18)),
      ],
    );
  }
}

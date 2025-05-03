import 'package:flutter/material.dart';

/// A card widget that displays a workout's name and XP reward.
///
/// Tapping the card triggers the [onTap] callback.
class WorkoutCard extends StatelessWidget {
  /// The name of the workout.
  final String workoutName;

  /// The XP reward for completing the workout.
  final int xp;

  /// Callback when the card is tapped.
  final VoidCallback onTap;

  const WorkoutCard({
    required this.workoutName,
    required this.xp,
    required this.onTap,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        title: Text(workoutName),
        subtitle: Text("XP: $xp"),
        trailing: const Icon(Icons.fitness_center),
        onTap: onTap,
      ),
    );
  }
}

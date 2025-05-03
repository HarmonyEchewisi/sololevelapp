import 'package:flutter/material.dart';
import '../models/workout_model.dart';

/// Displays the details of a selected workout, including warm-up, main workout, and cool-down sections.
///
/// Allows the user to start the workout, which navigates to the countdown screen.
class WorkoutScreen extends StatelessWidget {
  /// The user's unique identifier.
  final String userId;

  /// The workout to be displayed.
  final WorkoutModel workout;

  const WorkoutScreen({required this.userId, required this.workout, super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(workout.day)),
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Workout goal/description
            Text(
              workout.goal,
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            // Workout sections: warm-up, main, cool-down
            _buildWorkoutSection("Warm-up", workout.warmup),
            _buildWorkoutSection("Main Workout", workout.mainWorkout),
            _buildWorkoutSection("Cool-down", workout.cooldown),
            const SizedBox(height: 20),
            // Start Workout Button
            Center(
              child: ElevatedButton(
                onPressed: () {
                  Navigator.pushNamed(
                    context,
                    '/countdown',
                    arguments: {
                      'userId': userId, // Pass userId to the next screen
                      'workout':
                          workout
                              .toMap(), // Convert workout to Map for navigation
                    },
                  );
                },
                child: const Text("Start Workout"),
              ),
            ),
          ],
        ),
      ),
    );
  }

  /// Builds a section of the workout (e.g., warm-up, main, cool-down).
  Widget _buildWorkoutSection(String title, List<String> items) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        ...items.map(
          (exercise) => Padding(
            padding: const EdgeInsets.only(left: 10, top: 5),
            child: Text("- $exercise"),
          ),
        ),
        const SizedBox(height: 10),
      ],
    );
  }
}

import 'package:flutter/material.dart';
import '../models/workout_model.dart';
import '../services/database.dart';

/// Screen that guides the user through the exercises of a workout session.
///
/// Handles exercise progression, rest periods, and marks the workout as complete.
class ExerciseScreen extends StatefulWidget {
  /// The user's unique identifier.
  final String userId;

  /// The workout to be performed.
  final WorkoutModel workout;

  const ExerciseScreen({
    required this.userId,
    required this.workout,
    super.key,
  });

  @override
  _ExerciseScreenState createState() => _ExerciseScreenState();
}

class _ExerciseScreenState extends State<ExerciseScreen> {
  int _currentExerciseIndex = 0; // Tracks the current exercise in the workout
  bool _isResting = false; // Indicates if the user is in a rest period
  final DatabaseService _dbService = DatabaseService();

  /// Advances to the next exercise or completes the workout if finished.
  void _nextExercise() {
    if (_currentExerciseIndex < widget.workout.mainWorkout.length - 1) {
      setState(() {
        _isResting = true;
      });

      // Simulate a rest period before the next exercise
      Future.delayed(const Duration(seconds: 4), () {
        setState(() {
          _currentExerciseIndex++;
          _isResting = false;
        });
      });
    } else {
      _completeWorkout();
    }
  }

  /// Marks the workout as complete and updates the user's XP.
  void _completeWorkout() async {
    await _dbService.updateXP(widget.userId, 100);
    await _dbService.markWorkoutCompleted(widget.userId, widget.workout.day);

    if (mounted) {
      Navigator.pushReplacementNamed(
        context,
        '/workout_complete',
        arguments: {'userId': widget.userId},
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    // Get the current exercise from the workout
    final currentExercise = widget.workout.mainWorkout[_currentExerciseIndex];

    return Scaffold(
      appBar: AppBar(title: Text(widget.workout.day)),
      body: Center(
        child:
            _isResting
                // Show rest message during rest period
                ? const Text(
                  "Resting (1m 30s)...",
                  style: TextStyle(fontSize: 24, color: Colors.red),
                )
                // Show current exercise and "Done" button
                : Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      currentExercise,
                      style: const TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 20),
                    ElevatedButton(
                      onPressed: _nextExercise,
                      child: const Text("Done"),
                    ),
                  ],
                ),
      ),
    );
  }
}

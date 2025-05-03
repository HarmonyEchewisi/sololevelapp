import 'package:flutter/material.dart';
import '../models/workout_model.dart';
import '../services/database.dart';
import 'workout_complete_screen.dart';

/// Screen that guides the user through a full workout session,
/// including warm-up, main workout, and cool-down phases.
///
/// Handles exercise progression, rest periods, and marks the workout as complete.
class WorkoutSessionScreen extends StatefulWidget {
  /// The user's unique identifier.
  final String userId;

  /// The workout to be performed.
  final WorkoutModel workout;

  const WorkoutSessionScreen({
    required this.userId,
    required this.workout,
    super.key,
  });

  @override
  _WorkoutSessionScreenState createState() => _WorkoutSessionScreenState();
}

class _WorkoutSessionScreenState extends State<WorkoutSessionScreen> {
  int _currentExerciseIndex = 0; // Tracks the current exercise in the phase
  bool _isResting = false; // Indicates if the user is in a rest period
  bool _isWarmup = true; // Indicates if the user is in the warm-up phase
  bool _isCooldown = false; // Indicates if the user is in the cool-down phase
  final DatabaseService _dbService = DatabaseService();

  /// Advances to the next exercise or phase, or completes the workout if finished.
  void _nextExercise() {
    setState(() {
      if (_isWarmup) {
        // Progress through warm-up exercises
        if (_currentExerciseIndex < widget.workout.warmup.length - 1) {
          _currentExerciseIndex++;
        } else {
          _isWarmup = false;
          _currentExerciseIndex = 0;
        }
      } else if (!_isCooldown) {
        // Progress through main workout exercises with rest between them
        if (_currentExerciseIndex < widget.workout.mainWorkout.length - 1) {
          _isResting = true;
          Future.delayed(const Duration(seconds: 90), () {
            setState(() {
              _currentExerciseIndex++;
              _isResting = false;
            });
          });
        } else {
          _isCooldown = true;
          _currentExerciseIndex = 0;
        }
      } else {
        // Complete the workout after cool-down
        _completeWorkout();
      }
    });
  }

  /// Marks the workout as complete and updates the user's XP.
  void _completeWorkout() async {
    await _dbService.updateXP(widget.userId, 100);
    await _dbService.markWorkoutCompleted(widget.userId, widget.workout.day);

    if (mounted) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => WorkoutCompleteScreen(userId: widget.userId),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    // Determine the current exercise based on the phase
    final String currentExercise =
        _isWarmup
            ? widget.workout.warmup[_currentExerciseIndex]
            : _isCooldown
            ? widget.workout.cooldown[_currentExerciseIndex]
            : widget.workout.mainWorkout[_currentExerciseIndex];

    return Scaffold(
      appBar: AppBar(title: Text(widget.workout.day)),
      body: Center(
        child:
            _isResting
                // Show rest message during rest period
                ? const Text(
                  "Resting... (1 min 30 sec)",
                  style: TextStyle(fontSize: 24, color: Colors.red),
                )
                // Show current exercise and "Done" button
                : Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      _isWarmup
                          ? "Warm-Up: $currentExercise"
                          : _isCooldown
                          ? "Cool-Down: $currentExercise"
                          : currentExercise,
                      style: const TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                      textAlign: TextAlign.center,
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

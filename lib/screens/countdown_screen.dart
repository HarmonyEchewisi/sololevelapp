import 'package:flutter/material.dart';
import 'dart:async';
import '../models/workout_model.dart';

/// A screen that displays a countdown before starting the workout session.
///
/// After the countdown, navigates to the exercise screen and passes the user and workout data.
class CountdownScreen extends StatefulWidget {
  /// The user's unique identifier.
  final String userId;

  /// The workout to be performed.
  final WorkoutModel workout;

  const CountdownScreen({
    required this.userId,
    required this.workout,
    super.key,
  });

  @override
  _CountdownScreenState createState() => _CountdownScreenState();
}

class _CountdownScreenState extends State<CountdownScreen> {
  int _countdown = 4; // 4-second countdown
  late Timer _timer;

  @override
  void initState() {
    super.initState();
    _startCountdown();
  }

  /// Starts the countdown timer and navigates to the exercise screen when finished.
  void _startCountdown() {
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_countdown == 1) {
        _timer.cancel();
        Navigator.pushReplacementNamed(
          context,
          '/exercise_screen',
          arguments: {
            'userId': widget.userId, // Pass userId to the next screen
            'workout':
                widget.workout.toMap(), // Convert workout to Map for navigation
          },
        );
      } else {
        setState(() {
          _countdown--;
        });
      }
    });
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Center(
        child: Text(
          '$_countdown',
          style: const TextStyle(
            fontSize: 80,
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}

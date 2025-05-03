import 'package:flutter/material.dart';
import '../models/workout_model.dart';
import '../widgets/bottom_navigation.dart';
import 'dart:math';

/// The Gates screen presents a randomly selected workout from a predefined list.
///
/// Allows users to view the workout details and start the workout session.
/// The randomization simulates a "challenge" or "gate" for the user.
class GatesScreen extends StatelessWidget {
  const GatesScreen({super.key});

  /// Generates a random [WorkoutModel] from the provided [trainingPlan] list.
  WorkoutModel getRandomWorkout(List<WorkoutModel> trainingPlan) {
    final random = Random();
    return trainingPlan[random.nextInt(trainingPlan.length)];
  }

  @override
  Widget build(BuildContext context) {
    // Predefined list of possible workouts for the Gates challenge
    final List<WorkoutModel> trainingPlan = [
      WorkoutModel(
        day: "Day 1 – Strength & Power",
        goal: "Build absolute strength & explosive leg power",
        warmup: [
          "Joint mobility drills",
          "Dynamic stretching",
          "Sprint mechanics drills",
        ],
        mainWorkout: [
          "Squats – 5×5",
          "Romanian Deadlifts – 4×8",
          "Bulgarian Split Squats – 3×8/leg",
        ],
        cooldown: ["Stretching", "Deep breathing"],
      ),
      WorkoutModel(
        day: "Day 2 – Speed & Agility",
        goal: "Maximize sprint speed & agility for combat movement",
        warmup: ["Agility ladder drills", "Joint mobility work"],
        mainWorkout: [
          "5×30m sprints",
          "3×60m resisted sprints",
          "T-Drill – 3 reps",
        ],
        cooldown: ["Mobility work", "Stretching"],
      ),
    ];

    // Select a random workout for this session
    final randomWorkout = getRandomWorkout(trainingPlan);

    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: const Text("Gates - Random Workout"),
        backgroundColor: Colors.black,
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Workout day and goal
            Text(
              randomWorkout.day,
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            const SizedBox(height: 10),
            Text(
              randomWorkout.goal,
              style: const TextStyle(fontSize: 16, color: Colors.grey),
            ),
            const SizedBox(height: 20),
            // Workout sections: warm-up, main, cool-down
            _buildWorkoutSection("Warm-up", randomWorkout.warmup),
            _buildWorkoutSection("Main Workout", randomWorkout.mainWorkout),
            _buildWorkoutSection("Cool-down", randomWorkout.cooldown),
            const SizedBox(height: 20),
            // Button to start the workout (navigates to countdown)
            Center(
              child: ElevatedButton(
                onPressed: () {
                  Navigator.pushNamed(
                    context,
                    '/countdown',
                    arguments: {
                      'userId':
                          "dummyUser", // Replace with actual user ID in production
                      'workout': randomWorkout.toMap(),
                    },
                  );
                },
                child: const Text("Start Workout"),
              ),
            ),
          ],
        ),
      ),
      // Highlight the Gates tab in the bottom navigation bar
      bottomNavigationBar: const BottomNavigation(selectedIndex: 2),
    );
  }

  /// Builds a section of the workout (e.g., warm-up, main, cool-down).
  Widget _buildWorkoutSection(String title, List<String> items) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        ...items.map(
          (exercise) => Padding(
            padding: const EdgeInsets.only(left: 10, top: 5),
            child: Text(
              "- $exercise",
              style: const TextStyle(color: Colors.grey),
            ),
          ),
        ),
        const SizedBox(height: 10),
      ],
    );
  }
}

import 'package:flutter/material.dart';
import '../models/workout_model.dart';
import '../widgets/bottom_navigation.dart'; // ✅ Import Bottom Navigation

/// The Training Plan screen displays a list of structured workouts for the user.
///
/// Each workout is shown as a card. Tapping a card navigates to the detailed workout screen.
/// The bottom navigation highlights the Training Plan tab.
class TrainingPlanScreen extends StatelessWidget {
  /// The user's unique identifier.
  final String userId;

  TrainingPlanScreen({required this.userId, super.key});

  /// The full weekly training plan, each entry is a [WorkoutModel].
  final List<WorkoutModel> trainingPlan = [
    WorkoutModel(
      day: "Day 1 – Strength & Power (Lower Body Focus)",
      goal: "Build absolute strength & explosive leg power",
      warmup: [
        "Joint mobility drills",
        "Dynamic stretching",
        "Sprint mechanics drills (A/B skips, high knees)",
      ],
      mainWorkout: [
        "Squats – 5×5 (80–90% 1RM)",
        "Romanian Deadlifts – 4×8",
        "Bulgarian Split Squats – 3×8/leg",
        "Box Jumps – 4×5 (increase height weekly)",
        "Weighted Sled Push – 5×20m (or hill sprints if at home)",
      ],
      cooldown: ["Stretching", "Deep breathing"],
    ),
    WorkoutModel(
      day: "Day 2 – Speed & Agility",
      goal: "Maximize sprint speed & agility for combat movement",
      warmup: [
        "Agility ladder drills (high knees, lateral quick steps)",
        "Joint mobility work",
      ],
      mainWorkout: [
        "5×30m sprints (full effort, full recovery)",
        "3×60m resisted sprints (weighted sled or uphill sprints)",
        "5-10-5 Pro Agility Shuttle – 4 reps",
        "T-Drill – 3 reps",
        "Broad Jumps – 3×5",
        "Depth Jumps – 3×5",
      ],
      cooldown: ["Mobility work", "Stretching"],
    ),
    WorkoutModel(
      day: "Day 3 – Combat-Specific Strength & Endurance",
      goal: "Apply strength & endurance to real combat movements",
      warmup: ["Shadowboxing (3 rounds, 2 min)", "Dynamic mobility drills"],
      mainWorkout: [
        "Heavy Sandbag Shouldering – 4×6/side",
        "Battle Rope Slams – 3×30 sec",
        "Med Ball Rotational Slams – 3×10/side",
        "1 min Heavy Bag Punch/Kick Combos",
        "15 Jump Squats",
        "10 Burpees",
        "30-sec Plank",
      ],
      cooldown: ["Stretching & Relaxation"],
    ),
    WorkoutModel(
      day: "Day 4 – Strength & Power (Upper Body Focus)",
      goal: "Maximize pushing/pulling power & upper-body explosiveness",
      warmup: ["Mobility work", "Banded shoulder activation"],
      mainWorkout: [
        "Bench Press – 5×5 (80–90% 1RM)",
        "Weighted Pull-Ups – 4×6",
        "Overhead Press – 4×6",
        "Medicine Ball Chest Throws – 3×8",
        "Plyometric Push-Ups – 3×10",
      ],
      cooldown: ["Static stretching", "Foam rolling"],
    ),
    WorkoutModel(
      day: "Day 5 – Speed & Agility",
      goal: "Peak sprinting mechanics & agility under combat conditions",
      warmup: ["Reaction drills", "Light sprint drills"],
      mainWorkout: [
        "Flying Sprints – 5×40m (Gradual buildup, then max sprint)",
        "Overspeed Sprinting – 3×30m (Downhill or assisted run)",
        "Lateral Cone Shuffle – 3×15 sec",
        "Mirror Drill (With Partner or App) – 3×15 sec",
        "Partner Reactive Striking (Glove Touch & React) – 5 rounds",
        "Evasion Drills (Duck, Slip, Step Off Center) – 5 rounds",
      ],
      cooldown: ["Light mobility work", "Stretching"],
    ),
    WorkoutModel(
      day: "Day 6 – Combat-Specific Endurance & Functional Strength",
      goal: "Develop stamina & functional fight power",
      warmup: ["Jump rope", "Mobility work"],
      mainWorkout: [
        "Heavy Bag Power Strikes – 3×3 min Rounds (30 sec rest)",
        "Fast Light Strikes – 3×3 min",
        "Combo Chains (Hooks, Kicks, Takedowns) – 3×3 min",
        "Bear Crawl – 15m",
        "Medicine Ball Slams – 3×12",
        "Bulgarian Bag Swings – 3×15",
        "Sprawls – 10 reps",
      ],
      cooldown: ["Foam rolling", "Deep breathing"],
    ),
    WorkoutModel(
      day: "Day 7 – Recovery & Mobility",
      goal: "Active recovery, mobility work, and full recovery",
      warmup: ["Light jogging / Swimming – 20 min"],
      mainWorkout: [
        "Full-body mobility & stretching routine – 30 min",
        "Foam rolling & massage work",
        "10 min Deep Breathing & Relaxation Techniques",
      ],
      cooldown: ["Yoga", "Mindfulness Meditation"],
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black, // ✅ Background color fixed
      appBar: AppBar(
        title: const Text("Training Plan"),
        backgroundColor: Colors.black,
        elevation: 0,
      ),
      body: ListView.builder(
        itemCount: trainingPlan.length,
        itemBuilder: (context, index) {
          final workout = trainingPlan[index];

          // Each workout is displayed as a tappable card
          return GestureDetector(
            onTap: () {
              // Navigate to the workout screen, passing userId and workout details
              Navigator.pushNamed(
                context,
                '/workout',
                arguments: {'userId': userId, 'workout': workout.toMap()},
              );
            },
            child: Card(
              color: Colors.grey[900],
              margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              child: Padding(
                padding: const EdgeInsets.all(15),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Workout day title
                    Text(
                      workout.day,
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(height: 5),
                    // Workout goal/description
                    Text(
                      workout.goal,
                      style: const TextStyle(fontSize: 14, color: Colors.grey),
                    ),
                    const SizedBox(height: 10),
                    // "Tap to View" prompt and arrow icon
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Tap to View",
                          style: const TextStyle(
                            fontSize: 12,
                            color: Colors.blueAccent,
                          ),
                        ),
                        const Icon(
                          Icons.arrow_forward,
                          color: Colors.blueAccent,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
      bottomNavigationBar: const BottomNavigation(
        selectedIndex: 1,
      ), // ✅ Ensure Training Plan is selected
    );
  }
}

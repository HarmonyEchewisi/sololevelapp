import '../models/workout_model.dart';

/// A list of [WorkoutModel] objects representing a default weekly training plan.
///
/// Each entry contains the day, goal, warm-up, main workout, and cool-down exercises.
/// This can be used throughout the app for sample data, onboarding, or as a template.
final List<WorkoutModel> trainingPlan = [
  WorkoutModel(
    day: "Day 1 – Strength & Power",
    goal: "Build maximum strength and explosive power",
    warmup: ["Jump rope – 3 min", "Dynamic stretches", "Mobility drills"],
    mainWorkout: [
      "Deadlifts or Squats – 4x5 (heavy)",
      "Overhead Press – 4x6",
      "Pull-ups (weighted if possible) – 4x5",
      "Box Jumps – 3x10",
      "Sprints (30m) – 6 rounds",
    ],
    cooldown: ["Static stretching", "Deep breathing"],
  ),
  WorkoutModel(
    day: "Day 2 – Endurance & Stamina",
    goal: "Build cardiovascular fitness and muscular endurance",
    warmup: ["Jump rope – 3 min", "Mobility work", "Light jogging"],
    mainWorkout: [
      "Long-Distance Run (5–8 km at moderate pace) OR HIIT Circuit",
      "Burpees – 15 reps",
      "Jump squats – 20 reps",
      "Mountain climbers – 40 reps",
      "Push-ups – 25 reps",
    ],
    cooldown: ["Deep stretching"],
  ),
  WorkoutModel(
    day: "Day 3 – Agility & Explosiveness",
    goal: "Increase speed, reflexes, and power output",
    warmup: ["Agility ladder drills", "Mobility & dynamic stretching"],
    mainWorkout: [
      "50m sprints (8 rounds, 30s rest)",
      "Box Jumps – 3x12",
      "Depth Jumps – 3x10",
      "Burpees – 3x15",
    ],
    cooldown: ["Mobility work", "Stretching"],
  ),
  WorkoutModel(
    day: "Day 4 – Strength & Hypertrophy",
    goal: "Increase muscle size and raw strength",
    warmup: ["Mobility drills", "Dynamic stretching"],
    mainWorkout: [
      "Pull-ups – 4x6",
      "Push-ups – 4x25",
      "Squats – 4x20",
      "Dips – 4x15",
      "Deadlifts – 4x5",
      "Bench Press – 4x6",
    ],
    cooldown: ["Deep stretching"],
  ),
  WorkoutModel(
    day: "Day 5 – Endurance & Mobility",
    goal: "Improve cardiovascular endurance, flexibility, and mobility",
    warmup: [
      "Jump Rope (20 min, alternating speeds)",
      "Yoga & Mobility Routine",
    ],
    mainWorkout: [
      "Long-Distance Run (6-10 km at steady pace)",
      "Bicycle Crunches – 20 reps",
      "Plank Variations – 2 min",
    ],
    cooldown: ["Full-body mobility & stretching"],
  ),
  WorkoutModel(
    day: "Day 6 – Combat & Functional Strength",
    goal: "Improve functional strength, endurance, and combat ability",
    warmup: ["Shadowboxing / Bag Work (5 rounds, 3 min each, 30s rest)"],
    mainWorkout: [
      "Pull-ups – 8 reps",
      "Push-ups – 25 reps",
      "Jump Squats – 20 reps",
      "Plank – 60 sec",
    ],
    cooldown: ["Cool-down stretches"],
  ),
  WorkoutModel(
    day: "Day 7 – Active Recovery",
    goal: "Recovery, mobility, and flexibility work",
    warmup: ["Light Jog / Walk (20 min)"],
    mainWorkout: [
      "Full-body Mobility & Stretching (30 min)",
      "Breathwork / Meditation (10 min)",
    ],
    cooldown: ["Deep relaxation"],
  ),
];

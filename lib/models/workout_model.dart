/// Data model representing a workout, including day, goal, and exercise lists.
class WorkoutModel {
  /// The name or label for the workout day.
  final String day;

  /// The goal or focus of the workout.
  final String goal;

  /// List of warm-up exercises.
  final List<String> warmup;

  /// List of main workout exercises.
  final List<String> mainWorkout;

  /// List of cool-down exercises.
  final List<String> cooldown;

  WorkoutModel({
    required this.day,
    required this.goal,
    required this.warmup,
    required this.mainWorkout,
    required this.cooldown,
  });

  /// Creates a [WorkoutModel] from a [Map] (e.g., from Firestore or navigation).
  factory WorkoutModel.fromMap(Map<String, dynamic> data) {
    return WorkoutModel(
      day: data['day'] ?? 'Unknown Day',
      goal: data['goal'] ?? 'No goal specified',
      warmup: List<String>.from(data['warmup'] ?? []),
      mainWorkout: List<String>.from(data['mainWorkout'] ?? []),
      cooldown: List<String>.from(data['cooldown'] ?? []),
    );
  }

  /// Converts this [WorkoutModel] to a [Map] (e.g., for Firestore or navigation).
  Map<String, dynamic> toMap() {
    return {
      'day': day,
      'goal': goal,
      'warmup': warmup,
      'mainWorkout': mainWorkout,
      'cooldown': cooldown,
    };
  }
}

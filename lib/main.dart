import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'firebase_options.dart';
import 'models/user_model.dart';
import 'models/workout_model.dart';
import 'screens/home_screen.dart';
import 'screens/workout_screen.dart';
import 'screens/training_plan_screen.dart';
import 'screens/countdown_screen.dart';
import 'screens/exercise_screen.dart';
import 'screens/workout_complete_screen.dart';
import 'screens/signin_screen.dart';
import 'screens/gates_screen.dart';
import 'screens/profile_screen.dart';
import 'services/auth.dart';
import 'package:model_viewer_plus/model_viewer_plus.dart';

/// The main entry point of the application.
/// Initializes Firebase and checks if the user is already signed in.
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  // Check if user is already signed in
  final User? user = FirebaseAuth.instance.currentUser;
  runApp(MyApp(isSignedIn: user != null));
}

/// The root widget of the application.
/// Sets up providers and configures the app's theme and routes.
class MyApp extends StatelessWidget {
  /// Indicates whether the user is already signed in.
  final bool isSignedIn;

  const MyApp({super.key, required this.isSignedIn});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        // Provides authentication service throughout the app
        Provider<AuthService>(create: (_) => AuthService()),
        // Provides a stream of the current user model
        StreamProvider<UserModel?>(
          create: (context) => context.read<AuthService>().userStream,
          initialData: null,
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Level Up: Solo Fitness',
        theme: ThemeData.dark().copyWith(
          scaffoldBackgroundColor: Colors.black,
          colorScheme: const ColorScheme.dark(
            primary: Colors.blueAccent,
            secondary: Colors.deepPurpleAccent,
          ),
          textTheme: GoogleFonts.orbitronTextTheme(Theme.of(context).textTheme),
        ),
        // Automatically navigate to home if signed in, otherwise to sign in
        initialRoute: isSignedIn ? '/home' : '/signin',
        routes: {
          '/signin': (context) => const SignInScreen(),
          '/home': (context) => const HomeScreen(),
          '/training_plan': (context) {
            // Expects 'userId' in arguments
            final args =
                ModalRoute.of(context)?.settings.arguments
                    as Map<String, dynamic>?;

            return args != null && args.containsKey('userId')
                ? TrainingPlanScreen(userId: args['userId'])
                : const HomeScreen(); // Prevents crashes if no userId
          },
          '/gates': (context) => const GatesScreen(),
          '/profile': (context) => const ProfileScreen(),
          '/workout': (context) {
            // Expects 'userId' and 'workout' in arguments
            final args =
                ModalRoute.of(context)?.settings.arguments
                    as Map<String, dynamic>?;

            return args != null &&
                    args.containsKey('userId') &&
                    args.containsKey('workout')
                ? WorkoutScreen(
                  userId: args['userId'],
                  workout: WorkoutModel.fromMap(args['workout']),
                )
                : const HomeScreen();
          },
          '/countdown': (context) {
            // Expects 'userId' and 'workout' in arguments
            final args =
                ModalRoute.of(context)?.settings.arguments
                    as Map<String, dynamic>?;

            return args != null &&
                    args.containsKey('userId') &&
                    args.containsKey('workout')
                ? CountdownScreen(
                  userId: args['userId'],
                  workout: WorkoutModel.fromMap(args['workout']),
                )
                : const HomeScreen();
          },
          '/exercise_screen': (context) {
            // Expects 'userId' and 'workout' in arguments
            final args =
                ModalRoute.of(context)?.settings.arguments
                    as Map<String, dynamic>?;

            return args != null &&
                    args.containsKey('userId') &&
                    args.containsKey('workout')
                ? ExerciseScreen(
                  userId: args['userId'],
                  workout: WorkoutModel.fromMap(args['workout']),
                )
                : const HomeScreen();
          },
          '/workout_complete': (context) {
            // Expects 'userId' in arguments
            final args =
                ModalRoute.of(context)?.settings.arguments
                    as Map<String, dynamic>?;

            return args != null && args.containsKey('userId')
                ? WorkoutCompleteScreen(userId: args['userId'])
                : const HomeScreen();
          },
        },
      ),
    );
  }
}

/// A placeholder home screen displaying a 3D model.
/// This can be replaced with the actual home screen implementation.
class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SizedBox(
          width: 300,
          height: 300,
          child: ModelViewer(
            src: 'assets/free_male_body_low_poly_fre.glb',
            alt: "A 3D character",
            ar: false,
            autoRotate: false,
            cameraControls: true,
            backgroundColor: Colors.transparent,
          ),
        ),
      ),
    );
  }
}

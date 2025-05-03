import 'package:flutter_test/flutter_test.dart';
import 'package:sololevelapp/main.dart';
import 'package:flutter/material.dart';
import 'package:model_viewer_plus/model_viewer_plus.dart';

void main() {
  testWidgets('App launches correctly', (WidgetTester tester) async {
    // Build the app with isSignedIn set to false for testing.
    await tester.pumpWidget(const MyApp(isSignedIn: false));

    // Verify that the sign-in screen or home screen title is displayed.
    expect(find.text('Level Up: Solo Fitness'), findsOneWidget);
  });
}

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SizedBox(
          width: 300,
          height: 300,
          child: ModelViewer(
            src: 'assets/your_model.glb',
            alt: "A 3D character",
            ar: false,
            autoRotate: false,
            cameraControls: true, // Enables user interaction
            backgroundColor: Colors.transparent,
          ),
        ),
      ),
    );
  }
}

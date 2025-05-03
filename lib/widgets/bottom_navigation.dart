import 'package:flutter/material.dart';

/// A reusable bottom navigation bar for the app.
///
/// Navigates between Home, Training Plan, Gates, and Profile screens.
/// The [selectedIndex] determines which tab is highlighted.
class BottomNavigation extends StatelessWidget {
  /// The index of the currently selected tab.
  final int selectedIndex;

  const BottomNavigation({super.key, required this.selectedIndex});

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      currentIndex: selectedIndex,
      onTap: (index) {
        switch (index) {
          case 0:
            // Navigate to Home
            Navigator.pushReplacementNamed(context, '/home');
            break;
          case 1:
            // Navigate to Training Plan (replace with actual userId in production)
            Navigator.pushReplacementNamed(
              context,
              '/training_plan',
              arguments: {'userId': "dummyUserId"},
            );
            break;
          case 2:
            // Navigate to Gates
            Navigator.pushReplacementNamed(context, '/gates');
            break;
          case 3:
            // Navigate to Profile
            Navigator.pushReplacementNamed(context, '/profile');
            break;
        }
      },
      selectedItemColor: Colors.blueAccent,
      unselectedItemColor: Colors.grey,
      showSelectedLabels: false,
      showUnselectedLabels: false,
      items: const [
        BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Hero'),
        BottomNavigationBarItem(
          icon: Icon(Icons.fitness_center),
          label: 'Training Plan',
        ),
        BottomNavigationBarItem(icon: Icon(Icons.bolt), label: 'Gates'),
        BottomNavigationBarItem(
          icon: Icon(Icons.account_circle),
          label: 'Profile',
        ),
      ],
    );
  }
}

import 'package:flutter/material.dart';
import '../../widgets/scaffold_with_nav.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ScaffoldWithNav(
      initialIndex: 0, // Home tab is selected
      body: const Center(
        child: Text(
          "Welcome to SkillBox! 🎉",
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}

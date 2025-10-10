import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:skillbox/providers/user_provider.dart';
import 'package:skillbox/widgets/scaffold_with_nav.dart'; // import your nav widget

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserProvider>(context).user;

    return ScaffoldWithNav(
      body: Center(
        child: Text(
          "Welcome ${user?.fullName ?? 'Guest'}\nEmail: ${user?.email ?? '-'}",
          textAlign: TextAlign.center,
          style: const TextStyle(fontSize: 20),
        ),
      ),
      initialIndex: 0, // default tab (Home)
    );
  }
}

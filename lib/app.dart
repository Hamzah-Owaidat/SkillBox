import 'package:flutter/material.dart';
import 'theme/app_theme.dart';
import 'screens/auth/login_screen.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'SkillBox',
      theme: AppTheme.lightTheme,   // Light Theme
      darkTheme: AppTheme.darkTheme, // Dark Theme
      themeMode: ThemeMode.system,   // Auto (system based)
      debugShowCheckedModeBanner: false,
      home: const LoginScreen(),
    );
  }
}

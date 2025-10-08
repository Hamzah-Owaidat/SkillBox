import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:skillbox/widgets/launcher.dart';
import 'theme/app_theme.dart';
import 'providers/user_provider.dart'; // import your provider

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => UserProvider(),
      child: MaterialApp(
        title: 'SkillBox',
        theme: AppTheme.lightTheme,    // Light Theme
        darkTheme: AppTheme.darkTheme, // Dark Theme
        themeMode: ThemeMode.system,   // Auto (system based)
        debugShowCheckedModeBanner: false,
        home: const LauncherScreen(),
      ),
    );
  }
}

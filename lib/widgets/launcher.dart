import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:skillbox/providers/user_provider.dart';
import 'package:skillbox/screens/auth/login_screen.dart';
import 'package:skillbox/screens/home/home_screen.dart';
import 'package:skillbox/services/api_service.dart';
import '../models/user.dart';

class LauncherScreen extends StatefulWidget {
  const LauncherScreen({super.key});

  @override
  State<LauncherScreen> createState() => _LauncherScreenState();
}

class _LauncherScreenState extends State<LauncherScreen> {
  bool _loading = true;

  @override
  void initState() {
    super.initState();
    _initUser();
  }

  Future<void> _initUser() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token');

    if (token != null) {
      try {
        final userRes = await ApiService.getCurrentUser(token); // New method
        if (!userRes.containsKey('error')) {
          User user = User.fromJson(userRes);
          Provider.of<UserProvider>(context, listen: false).setUser(user);
        }
      } catch (e) {
        // Ignore: token invalid or network error
      }
    }

    setState(() {
      _loading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (_loading) {
      return const Scaffold(
        body: Center(child: CircularProgressIndicator()),
      );
    }

    final isLoggedIn =
        Provider.of<UserProvider>(context, listen: false).isLoggedIn;

    return isLoggedIn ? const HomeScreen() : const LoginScreen();
  }
}

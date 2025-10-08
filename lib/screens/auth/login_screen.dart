import 'package:flutter/material.dart';
import 'package:skillbox/services/api_service.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'register_screen.dart';
import '../home/home_screen.dart';
import 'package:provider/provider.dart';
import '../../providers/user_provider.dart';
import '../../models/user.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  String email = '';
  String password = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Login")),
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                TextFormField(
                  cursorColor: Colors.yellow,
                  decoration: InputDecoration(
                    labelText: "Email",
                    labelStyle: Theme.of(context).textTheme.bodyLarge,
                    errorStyle: const TextStyle(
                      color: Colors.red,
                      fontSize: 14,
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide: const BorderSide(
                        color: Colors.grey,
                        width: 1.5,
                      ),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: const BorderSide(
                        color: Colors.yellow,
                        width: 2,
                      ),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    errorBorder: OutlineInputBorder(
                      borderSide: const BorderSide(
                        color: Colors.red,
                        width: 1.5,
                      ),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    focusedErrorBorder: OutlineInputBorder(
                      borderSide: const BorderSide(color: Colors.red, width: 2),
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  onChanged: (val) => email = val,
                  validator: (val) =>
                      val!.isEmpty ? "Enter a valid email" : null,
                ),
                const SizedBox(height: 16),
                TextFormField(
                  cursorColor: Colors.yellow,
                  decoration: InputDecoration(
                    labelText: "Password",
                    labelStyle: Theme.of(context).textTheme.bodyLarge,
                    errorStyle: const TextStyle(
                      color: Colors.red,
                      fontSize: 14,
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide: const BorderSide(
                        color: Colors.grey,
                        width: 1.5,
                      ),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: const BorderSide(
                        color: Colors.yellow,
                        width: 2,
                      ),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    errorBorder: OutlineInputBorder(
                      borderSide: const BorderSide(
                        color: Colors.red,
                        width: 1.5,
                      ),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    focusedErrorBorder: OutlineInputBorder(
                      borderSide: const BorderSide(color: Colors.red, width: 2),
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  obscureText: true,
                  onChanged: (val) => password = val,
                  validator: (val) =>
                      val!.length < 6 ? "Password must be 6+ chars" : null,
                ),
                const SizedBox(height: 24),
                ElevatedButton(
                  onPressed: () async {
                    if (_formKey.currentState!.validate()) {
                      final data = {'email': email, 'password': password};

                      try {
                        final res = await ApiService.login(data);

                        if (res.containsKey('error')) {
                          ScaffoldMessenger.of(
                            context,
                          ).showSnackBar(SnackBar(content: Text(res['error'])));
                        } else if (res.containsKey('token')) {
                          User user = User.fromJson(res['user']);

                          // Save globally in provider
                          Provider.of<UserProvider>(
                            context,
                            listen: false,
                          ).setUser(user);

                          // Optionally save in SharedPreferences
                          SharedPreferences prefs =
                              await SharedPreferences.getInstance();
                          await prefs.setString('token', res['token']);
                          await prefs.setString('full_name', user.fullName);
                          await prefs.setString('role', user.role);

                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                              builder: (_) => const HomeScreen(),
                            ),
                          );
                        }
                      } catch (e) {
                        // This now mostly catches network errors, not bad JSON
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text("Network/server error: $e")),
                        );
                      }
                    }
                  },
                  child: const Text("Login"),
                ),

                TextButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (_) => const RegisterScreen()),
                    );
                  },
                  child: const Text(
                    "Don’t have an account? Register",
                    style: TextStyle(color: Colors.blue),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

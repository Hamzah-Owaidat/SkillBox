import 'package:flutter/material.dart';
import 'register_screen.dart';
import '../home/home_screen.dart';

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
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                decoration: const InputDecoration(labelText: "Email"),
                onChanged: (val) => email = val,
                validator: (val) =>
                    val!.isEmpty ? "Enter a valid email" : null,
              ),
              const SizedBox(height: 16),
              TextFormField(
                decoration: const InputDecoration(labelText: "Password"),
                obscureText: true,
                onChanged: (val) => password = val,
                validator: (val) =>
                    val!.length < 6 ? "Password must be 6+ chars" : null,
              ),
              const SizedBox(height: 24),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(builder: (_) => const HomeScreen()),
                    );
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
                child: const Text("Don’t have an account? Register"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

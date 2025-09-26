import 'package:flutter/material.dart';
import 'login_screen.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _formKey = GlobalKey<FormState>();
  String email = '';
  String password = '';
  String confirmPassword = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Register")),
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
              const SizedBox(height: 16),
              TextFormField(
                decoration:
                    const InputDecoration(labelText: "Confirm Password"),
                obscureText: true,
                onChanged: (val) => confirmPassword = val,
                validator: (val) =>
                    val != password ? "Passwords don’t match" : null,
              ),
              const SizedBox(height: 24),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text("Registered Successfully")),
                    );
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(builder: (_) => const LoginScreen()),
                    );
                  }
                },
                child: const Text("Register"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

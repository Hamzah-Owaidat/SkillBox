import 'package:flutter/material.dart';
import 'package:skillbox/widgets/welcome_text.dart';
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
  bool acceptTerms = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Register")),
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const WelcomeText(),
              const SizedBox(height: 24),
              Form(
                key: _formKey,
                child: Column(
                  children: [
                    TextFormField(
                      decoration: InputDecoration(
                        labelText: "Username",
                        labelStyle: Theme.of(context).textTheme.bodyLarge,
                        errorStyle: const TextStyle(
                          color: Colors.red,
                          fontSize: 14,
                        ),
                        errorBorder: OutlineInputBorder(
                          borderSide: const BorderSide(
                            color: Colors.red,
                            width: 1.5,
                          ),
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      onChanged: (val) {},
                      validator: (val) =>
                          val!.isEmpty ? "Enter a valid username" : null,
                    ),
                    const SizedBox(height: 16),
                    TextFormField(
                      decoration: InputDecoration(
                        labelText: "Email",
                        labelStyle: Theme.of(context).textTheme.bodyLarge,
                        errorStyle: const TextStyle(
                          color: Colors.red,
                          fontSize: 14,
                        ),
                        errorBorder: OutlineInputBorder(
                          borderSide: const BorderSide(
                            color: Colors.red,
                            width: 1.5,
                          ),
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      onChanged: (val) => email = val,
                      validator: (val) =>
                          val!.isEmpty ? "Enter a valid email" : null,
                    ),
                    const SizedBox(height: 16),
                    TextFormField(
                      decoration: InputDecoration(
                        labelText: "Password",
                        labelStyle: Theme.of(context).textTheme.bodyLarge,
                        errorStyle: const TextStyle(
                          color: Colors.red,
                          fontSize: 14,
                        ),
                        errorBorder: OutlineInputBorder(
                          borderSide: const BorderSide(
                            color: Colors.red,
                            width: 1.5,
                          ),
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      obscureText: true,
                      onChanged: (val) => password = val,
                      validator: (val) =>
                          val!.length < 6 ? "Password must be 6+ chars" : null,
                    ),
                    const SizedBox(height: 16),
                    TextFormField(
                      decoration: InputDecoration(
                        labelText: "Confirm Password",
                        labelStyle: Theme.of(context).textTheme.bodyLarge,
                        errorStyle: const TextStyle(
                          color: Colors.red,
                          fontSize: 14,
                        ),
                        errorBorder: OutlineInputBorder(
                          borderSide: const BorderSide(
                            color: Colors.red,
                            width: 1.5,
                          ),
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      obscureText: true,
                      onChanged: (val) => confirmPassword = val,
                      validator: (val) =>
                          val != password ? "Passwords don’t match" : null,
                    ),
                    const SizedBox(height: 24),
                    FormField<bool>(
                      initialValue: acceptTerms,
                      validator: (val) {
                        if (val != true) {
                          return "You must accept terms";
                        }
                        return null;
                      },
                      builder: (formFieldState) {
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            CheckboxListTile(
                              title: const Text("Accept Terms & Conditions"),
                              value: acceptTerms,
                              onChanged: (val) {
                                setState(() {
                                  acceptTerms = val ?? false;
                                  formFieldState.didChange(
                                    acceptTerms,
                                  ); // ✅ sync with form
                                });
                              },
                              controlAffinity: ListTileControlAffinity.leading,
                            ),
                            if (formFieldState
                                .hasError) // ✅ show error below checkbox
                              Padding(
                                padding: const EdgeInsets.only(left: 16),
                                child: Text(
                                  formFieldState.errorText ?? "",
                                  style: const TextStyle(
                                    color: Colors.red,
                                    fontSize: 12,
                                  ),
                                ),
                              ),
                          ],
                        );
                      },
                    ),
                    const SizedBox(height: 24),
                    ElevatedButton(
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text("Registered Successfully"),
                            ),
                          );
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                              builder: (_) => const LoginScreen(),
                            ),
                          );
                        }
                      },
                      child: const Text("Register"),
                    ),
                    TextButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => const LoginScreen(),
                          ),
                        );
                      },
                      child: const Text(
                        "Already have an account? Login",
                        style: TextStyle(color: Colors.blue),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

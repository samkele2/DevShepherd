import 'package:dev_shepherd/main.dart';
import 'package:flutter/material.dart';
import 'package:dev_shepherd/services/auth_service.dart';

class AuthPage extends StatefulWidget {
  final AuthService authService;

  const AuthPage({
    super.key,
    required this.authService,
  });

  @override
  State<AuthPage> createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('DevShepherd Login'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Card(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                TextField(
                  controller: emailController,
                  decoration: const InputDecoration(
                    labelText: 'Email',
                  ),
                ),

                TextField(
                  controller: passwordController,
                  obscureText: true,
                  decoration: const InputDecoration(
                    labelText: 'Password',
                  ),
                ),

                ElevatedButton(
                  onPressed: () async {
                    try {
                      await widget.authService.signUp(
                        emailController.text,
                        passwordController.text,
                      );

                      print("SIGN UP SUCCESS");

                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const MyHomePage(
                            title: 'Dev Shepherd Home Page',
                          ),
                        ),
                      );
                    } catch (e) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text(
                            'Sign up failed. Please try again.',
                          ),
                        ),
                      );
                    }
                  },
                  child: const Text('Sign Up'),
                ),

                SizedBox(height: 16,),

                ElevatedButton(
                  onPressed: () async {
                    try {
                      await widget.authService.login(
                        emailController.text,
                        passwordController.text,
                      );

                      print("LOGIN SUCCESS");

                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const MyHomePage(
                            title: 'Dev Shepherd Home Page',
                          ),
                        ),
                      );
                    }  catch (e) {
                        ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                        content: Text('Login failed. Please check your email and password.'),
                        ),
                        );
          }
                  },
                  child: const Text('Login'),
                ),
              ],

            ),
          ),
        ),
      ),
    );
  }
}
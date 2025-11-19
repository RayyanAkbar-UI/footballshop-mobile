import 'package:flutter/material.dart';
import 'package:footballshop_mobile/screens/login.dart';
import 'package:pbp_django_auth/pbp_django_auth.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'package:footballshop_mobile/config.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final request = context.watch<CookieRequest>();
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Register',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      extendBodyBehindAppBar: true,
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Color(0xFFff007f),
              Color(0xFF7f00ff),
              Color(0xFF0077ff),
              Color(0xFF00c6ff),
            ],
            stops: [0.0, 0.33, 0.66, 1.0],
          ),
        ),
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(16.0),
            child: Container(
              decoration: BoxDecoration(
                color: const Color(0xFF1a1a2e).withOpacity(0.6),
                borderRadius: BorderRadius.circular(16.0),
                border: Border.all(
                  color: Colors.white.withOpacity(0.1),
                  width: 1,
                ),
                boxShadow: [
                  BoxShadow(
                    color: const Color(0xFFe0a3ff).withOpacity(0.2),
                    blurRadius: 32,
                    offset: const Offset(0, 8),
                  ),
                ],
              ),
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    ShaderMask(
                      shaderCallback: (bounds) => const LinearGradient(
                        colors: [Color(0xFFe0a3ff), Color(0xFFff69b4)],
                      ).createShader(bounds),
                      child: const Text(
                        'Register',
                        style: TextStyle(
                          fontSize: 28.0,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    const SizedBox(height: 30.0),
                    TextFormField(
                      controller: _usernameController,
                      style: const TextStyle(color: Colors.white),
                      decoration: InputDecoration(
                        labelText: 'Username',
                        hintText: 'Enter your username',
                        filled: true,
                        fillColor: Colors.white.withOpacity(0.05),
                        border: OutlineInputBorder(
                          borderRadius: const BorderRadius.all(
                            Radius.circular(12.0),
                          ),
                          borderSide: BorderSide(
                            color: Colors.white.withOpacity(0.2),
                          ),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: const BorderRadius.all(
                            Radius.circular(12.0),
                          ),
                          borderSide: BorderSide(
                            color: Colors.white.withOpacity(0.2),
                          ),
                        ),
                        focusedBorder: const OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(12.0)),
                          borderSide: BorderSide(
                            color: Color(0xFFe0a3ff),
                            width: 2,
                          ),
                        ),
                        labelStyle: TextStyle(
                          color: Colors.white.withOpacity(0.7),
                        ),
                        hintStyle: TextStyle(
                          color: Colors.white.withOpacity(0.5),
                        ),
                        contentPadding: const EdgeInsets.symmetric(
                          horizontal: 12.0,
                          vertical: 8.0,
                        ),
                      ),
                    ),
                    const SizedBox(height: 12.0),
                    TextFormField(
                      controller: _passwordController,
                      style: const TextStyle(color: Colors.white),
                      decoration: InputDecoration(
                        labelText: 'Password',
                        hintText: 'Enter your password',
                        filled: true,
                        fillColor: Colors.white.withOpacity(0.05),
                        border: OutlineInputBorder(
                          borderRadius: const BorderRadius.all(
                            Radius.circular(12.0),
                          ),
                          borderSide: BorderSide(
                            color: Colors.white.withOpacity(0.2),
                          ),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: const BorderRadius.all(
                            Radius.circular(12.0),
                          ),
                          borderSide: BorderSide(
                            color: Colors.white.withOpacity(0.2),
                          ),
                        ),
                        focusedBorder: const OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(12.0)),
                          borderSide: BorderSide(
                            color: Color(0xFFe0a3ff),
                            width: 2,
                          ),
                        ),
                        labelStyle: TextStyle(
                          color: Colors.white.withOpacity(0.7),
                        ),
                        hintStyle: TextStyle(
                          color: Colors.white.withOpacity(0.5),
                        ),
                        contentPadding: const EdgeInsets.symmetric(
                          horizontal: 12.0,
                          vertical: 8.0,
                        ),
                      ),
                      obscureText: true,
                    ),
                    const SizedBox(height: 12.0),
                    TextFormField(
                      controller: _confirmPasswordController,
                      style: const TextStyle(color: Colors.white),
                      decoration: InputDecoration(
                        labelText: 'Confirm Password',
                        hintText: 'Confirm your password',
                        filled: true,
                        fillColor: Colors.white.withOpacity(0.05),
                        border: OutlineInputBorder(
                          borderRadius: const BorderRadius.all(
                            Radius.circular(12.0),
                          ),
                          borderSide: BorderSide(
                            color: Colors.white.withOpacity(0.2),
                          ),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: const BorderRadius.all(
                            Radius.circular(12.0),
                          ),
                          borderSide: BorderSide(
                            color: Colors.white.withOpacity(0.2),
                          ),
                        ),
                        focusedBorder: const OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(12.0)),
                          borderSide: BorderSide(
                            color: Color(0xFFe0a3ff),
                            width: 2,
                          ),
                        ),
                        labelStyle: TextStyle(
                          color: Colors.white.withOpacity(0.7),
                        ),
                        hintStyle: TextStyle(
                          color: Colors.white.withOpacity(0.5),
                        ),
                        contentPadding: const EdgeInsets.symmetric(
                          horizontal: 12.0,
                          vertical: 8.0,
                        ),
                      ),
                      obscureText: true,
                    ),
                    const SizedBox(height: 24.0),
                    ElevatedButton(
                      onPressed: () async {
                        final messenger = ScaffoldMessenger.of(context);
                        final navigator = Navigator.of(context);
                        final username = _usernameController.text.trim();
                        final password1 = _passwordController.text.trim();
                        final password2 = _confirmPasswordController.text
                            .trim();

                        if (username.isEmpty ||
                            password1.isEmpty ||
                            password2.isEmpty) {
                          messenger.showSnackBar(
                            const SnackBar(
                              content: Text('All fields are required'),
                            ),
                          );
                          return;
                        }

                        try {
                          // Debug: log request
                          // ignore: avoid_print
                          print(
                            '[REGISTER] POST ${AppConfig.authRegister} body={username: $username, password1: ***, password2: ***}',
                          );

                          // Send as form-encoded to avoid JSON/body fields conflict
                          final response = await request
                              .post(AppConfig.authRegister, {
                                'username': username,
                                'password1': password1,
                                'password2': password2,
                              });
                          if (!mounted) return;
                          {
                            // Debug: log response
                            // ignore: avoid_print
                            print(
                              '[REGISTER] response=${response.toString()} cookies=${request.cookies}',
                            );

                            final status = response['status'];
                            final isSuccess =
                                status == 'success' || status == true;
                            if (isSuccess) {
                              messenger.showSnackBar(
                                const SnackBar(
                                  content: Text('Successfully registered!'),
                                ),
                              );
                              navigator.pushReplacement(
                                MaterialPageRoute(
                                  builder: (context) => const LoginPage(),
                                ),
                              );
                            } else {
                              // If library says Invalid JSON, probe raw response using http
                              if ((response['message'] ?? '')
                                  .toString()
                                  .toLowerCase()
                                  .contains('invalid json')) {
                                // ignore: avoid_print
                                print(
                                  '[REGISTER][DEBUG] Falling back to raw http probe',
                                );
                                try {
                                  final raw = await http.post(
                                    Uri.parse(AppConfig.authRegister),
                                    headers: {'Accept': 'application/json'},
                                    body: {
                                      'username': username,
                                      'password1': password1,
                                      'password2': password2,
                                    },
                                  );
                                  // ignore: avoid_print
                                  print(
                                    '[REGISTER][DEBUG] raw status=${raw.statusCode} headers=${raw.headers} body=${raw.body}',
                                  );
                                } catch (e) {
                                  // ignore: avoid_print
                                  print('[REGISTER][DEBUG][ERROR] $e');
                                }
                              }
                              messenger.showSnackBar(
                                SnackBar(
                                  content: Text(
                                    response['message'] ??
                                        'Failed to register!',
                                  ),
                                ),
                              );
                            }
                          }
                        } catch (e) {
                          // ignore: avoid_print
                          print('[REGISTER][ERROR] $e');
                          if (!mounted) return;
                          messenger.showSnackBar(
                            SnackBar(
                              content: Text('Register error: ${e.toString()}'),
                            ),
                          );
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        foregroundColor: Colors.white,
                        minimumSize: const Size(double.infinity, 50),
                        backgroundColor: Theme.of(context).colorScheme.primary,
                        padding: const EdgeInsets.symmetric(vertical: 16.0),
                      ),
                      child: const Text('Register'),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

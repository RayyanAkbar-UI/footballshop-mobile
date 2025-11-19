import 'package:flutter/material.dart';
import 'package:footballshop_mobile/screens/menu.dart';
import 'package:pbp_django_auth/pbp_django_auth.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'package:footballshop_mobile/screens/register.dart';
import 'package:footballshop_mobile/config.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final request = context.watch<CookieRequest>();

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Login',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
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
                  children: [
                    ShaderMask(
                      shaderCallback: (bounds) => const LinearGradient(
                        colors: [Color(0xFFe0a3ff), Color(0xFFff69b4)],
                      ).createShader(bounds),
                      child: const Text(
                        'Login',
                        style: TextStyle(
                          fontSize: 28.0,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    const SizedBox(height: 30.0),
                    TextField(
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
                    TextField(
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
                    const SizedBox(height: 24.0),
                    ElevatedButton(
                      onPressed: () async {
                        final username = _usernameController.text.trim();
                        final password = _passwordController.text.trim();

                        // TODO: Change to your app URL and keep trailing slash
                        // Emulator: http://10.0.2.2:8000
                        // Chrome: http://localhost:8000
                        try {
                          // Debug: log request
                          // ignore: avoid_print
                          print(
                            '[LOGIN] POST ${AppConfig.authLogin} body={username: $username, password: ***}',
                          );

                          final response = await request.login(
                            AppConfig.authLogin,
                            {'username': username, 'password': password},
                          );

                          // Debug: log response
                          // ignore: avoid_print
                          print(
                            '[LOGIN] response=${response.toString()} cookies=${request.cookies}',
                          );

                          if (request.loggedIn) {
                            final message =
                                response['message'] ?? 'Login successful!';
                            final uname = response['username'] ?? username;
                            if (context.mounted) {
                              Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => MyHomePage(),
                                ),
                              );
                              ScaffoldMessenger.of(context)
                                ..hideCurrentSnackBar()
                                ..showSnackBar(
                                  SnackBar(
                                    content: Text("$message Welcome, $uname."),
                                  ),
                                );
                            }
                          } else {
                            if (context.mounted) {
                              showDialog(
                                context: context,
                                builder: (context) => AlertDialog(
                                  title: const Text('Login Failed'),
                                  content: Text(
                                    response['message'] ?? 'Unknown error',
                                  ),
                                  actions: [
                                    TextButton(
                                      child: const Text('OK'),
                                      onPressed: () {
                                        Navigator.pop(context);
                                      },
                                    ),
                                  ],
                                ),
                              );
                            }
                            // If the library fails, probe raw http response for diagnostics
                            try {
                              final raw = await http.post(
                                Uri.parse(AppConfig.authLogin),
                                headers: {'Accept': 'application/json'},
                                body: {
                                  'username': username,
                                  'password': password,
                                },
                              );
                              // ignore: avoid_print
                              print(
                                '[LOGIN][DEBUG] raw status=${raw.statusCode} headers=${raw.headers} body=${raw.body}',
                              );
                            } catch (e) {
                              // ignore: avoid_print
                              print('[LOGIN][DEBUG][ERROR] $e');
                            }
                          }
                        } catch (e) {
                          // ignore: avoid_print
                          print('[LOGIN][ERROR] $e');
                          if (context.mounted) {
                            showDialog(
                              context: context,
                              builder: (context) => AlertDialog(
                                title: const Text('Login Error'),
                                content: Text(e.toString()),
                                actions: [
                                  TextButton(
                                    child: const Text('OK'),
                                    onPressed: () => Navigator.pop(context),
                                  ),
                                ],
                              ),
                            );
                          }
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        foregroundColor: Colors.white,
                        minimumSize: const Size(double.infinity, 50),
                        backgroundColor: Theme.of(context).colorScheme.primary,
                        padding: const EdgeInsets.symmetric(vertical: 16.0),
                      ),
                      child: const Text('Login'),
                    ),
                    const SizedBox(height: 36.0),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const RegisterPage(),
                          ),
                        );
                      },
                      child: Text(
                        "Don't have an account? Register",
                        style: TextStyle(
                          color: Theme.of(context).colorScheme.primary,
                          fontSize: 16.0,
                        ),
                      ),
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

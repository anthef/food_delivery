import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:io';
import 'package:flutter/foundation.dart' show kIsWeb;

import 'package:food_delivery/components/my_button.dart';
import 'package:food_delivery/components/my_textfield.dart';

class RegisterPage extends StatefulWidget {
  final void Function()? onTap;
  const RegisterPage({
    Key? key,
    required this.onTap,
  }) : super(key: key);

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();

  late GoogleSignIn _googleSignIn;

  @override
  void initState() {
    super.initState();
    _googleSignIn = GoogleSignIn(
      scopes: [
        'email',
      ],
    );

    if (Platform.isIOS || Platform.isMacOS) {
      _googleSignIn = GoogleSignIn(
        clientId:
            "847312995316-thv21um31nlret7fm04iekkiumtrraic.apps.googleusercontent.com",
        scopes: [
          'email',
        ],
      );
    }
  }

  Future<void> _handleGoogleSignIn() async {
    try {
      print('Google Sign-In button pressed');
      final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();

      if (googleUser != null) {
        final GoogleSignInAuthentication googleAuth =
            await googleUser.authentication;
        print('Google Authentication succeeded');

        final response = await http.get(
          Uri.parse(
              'https://www.googleapis.com/oauth2/v1/userinfo?alt=json&access_token=${googleAuth.accessToken}'),
        );

        if (response.statusCode == 200) {
          final profile = jsonDecode(response.body);
          print('Name: ${profile['name']}');
          print('Email: ${profile['email']}');
        } else {
          print('Failed to get user profile: ${response.statusCode}');
        }
      } else {
        print('Google Sign-In aborted');
      }
    } catch (error) {
      print('Google Sign-In failed: $error');
      rethrow;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.lock_open_rounded,
                size: 100,
                color: Theme.of(context).colorScheme.primary,
              ),
              const SizedBox(
                height: 25,
              ),
              Text(
                "Let's create an account for you",
                style: TextStyle(
                  fontSize: 16,
                  color: Theme.of(context).colorScheme.primary,
                ),
              ),
              const SizedBox(
                height: 25,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25.0),
                child: MyTextfield(
                  controller: emailController,
                  hintText: 'Email',
                  obscureText: false,
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25.0),
                child: MyTextfield(
                  controller: passwordController,
                  hintText: 'Password',
                  obscureText: true,
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25.0),
                child: MyTextfield(
                  controller: confirmPasswordController,
                  hintText: 'Confirm password',
                  obscureText: true,
                ),
              ),
              const SizedBox(
                height: 25,
              ),
              MyButton(
                text: 'Sign Up',
                onTap: () {
                  // Sign up logic
                },
              ),
              const SizedBox(
                height: 25,
              ),
              MyButton(
                text: 'Sign Up with Google',
                onTap: _handleGoogleSignIn,
              ),
              const SizedBox(
                height: 25,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Already have an account?',
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.primary,
                    ),
                  ),
                  const SizedBox(
                    width: 4,
                  ),
                  GestureDetector(
                    onTap: widget.onTap,
                    child: Text(
                      'Login now',
                      style: TextStyle(
                        color: Theme.of(context).colorScheme.primary,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

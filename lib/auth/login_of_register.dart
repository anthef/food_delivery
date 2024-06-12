import 'package:flutter/material.dart';
import 'package:food_delivery/pages/login_page.dart';
import 'package:food_delivery/pages/register_page.dart';

class LoginOfRegister extends StatefulWidget {
  const LoginOfRegister({super.key});

  @override
  State<LoginOfRegister> createState() => _LoginOfRegisterState();
}

class _LoginOfRegisterState extends State<LoginOfRegister> {
  bool showLoginPage = true;

  void togglePages() {
    setState(() {
      showLoginPage = !showLoginPage;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (showLoginPage) {
      return LoginPage(onTap: togglePages);
    } else {
      return RegisterPage(onTap: togglePages);
    }
  }
}

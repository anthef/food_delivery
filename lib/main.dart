import 'package:flutter/material.dart';
import 'package:food_delivery/auth/login_of_register.dart';
import 'package:food_delivery/pages/home_page.dart';
import 'package:food_delivery/pages/settings_page.dart';
import 'package:food_delivery/themes/theme_provider.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
        create: (context) => ThemeProvider(), 
        child: const MyApp(),
        
        ),
  );
}
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: const LoginOfRegister(),
      theme: Provider.of<ThemeProvider>(context).themeData,
    );
  }
}

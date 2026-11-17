
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'pages/home_page.dart';
import 'pages/welcome_page.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final preferences = await SharedPreferences.getInstance();
  final onboardingCompleted =
      preferences.getBool('onboarding_completed') ?? false;

  runApp(
    ProyectoRaizApp(
      onboardingCompleted: onboardingCompleted,
    ),
  );
}

class ProyectoRaizApp extends StatelessWidget {
  final bool onboardingCompleted;

  const ProyectoRaizApp({
    super.key,
    required this.onboardingCompleted,
  });

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Proyecto Raíz',
      home: onboardingCompleted
          ? const HomePage()
          : const WelcomePage(),
    );
  }
}

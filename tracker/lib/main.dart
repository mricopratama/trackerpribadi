import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'core/theme.dart';
import 'welcome_screen.dart';

void main() {
  runApp(const ProviderScope(child: PersonalTrackerApp()));
}

class PersonalTrackerApp extends StatelessWidget {
  const PersonalTrackerApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Personal Tracker",
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      themeMode: ThemeMode.system,
      home: const WelcomeScreen(), 
      debugShowCheckedModeBanner: false,
    );
  }
}
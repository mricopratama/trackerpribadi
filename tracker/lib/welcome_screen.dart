import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import './features/auth/screens/auth_screen.dart';
import '../../../core/routing/fade_page_route.dart'; // <-- Import transisi baru

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: RadialGradient(
            colors: [
              colors.primary.withOpacity(0.1),
              colors.background,
            ],
            center: Alignment.topCenter,
            radius: 1.5,
          ),
        ),
        child: SafeArea(
          child: Column(
            children: [
              Expanded(
                flex: 5,
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
                  child: Image.asset(
                    'assets/images/welcome.png',
                    fit: BoxFit.contain,
                  )
                      .animate()
                      .slideY(
                        begin: -1.0,
                        duration: 800.ms,
                        curve: Curves.easeOutCubic,
                      )
                      .fadeIn(duration: 800.ms),
                ),
              ),
              Expanded(
                flex: 4,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Track Your Progress,\nAll in One Place',
                        textAlign: TextAlign.center,
                        style: textTheme.headlineMedium?.copyWith(
                          fontWeight: FontWeight.bold,
                          fontSize: 32,
                        ),
                      )
                          .animate()
                          .slideY(
                            begin: 0.5,
                            delay: 400.ms,
                            duration: 700.ms,
                            curve: Curves.easeOutCubic,
                          )
                          .fadeIn(delay: 400.ms, duration: 700.ms),
                      const SizedBox(height: 32),
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: () {
                            // Menggunakan FadePageRoute
                            Navigator.of(context).pushReplacement(
                              FadePageRoute(child: const AuthScreen(initialIndex: 1)),
                            );
                          },
                          child: const Text('Get Started'),
                        ),
                      )
                          .animate()
                          .slideY(
                            begin: 1.0,
                            delay: 600.ms,
                            duration: 700.ms,
                            curve: Curves.easeOutCubic,
                          )
                          .fadeIn(delay: 600.ms, duration: 700.ms),
                      const SizedBox(height: 20),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Already Have Account? ',
                            style: textTheme.bodyLarge,
                          ),
                          TextButton(
                            onPressed: () {
                              // Menggunakan FadePageRoute
                              Navigator.of(context).pushReplacement(
                                FadePageRoute(child: const AuthScreen(initialIndex: 0)),
                              );
                            },
                            child: const Text('Log In'),
                          ),
                        ],
                      )
                          .animate()
                          .fadeIn(delay: 800.ms, duration: 700.ms),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';

// Kelas ini membuat animasi transisi 'fade' yang lembut antar halaman.
class FadePageRoute<T> extends PageRouteBuilder<T> {
  final Widget child;

  FadePageRoute({required this.child, RouteSettings? settings})
      : super(
          settings: settings,
          pageBuilder: (context, animation, secondaryAnimation) => child,
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            // Menggunakan FadeTransition untuk animasi.
            return FadeTransition(opacity: animation, child: child);
          },
          // Durasi transisi bisa disesuaikan. 300ms adalah standar yang baik.
          transitionDuration: const Duration(milliseconds: 300),
        );
}

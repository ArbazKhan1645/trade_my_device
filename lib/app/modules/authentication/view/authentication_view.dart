// ignore_for_file: library_private_types_in_public_api, depend_on_referenced_packages, deprecated_member_use

import 'package:flutter/material.dart';

import '../widgets/login_screen.dart';

class AuthenticatedAnimatedDialog extends StatefulWidget {
  const AuthenticatedAnimatedDialog({super.key});

  @override
  _AuthenticatedAnimatedDialogState createState() =>
      _AuthenticatedAnimatedDialogState();
}

class _AuthenticatedAnimatedDialogState
    extends State<AuthenticatedAnimatedDialog>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );

    _scaleAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.fastOutSlowIn,
      ),
    );
    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ScaleTransition(
        scale: _scaleAnimation,
        child: LayoutBuilder(builder: (context, constraints) {
          return Scaffold(
            backgroundColor: Colors.grey.shade50,
            body: Center(
              child: AnimatedContainer(
                  duration: const Duration(milliseconds: 500),
                  width: constraints.maxWidth <= 600
                      ? (constraints.maxWidth - 50)
                      : 500,
                  height: 500,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      border: Border.all(color: const Color(0xFFe5e7eb)),
                      borderRadius: BorderRadius.circular(20)),
                  child: LoginWidget()),
            ),
          );
        }));
  }
}

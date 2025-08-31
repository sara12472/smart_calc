import 'dart:async';
import 'package:flutter/material.dart';
import 'package:smart_calc/Screens/home_screen.dart';
import 'package:smart_calc/constants/constants.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});
  static const String id = 'splash_screen';

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _fadeScaleAnimation;
  late Animation<Offset> _slideAnimation;

  @override
  void initState() {
    super.initState();

    // Animation setup
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    );

    _fadeScaleAnimation = CurvedAnimation(
      parent: _controller,
      curve: Curves.easeInOut,
    );

    // Slide text from bottom
    _slideAnimation = Tween<Offset>(
      begin: const Offset(0, 1), // start off-screen (bottom)
      end: Offset.zero, // end at original position
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeOut));

    _controller.forward();

    // Navigate after 3 seconds
    Timer(const Duration(seconds: 3), () {
      Navigator.pushReplacementNamed(context, HomeScreen.id);
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF0D1B2A),
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              FadeTransition(
                opacity: _fadeScaleAnimation,
                child: ScaleTransition(
                  scale: _fadeScaleAnimation,
                  child: Hero(
                    tag: 'logo',
                    child: Image.asset('images/logo.png', height: 80.0),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              SlideTransition(
                position: _slideAnimation,
                child: const Text('Smart Calculator', style: kMainTextStyle),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

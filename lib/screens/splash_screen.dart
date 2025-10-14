import 'dart:async';
import 'package:elsaa/constants/responsive_utils.dart';
import 'package:elsaa/screens/login_screen.dart';
import 'package:elsaa/screens/sign_up_screen.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    // Start the timer
    Timer(const Duration(seconds: 2), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const SignUpScreen()),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox(
        width: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              children: [
                SizedBox(
                  height: SpacingResponsive.getVerticalSpacing(
                    context,
                    factor: 30,
                  ),
                ),
                Image.asset("assets/logo.png"),
              ],
            ),
            Column(
              children: [
                Image.asset("assets/powered_text.png"),
                SizedBox(
                  height: SpacingResponsive.getVerticalSpacing(
                    context,
                    factor: 2,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

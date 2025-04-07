import 'package:flutter/material.dart';
import 'package:e_recycle_app/domain/app_colors.dart';
import 'package:e_recycle_app/ui/custom_widgets/my_custom_rounded_btn.dart';
import 'package:e_recycle_app/domain/app_routes.dart';

class IntroPage extends StatelessWidget {
  const IntroPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primaryColor,
      body: Stack(
        fit: StackFit.expand,
        children: [
          // Background Image
          Image.asset(
            'images/garbage.png', // Make sure this image exists in assets
            fit: BoxFit.cover,
          ),

          // Semi-transparent overlay
          Container(
            color: Colors.black.withOpacity(0.6),
          ),

          // Foreground Content
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Logo or animated icon
                Hero(
                  tag: 'logo',
                  child: CircleAvatar(
                    radius: 60,
                    backgroundImage: AssetImage('images/logo.png'),
                    backgroundColor: Colors.white,
                  ),
                ),

                const SizedBox(height: 30),

                // Welcome text
                const Text(
                  "Welcome to E-Recyclus!",
                  style: TextStyle(
                    fontSize: 26,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                    letterSpacing: 1.2,
                  ),
                  textAlign: TextAlign.center,
                ),

                const SizedBox(height: 12),

                const Text(
                  "Eco Starts with ‘E’—Empower, Engage, E-RECYCLUS ",
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.white70,
                  ),
                  textAlign: TextAlign.center,
                ),

                const SizedBox(height: 40),

                // Custom Button
                MyCustomRoundedBtn(
                  text: 'Get Started',
                  bgColor: Colors.white,
                  textColor: AppColors.primaryColor,
                  onTap: () {
                    Navigator.pushReplacementNamed(context, AppRoutes.signup_page);
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:e_recycle_app/domain/app_colors.dart';
import 'package:e_recycle_app/domain/app_routes.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}
class _SplashPageState extends State<SplashPage> {

  @override
  void initState() {
    super.initState();
    Timer(Duration(seconds: 2),() {
      Navigator.pushReplacementNamed(context, AppRoutes.intro_page);

    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.blackColor,
      body: Center(// Centering the image
        child: SizedBox(
          width: 150,  // Set desired width
          height: 150, // Set desired height
          child: Image.asset('images/logo.png', fit: BoxFit.contain),

        ),
      ),
    );
  }
}



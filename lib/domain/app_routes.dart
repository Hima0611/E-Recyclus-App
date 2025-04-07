import 'package:flutter/material.dart';
import 'package:e_recycle_app/splash/splash_page.dart' as splash;
import 'package:e_recycle_app/intro/intro_page.dart';
import 'package:e_recycle_app/waste/signup1_page.dart';
import 'package:e_recycle_app/waste/login1_page.dart';
import 'package:e_recycle_app/home.dart';
import '../bottom_nav_bar.dart';

class AppRoutes {
  static const String splash_page = '/splash';
  static const String intro_page = '/intro';
  static const String signup_page = '/signup';
  static const String login_page = '/login';
  static const String bottom_nav = '/bottom-nav';
  static const String home_page = '/home';


  static Map<String, Widget Function(BuildContext)> getRoutes() => {
    splash_page: (context) => splash.SplashPage(),
    intro_page: (context) => IntroPage(),
    signup_page: (context) => SignUpPage(),
    login_page: (context) => LoginPage(),
    home_page: (context) => HomePage(),
    bottom_nav: (context) =>  BottomNavBar(),
  };
}

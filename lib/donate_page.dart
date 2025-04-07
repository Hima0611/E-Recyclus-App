import 'package:flutter/material.dart';
import 'donation_page.dart'; // Import the DonationPage

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'E-Waste Recycling',
      theme: ThemeData(
        primarySwatch: Colors.green,
      ),
      home: DonationPage(), // Set DonationPage as the home screen
    );
  }
}
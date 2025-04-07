import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class PickupScheduleScreen extends StatelessWidget {
  final String url = "https://docs.google.com/forms/d/e/1FAIpQLSd0d-NSJ6c0XBCl4-jEnk7U2xEt8RB48hQ6NGqFRH9IpzQEsQ/viewform?usp=sharing";

  Future<void> _launchURL() async {
    final Uri uri = Uri.parse(url);
    try {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    } catch (e) {
      // Handle the error, e.g., show a snackbar or dialog
      print('Could not launch $url: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("E-Recyclus - Pickup Form")),
      body: Center(
        child: ElevatedButton(
          onPressed: _launchURL,
          child: const Text("Open Pickup Form"),
        ),
      ),
    );
  }
}

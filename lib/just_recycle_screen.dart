import 'package:flutter/material.dart';

class JustRecycleScreen extends StatelessWidget {
  const JustRecycleScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Just Recycle')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            // 🌱 Hero Section
            Card(
              elevation: 4,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Image.asset(
                      'images/dustbin.png',
                      height: 150,
                      fit: BoxFit.contain,
                    ),
                    const SizedBox(height: 16),
                    const Text(
                      'Recycle Your E-Waste Easily!',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 8),
                    const Text(
                      'Follow simple steps to recycle your old electronics responsibly.',
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 16),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 20),

            // ♻️ Steps to Recycle Section
            const Text(
              'Steps to Recycle',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
            ),
            const SizedBox(height: 12),
            _buildStepCard('1. Gather Your E-Waste', Icons.folder_open),
            _buildStepCard('2. Find a Collection Center', Icons.location_on),
            _buildStepCard('3. Drop Off or Schedule Pickup', Icons.schedule),
            _buildStepCard('4. Receive Recycling Confirmation', Icons.check),

            const SizedBox(height: 30),

            // ✅ No "Learn More" Widget Anymore!
          ],
        ),
      ),
    );
  }

  /// 🎯 Builds a Step Card
  Widget _buildStepCard(String text, IconData icon) {
    return Card(
      child: ListTile(
        leading: Icon(icon, color: Colors.green),
        title: Text(text),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'robot.dart';
import 'drag.dart';
import 'quiz.dart'; // ✅ Quiz game ke liye import add kiya

class GamesPage extends StatelessWidget {
  const GamesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Games')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: <Widget>[
            _buildGameCard(
              context,
              Icons.quiz,
              'Quiz Game',
              'Test your knowledge about e-waste recycling.',
                  () => Navigator.push(context, MaterialPageRoute(builder: (context) => EWasteQuizGame())), // ✅ Fixed navigation
              Colors.green[700]!,
            ),
            const SizedBox(height: 12),
            _buildGameCard(
              context,
              Icons.touch_app,
              'Drag & Drop Game',
              'Sort recyclable and non-recyclable items.',
                  () => Navigator.push(context, MaterialPageRoute(builder: (context) => EWasteCollectorGame())),
              Colors.blue[700]!,
            ),
            const SizedBox(height: 12),
            _buildGameCard(
              context,
              Icons.smart_toy,
              'Robot Game',
              'Guide the robot to clean up e-waste.',
                  () => Navigator.push(context, MaterialPageRoute(builder: (context) => RobotGame())),
              Colors.orange[700]!,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildGameCard(BuildContext context, IconData icon, String title, String description, VoidCallback onTap, Color color) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(color: color.withOpacity(0.4), blurRadius: 8, offset: const Offset(0, 4)),
          ],
        ),
        child: Row(
          children: <Widget>[
            Icon(icon, size: 40, color: Colors.white),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    title,
                    style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white),
                  ),
                  const SizedBox(height: 4),
                  Text(description, style: const TextStyle(fontSize: 14, color: Colors.white70)),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

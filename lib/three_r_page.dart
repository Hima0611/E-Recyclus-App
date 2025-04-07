import 'package:flutter/material.dart';
import 'reduce_page.dart'; // Importing the ReducePage
import 'reuse_page.dart';
import 'recycle_page.dart';


void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    home: ThreeRPage(),
  ));
}

class ThreeRPage extends StatelessWidget {
  const ThreeRPage({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("E-RECYCLUS... The 3R's - Reduce, Reuse, Recycle"),
        backgroundColor: Colors.green,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildCard(context, "Reduce", "Minimize waste by consuming fewer resources.", Icons.remove_circle, Colors.red, ReducePage()),
            _buildCard(context, "Reuse", "Use items multiple times before disposing of them.", Icons.loop, Colors.orange, ReusePage()),
            _buildCard(context, "Recycle", "Convert waste materials into new products.", Icons.recycling, Colors.blue, RecyclePage()),
          ],
        ),
      ),
    );
  }

  Widget _buildCard(BuildContext context, String title, String description, IconData icon, Color color, Widget page) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      margin: const EdgeInsets.symmetric(vertical: 10),
      child: ListTile(
        leading: Icon(icon, color: color, size: 40),
        title: Text(title, style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
        subtitle: Text(description),
        trailing: Icon(Icons.arrow_forward_ios, color: Colors.grey),
        onTap: () {
          Navigator.push(context, MaterialPageRoute(builder: (context) => page));
        },
      ),
    );
  }
}

// Placeholder pages for Reuse and Recycle



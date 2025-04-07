import 'package:flutter/material.dart';

class ReusePage extends StatelessWidget {
  const ReusePage({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Reuse Materials"),
        backgroundColor: Colors.orange,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Why Reuse?",
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            Text(
              "Reusing materials helps reduce waste, saves energy, and minimizes environmental impact. It also conserves natural resources by extending the life of products.",
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 20),
            Text(
              "Ways to Reuse Items:",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            _buildTip("Use refillable water bottles instead of single-use plastic ones."),
            _buildTip("Repurpose old clothes into cleaning rags or crafts."),
            _buildTip("Donate unused items instead of throwing them away."),
            _buildTip("Use glass jars for storage instead of disposable containers."),
          ],
        ),
      ),
    );
  }

  Widget _buildTip(String tip) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(Icons.check_circle, color: Colors.green),
          SizedBox(width: 10),
          Expanded(child: Text(tip, style: TextStyle(fontSize: 16))),
        ],
      ),
    );
  }
}

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    home: ReusePage(),
  ));
}
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class DropOffTracker extends StatefulWidget {
  @override
  _DropOffTrackerState createState() => _DropOffTrackerState();
}

class _DropOffTrackerState extends State<DropOffTracker> {
  final TextEditingController _trackingIdController = TextEditingController();
  String _dropOffStatus = "";

  Future<void> fetchDropOffStatus() async {
    final String trackingId = _trackingIdController.text.trim();
    if (trackingId.isEmpty) {
      setState(() => _dropOffStatus = "Please enter a Tracking ID.");
      return;
    }

    final String apiUrl =
        "https://script.google.com/macros/s/AKfycbz9DoC0e5RPM66gjIFdWHp5ilFKEDG8_C6kGNzjvlMAETf3Nwbr1uK58emut5IxuZ3l/exec?trackingId=$trackingId";
    // Replace with your Web App URL

    try {
      final response = await http.get(Uri.parse(apiUrl));

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        setState(() => _dropOffStatus = data['status'] ?? "Status unavailable.");
      } else {
        setState(() => _dropOffStatus = "Error fetching details. Try again.");
      }
    } catch (e) {
      setState(() => _dropOffStatus = "Network error. Check your connection.");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Track Drop-off Status")),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _trackingIdController,
              decoration: InputDecoration(labelText: "Enter Tracking ID"),
            ),
            SizedBox(height: 10),
            ElevatedButton(
              onPressed: fetchDropOffStatus,
              child: Text("Track Device"),
            ),
            SizedBox(height: 20),
            Text(
              _dropOffStatus,
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class DropOffPage extends StatefulWidget {
  @override
  _DropOffPageState createState() => _DropOffPageState();
}

class _DropOffPageState extends State<DropOffPage> {
  TextEditingController _trackingController = TextEditingController();
  String _status = "";
  String _pickupDate = "";
  String _message = "";

  Future<void> fetchTrackingInfo() async {
    String trackingID = _trackingController.text.trim();
    if (trackingID.isEmpty) {
      setState(() {
        _message = "Please enter a Tracking ID.";
      });
      return;
    }

    String apiUrl = "https://script.google.com/macros/s/YOUR_SCRIPT_ID/exec?trackingID=$trackingID";

    try {
      var response = await http.get(Uri.parse(apiUrl));
      if (response.statusCode == 200) {
        var data = jsonDecode(response.body);
        if (data["status"] != "Not Found") {
          setState(() {
            _status = data["status"];
            _pickupDate = data["pickupDate"];
            _message = "Status: $_status\nPickup Date: $_pickupDate";
          });
        } else {
          setState(() {
            _message = "Tracking ID not found.";
          });
        }
      } else {
        setState(() {
          _message = "Error fetching data.";
        });
      }
    } catch (e) {
      setState(() {
        _message = "Network error. Try again.";
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Track Your E-Waste")),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: _trackingController,
              decoration: InputDecoration(
                labelText: "Enter Tracking ID",
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 10),
            ElevatedButton(
              onPressed: fetchTrackingInfo,
              child: Text("Track Device"),
            ),
            SizedBox(height: 20),
            Text(_message, style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
          ],
        ),
      ),
    );
  }
}

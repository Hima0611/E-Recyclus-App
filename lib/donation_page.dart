import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:flutter/foundation.dart' show kIsWeb;

class DonationPage extends StatefulWidget {
  @override
  _DonationPageState createState() => _DonationPageState();
}

class _DonationPageState extends State<DonationPage> {
  final TextEditingController _itemController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  XFile? _media;
  bool isVideo = false;
  final ImagePicker _picker = ImagePicker();

  List<Map<String, String>> donations = [];

  @override
  void initState() {
    super.initState();
    _loadDonations();
  }

  void _loadDonations() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? donationsData = prefs.getString("donations");
    if (donationsData != null) {
      setState(() {
        donations = List<Map<String, String>>.from(json.decode(donationsData));
      });
    }
  }

  void _saveDonations() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString("donations", json.encode(donations));
  }

  void _addDonation() {
    if (_itemController.text.isNotEmpty &&
        _descriptionController.text.isNotEmpty &&
        _media != null) {
      setState(() {
        donations.add({
          "item": _itemController.text,
          "description": _descriptionController.text,
          "media": _media!.path,
          "isVideo": isVideo.toString(),
          "contact": "User${donations.length + 1}" // Mock user contact
        });
      });
      _saveDonations();
      _itemController.clear();
      _descriptionController.clear();
      setState(() {
        _media = null;
        isVideo = false;
      });
    }
  }

  Future<void> _pickMedia(bool pickVideo) async {
    final pickedFile = pickVideo
        ? await _picker.pickVideo(source: ImageSource.gallery)
        : await _picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      setState(() {
        _media = pickedFile;
        isVideo = pickVideo;
      });
    }
  }

  void _chatWithUser(String user) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text("Chat with $user"),
        content: TextField(
          decoration: InputDecoration(hintText: "Type your message..."),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text("Send"),
          )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("E-Waste Donation"),
        backgroundColor: Colors.green[700],
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.green[100]!, Colors.white],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              TextField(
                controller: _itemController,
                decoration: InputDecoration(
                  labelText: "Item Name",
                  border: OutlineInputBorder(),
                  filled: true,
                  fillColor: Colors.white,
                ),
              ),
              SizedBox(height: 10),
              TextField(
                controller: _descriptionController,
                decoration: InputDecoration(
                  labelText: "Description",
                  border: OutlineInputBorder(),
                  filled: true,
                  fillColor: Colors.white,
                ),
              ),
              SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                    onPressed: () => _pickMedia(false),
                    child: Text("Upload Image"),
                  ),
                  SizedBox(width: 10),
                  ElevatedButton(
                    onPressed: () => _pickMedia(true),
                    child: Text("Upload Video"),
                  ),
                ],
              ),
              SizedBox(height: 10),
              _media != null
                  ? isVideo
                  ? Icon(Icons.videocam, size: 100, color: Colors.red)
                  : kIsWeb
                  ? Image.network(_media!.path,
                  height: 100,
                  errorBuilder: (context, error, stackTrace) =>
                      Icon(Icons.broken_image, size: 100))
                  : Image.file(File(_media!.path),
                  height: 100,
                  errorBuilder: (context, error, stackTrace) =>
                      Icon(Icons.broken_image, size: 100))
                  : Container(),
              SizedBox(height: 10),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green[700],
                  foregroundColor: Colors.white,
                ),
                onPressed: _addDonation,
                child: Text("Donate"),
              ),
              SizedBox(height: 10),
              Expanded(
                child: ListView.builder(
                  itemCount: donations.length,
                  itemBuilder: (context, index) {
                    return Card(
                      color: Colors.green[50],
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: ListTile(
                        leading: donations[index]["media"] != null
                            ? donations[index]["isVideo"] == "true"
                            ? Icon(Icons.videocam,
                            size: 50, color: Colors.red)
                            : kIsWeb
                            ? Image.network(donations[index]["media"]!,
                            width: 50,
                            height: 50,
                            fit: BoxFit.cover,
                            errorBuilder:
                                (context, error, stackTrace) =>
                                Icon(Icons.broken_image))
                            : Image.file(
                            File(donations[index]["media"]!),
                            width: 50,
                            height: 50,
                            fit: BoxFit.cover,
                            errorBuilder:
                                (context, error, stackTrace) =>
                                Icon(Icons.broken_image))
                            : Icon(Icons.recycling, color: Colors.green[800]),
                        title: Text(
                          donations[index]["item"]!,
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        subtitle: Text(donations[index]["description"]!),
                        trailing: IconButton(
                          icon: Icon(Icons.chat, color: Colors.blue),
                          onPressed: () =>
                              _chatWithUser(donations[index]["contact"]!),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
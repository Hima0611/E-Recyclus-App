import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:path_provider/path_provider.dart'; // 👈 for saving image locally
import 'package:path/path.dart'; // 👈 to use basename()

class SellPage extends StatefulWidget {
  @override
  _SellPageState createState() => _SellPageState();
}

class _SellPageState extends State<SellPage> {
  final _formKey = GlobalKey<FormState>();
  String? _deviceName;
  String? _deviceCondition;
  File? _image;

  Future<void> _pickImage() async {
    final picked = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (picked != null) {
      final File tempImage = File(picked.path);

      // Get local path to save the image
      final directory = await getApplicationDocumentsDirectory();
      final String filename = basename(picked.path);
      final File savedImage = await tempImage.copy('${directory.path}/$filename');

      setState(() {
        _image = savedImage; // Save image locally
      });

      print("Image saved to: ${savedImage.path}");
    }
  }

  void _submitForm(BuildContext context) {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Device submitted for review!')),
      );

      setState(() {
        _image = null;
        _deviceName = null;
        _deviceCondition = null;
        _formKey.currentState!.reset();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Sell Your Device"),
        backgroundColor: Colors.green.shade700,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(20),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              _image != null
                  ? Image.file(_image!, height: 150)
                  : GestureDetector(
                onTap: _pickImage,
                child: Container(
                  height: 150,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Center(
                    child: Text("Tap to upload image"),
                  ),
                ),
              ),
              SizedBox(height: 20),
              TextFormField(
                decoration: InputDecoration(
                  labelText: "Device Name",
                  border: OutlineInputBorder(),
                ),
                validator: (value) =>
                value == null || value.isEmpty ? "Required" : null,
                onSaved: (value) => _deviceName = value,
              ),
              SizedBox(height: 20),
              DropdownButtonFormField<String>(
                decoration: InputDecoration(
                  labelText: "Condition",
                  border: OutlineInputBorder(),
                ),
                items: ["Excellent", "Good", "Average", "Poor"]
                    .map((condition) => DropdownMenuItem(
                  value: condition,
                  child: Text(condition),
                ))
                    .toList(),
                validator: (value) =>
                value == null ? "Please select condition" : null,
                onChanged: (value) => _deviceCondition = value,
              ),
              SizedBox(height: 30),
              ElevatedButton.icon(
                icon: Icon(Icons.send),
                label: Text("Submit"),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green.shade700,
                  padding: EdgeInsets.symmetric(horizontal: 40, vertical: 15),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                onPressed: () => _submitForm(context), // 👈 fixed context issue
              )
            ],
          ),
        ),
      ),
    );
  }
}

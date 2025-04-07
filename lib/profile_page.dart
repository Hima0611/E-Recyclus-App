import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProfilePage extends StatefulWidget {
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  bool isEditing = false;

  TextEditingController nameController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController addressController = TextEditingController();

  @override
  void initState() {
    super.initState();
    loadProfileData();
  }

  Future<void> loadProfileData() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      nameController.text = prefs.getString('profile_name') ?? 'John Doe';
      phoneController.text = prefs.getString('profile_phone') ?? '+123 456 7890';
      emailController.text = prefs.getString('profile_email') ?? 'johndoe@example.com';
      addressController.text = prefs.getString('profile_address') ?? '123 Street, City, Country';
    });
  }

  Future<void> saveProfileData() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('profile_name', nameController.text);
    await prefs.setString('profile_phone', phoneController.text);
    await prefs.setString('profile_email', emailController.text);
    await prefs.setString('profile_address', addressController.text);

    setState(() {
      isEditing = false;
    });

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text("Profile updated locally!")),
    );
  }

  Future<void> changePassword() async {
    final prefs = await SharedPreferences.getInstance();
    showDialog(
      context: context,
      builder: (context) {
        TextEditingController newPasswordController = TextEditingController();
        return AlertDialog(
          title: Text("Change Password"),
          content: TextField(
            controller: newPasswordController,
            decoration: InputDecoration(labelText: "New Password"),
            obscureText: true,
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text("Cancel"),
            ),
            ElevatedButton(
              onPressed: () async {
                await prefs.setString('user_password', newPasswordController.text);
                Navigator.pop(context);
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text("Password changed successfully!")),
                );
              },
              child: Text("Save"),
            ),
          ],
        );
      },
    );
  }

  Future<void> logout() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.clear(); // Clear all saved data

    Navigator.pushReplacementNamed(context, '/login'); // Go to Login Page
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Profile"),
        actions: [
          IconButton(
            icon: Icon(isEditing ? Icons.close : Icons.edit),
            onPressed: () {
              setState(() {
                isEditing = !isEditing;
              });
            },
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            _buildTextField(Icons.person, "Name", nameController, isEditing),
            _buildTextField(Icons.phone, "Phone", phoneController, isEditing),
            _buildTextField(Icons.email, "Email", emailController, isEditing),
            _buildTextField(Icons.home, "Address", addressController, isEditing),

            SizedBox(height: 20),

            if (isEditing)
              ElevatedButton.icon(
                onPressed: saveProfileData,
                icon: Icon(Icons.save),
                label: Text("Save Changes"),
              ),

            ElevatedButton.icon(
              onPressed: changePassword,
              icon: Icon(Icons.lock),
              label: Text("Change Password"),
            ),
            ElevatedButton.icon(
              onPressed: logout,
              icon: Icon(Icons.logout),
              label: Text("Logout"),
              style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTextField(
      IconData icon, String label, TextEditingController controller, bool editable) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: TextField(
        controller: controller,
        readOnly: !editable,
        decoration: InputDecoration(
          prefixIcon: Icon(icon, color: Colors.green),
          labelText: label,
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
        ),
      ),
    );
  }
}

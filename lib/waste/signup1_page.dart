import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SignUpPage extends StatefulWidget {
  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  Future<void> signUpUser() async {
    final email = emailController.text.trim();
    final username = usernameController.text.trim();
    final phone = phoneController.text.trim();
    final password = passwordController.text;

    final emailValid = email.endsWith("@gmail.com");
    final phoneValid = RegExp(r'^[0-9]{10}$').hasMatch(phone);
    final passwordValid = RegExp(
        r'^(?=.*[A-Za-z])(?=.*\d)(?=.*[!@#\$%^&*(),.?":{}|<>]).{8,}$'
    ).hasMatch(password);

    if (!emailValid) {
      showError("Email must end with @gmail.com");
      return;
    }

    if (!phoneValid) {
      showError("Phone number must be exactly 10 digits");
      return;
    }

    if (!passwordValid) {
      showError("Password must be at least 8 characters long and include letters, numbers, and symbols");
      return;
    }

    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('email', email);
    await prefs.setString('username', username);
    await prefs.setString('phone', phone);
    await prefs.setString('password', password);

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Sign-Up Successful!')),
    );

    Navigator.pushReplacementNamed(context, '/login');
  }

  void showError(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message), backgroundColor: Colors.red),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.lightGreen[100],
      appBar: AppBar(title: Text("Sign Up")),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              width: double.infinity,
              color: Colors.lightGreen[100],
              padding: EdgeInsets.symmetric(vertical: 30),
              child: Center(
                child: CircleAvatar(
                  radius: 140, // ⬅️ Increased size
                  backgroundImage: AssetImage('images/signup1.jpeg'),
                  backgroundColor: Colors.white,
                ),
              ),
            ),
            SizedBox(height: 30), // ⬅️ Extra spacing between image and form
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(15),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.green.shade200,
                      blurRadius: 10,
                      offset: Offset(0, 5),
                    ),
                  ],
                ),
                child: Column(
                  children: [
                    TextField(
                      controller: emailController,
                      decoration: InputDecoration(
                        labelText: "Email",
                        border: OutlineInputBorder(),
                      ),
                    ),
                    SizedBox(height: 15),
                    TextField(
                      controller: usernameController,
                      decoration: InputDecoration(
                        labelText: "Username",
                        border: OutlineInputBorder(),
                      ),
                    ),
                    SizedBox(height: 15),
                    TextField(
                      controller: phoneController,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        labelText: "Phone Number",
                        border: OutlineInputBorder(),
                      ),
                    ),
                    SizedBox(height: 15),
                    TextField(
                      controller: passwordController,
                      decoration: InputDecoration(
                        labelText: "Password",
                        border: OutlineInputBorder(),
                      ),
                      obscureText: true,
                    ),
                    SizedBox(height: 20),
                    ElevatedButton(
                      onPressed: signUpUser,
                      child: Text("Sign Up"),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 40), // optional bottom spacing
          ],
        ),
      ),
    );
  }
}

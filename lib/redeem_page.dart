import 'package:flutter/material.dart';

class RedeemPage extends StatelessWidget {
  final String itemName;
  final int cost;
  final VoidCallback onRedeem;

  const RedeemPage({
    Key? key,
    required this.itemName,
    required this.cost,
    required this.onRedeem,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.green.shade50,
      appBar: AppBar(
        title: Text("Redeem Reward"),
        backgroundColor: Colors.green.shade700,
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.check_circle_outline,
                  size: 100, color: Colors.green.shade700),
              SizedBox(height: 20),
              Text(
                "Congratulations!",
                style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.green.shade800),
              ),
              SizedBox(height: 10),
              Text(
                "You've successfully redeemed:\n$itemName\nfor $cost points.",
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 18, color: Colors.black87),
              ),
              SizedBox(height: 30),
              ElevatedButton(
                onPressed: () {
                  onRedeem(); // Callback to deduct points
                  Navigator.pop(context);
                },
                child: Text("Done"),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green.shade700,
                  padding:
                  EdgeInsets.symmetric(horizontal: 30, vertical: 14),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

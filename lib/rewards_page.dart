import 'dart:math';
import 'package:flutter/material.dart';
import 'package:confetti/confetti.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:scratcher/scratcher.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:intl/intl.dart';
import 'redeem_page.dart';

class RewardPage extends StatefulWidget {
  @override
  _RewardPageState createState() => _RewardPageState();
}

class _RewardPageState extends State<RewardPage> {
  late ConfettiController _confettiController;
  bool _revealed = false;
  int userPoints = 0;
  int todayPoints = 0;
  String todayDate = DateFormat('yyyy-MM-dd').format(DateTime.now());
  List<String> pointsHistory = [];

  final Map<int, String> rewardOptions = {
    100: "🎧 Wireless Earbuds",
    200: "📱 Smart Watch",
    400: "🎮 Gaming Mouse",
    500: "🖥 Monitor",
    800: "📺 Smart TV",
    1000: "💻 Laptop",
  };

  @override
  void initState() {
    super.initState();
    _confettiController = ConfettiController(duration: Duration(seconds: 3));
    _initRewards();
  }

  Future<void> _initRewards() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? lastPlayedDate = prefs.getString('lastPlayedDate');

    if (lastPlayedDate != todayDate) {
      todayPoints = Random().nextInt(51);
      await prefs.setString('lastPlayedDate', todayDate);
      await prefs.setInt('todayPoints', todayPoints);
      await prefs.setBool('revealed', false);
    } else {
      todayPoints = prefs.getInt('todayPoints') ?? 0;
    }

    setState(() {
      userPoints = prefs.getInt('userPoints') ?? 0;
      _revealed = prefs.getBool('revealed') ?? false;
      pointsHistory = prefs.getStringList('pointsHistory') ?? [];
    });
  }

  Future<void> _updateUserPoints(int points) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      userPoints += points;
    });
    await prefs.setInt('userPoints', userPoints);
    _savePointsHistory(points);
  }

  Future<void> _savePointsHistory(int points) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String entry = "$todayDate: +$points points";
    pointsHistory.insert(0, entry);
    await prefs.setStringList('pointsHistory', pointsHistory);
  }

  Future<void> _markRevealed() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool('revealed', true);
  }

  void _revealReward() {
    if (!_revealed) {
      setState(() {
        _revealed = true;
      });
      _updateUserPoints(todayPoints);
      _markRevealed();
      _confettiController.play();
    }
  }

  Widget _buildRewardCard() {
    String rewardText = "🎉 You won $todayPoints points! 🎉";
    if (rewardOptions.containsKey(userPoints)) {
      rewardText =
      "🎁 Congrats! You've unlocked: ${rewardOptions[userPoints]}!";
    }

    final rewardContent = Container(
      width: 250,
      height: 150,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [Colors.yellow.shade600, Colors.orange.shade400],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(color: Colors.black26, blurRadius: 8, offset: Offset(2, 4))
        ],
      ),
      child: Text(
        rewardText,
        style: TextStyle(
            fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white),
        textAlign: TextAlign.center,
      ),
    );

    if (kIsWeb) {
      return GestureDetector(
        onTap: _revealReward,
        child: AnimatedOpacity(
          duration: Duration(milliseconds: 300),
          opacity: 1.0,
          child: _revealed
              ? rewardContent
              : Container(
            width: 250,
            height: 150,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [Colors.grey.shade400, Colors.grey.shade500],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.circular(16),
              boxShadow: [
                BoxShadow(
                    color: Colors.black26,
                    blurRadius: 8,
                    offset: Offset(2, 4))
              ],
            ),
            child: Text(
              "Tap to reveal",
              style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.white),
            ),
          ),
        ),
      );
    } else {
      return Scratcher(
        brushSize: 30,
        threshold: 30,
        accuracy: ScratchAccuracy.low,
        color: Colors.grey.shade600,
        onThreshold: _revealReward,
        child: rewardContent,
      );
    }
  }

  Widget _buildRewardMilestones() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: 30),
        Text(
          "🎁 Tap a reward to redeem:",
          style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.green.shade800),
        ),
        SizedBox(height: 10),
        ...rewardOptions.entries.map((entry) => GestureDetector(
          onTap: () {
            if (userPoints >= entry.key) {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => RedeemPage(
                    itemName: entry.value,
                    cost: entry.key,
                    onRedeem: () {
                      setState(() {
                        userPoints -= entry.key;
                      });
                    },
                  ),
                ),
              );
            } else {
              int needed = entry.key - userPoints;
              showDialog(
                context: context,
                builder: (_) => AlertDialog(
                  title: Text("Not enough points"),
                  content: Text(
                    "You need $needed more points to unlock ${entry.value}.",
                  ),
                  actions: [
                    TextButton(
                      child: Text("OK"),
                      onPressed: () => Navigator.pop(context),
                    )
                  ],
                ),
              );
            }
          },
          child: Card(
            color: Colors.white,
            elevation: 4,
            margin: EdgeInsets.symmetric(vertical: 8),
            child: ListTile(
              leading: CircleAvatar(
                backgroundColor: Colors.green.shade700,
                child: Text(
                  entry.key.toString(),
                  style: TextStyle(
                      color: Colors.white, fontWeight: FontWeight.bold),
                ),
              ),
              title: Text(
                entry.value,
                style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: Colors.black87),
              ),
              trailing: Icon(Icons.card_giftcard,
                  color: Colors.orange.shade600),
            ),
          ),
        ))
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('E-Recyclus Rewards'),
        backgroundColor: Colors.green.shade700,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                "Points: $userPoints",
                style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: Colors.green.shade900),
              ),
            ),
            SizedBox(height: 20),
            Center(
              child: Stack(
                alignment: Alignment.center,
                children: [
                  _buildRewardCard(),
                  ConfettiWidget(
                    confettiController: _confettiController,
                    blastDirectionality: BlastDirectionality.explosive,
                    shouldLoop: false,
                    colors: [
                      Colors.green,
                      Colors.orange,
                      Colors.yellow,
                      Colors.pink
                    ],
                  ),
                ],
              ),
            ),
            SizedBox(height: 30),
            _buildRewardMilestones(),
          ],
        ),
      ),
    );
  }
}

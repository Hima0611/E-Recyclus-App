import 'dart:async';
import 'dart:math';
import 'package:flutter/material.dart';

class RobotGame extends StatefulWidget {
  @override
  _RobotGameState createState() => _RobotGameState();
}

class _RobotGameState extends State<RobotGame> {
  double _playerX = 0; // Robot's position
  double _fallingItemX = Random().nextDouble() * 2 - 1; // Random X position
  double _fallingItemY = -1; // Start above the screen
  int _score = 0;
  bool _gameOver = false;
  String _fallingItemType = "Recyclable"; // Can be "Recyclable" or "Hazardous"
  late Timer _gameTimer;

  void _startGame() {
    _score = 0;
    _gameOver = false;
    _fallingItemY = -1;
    _spawnNewItem();
    _gameTimer = Timer.periodic(Duration(milliseconds: 50), (timer) {
      setState(() {
        _fallingItemY += 0.03; // Item falls
        if (_fallingItemY > 0.8) {
          _checkCollision();
        }
      });
    });
  }

  void _spawnNewItem() {
    setState(() {
      _fallingItemX = Random().nextDouble() * 2 - 1; // Random X position
      _fallingItemY = -1; // Reset position
      _fallingItemType = Random().nextBool() ? "Recyclable" : "Hazardous";
    });
  }

  void _checkCollision() {
    if ((_playerX - _fallingItemX).abs() < 0.2) {
      if (_fallingItemType == "Recyclable") {
        _score += 10;
        _spawnNewItem();
      } else {
        _gameOver = true;
        _gameTimer.cancel();
      }
    } else {
      _spawnNewItem();
    }
  }

  void _movePlayer(String direction) {
    setState(() {
      if (direction == "left" && _playerX > -1) _playerX -= 0.3;
      if (direction == "right" && _playerX < 1) _playerX += 0.3;
    });
  }

  void _restartGame() {
    _startGame();
  }

  @override
  void initState() {
    super.initState();
    _startGame();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(title: const Text("Robot Game")), // Added AppBar for navigation
      body: Center(
        child: _gameOver
            ? Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("Game Over!", style: TextStyle(fontSize: 32, color: Colors.redAccent, fontWeight: FontWeight.bold)),
            SizedBox(height: 10),
            Text("Your Score: $_score", style: TextStyle(fontSize: 24, color: Colors.white)),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _restartGame,
              child: Text("Restart"),
              style: ElevatedButton.styleFrom(backgroundColor: Colors.blue),
            ),
          ],
        )
            : Stack(
          children: [
            Align(
              alignment: Alignment(0, -0.9),
              child: Text(
                "Score: $_score",
                style: TextStyle(fontSize: 22, color: Colors.white),
              ),
            ),
            AnimatedAlign(
              alignment: Alignment(_fallingItemX, _fallingItemY),
              duration: Duration(milliseconds: 50),
              child: Icon(
                _fallingItemType == "Recyclable" ? Icons.battery_charging_full : Icons.warning,
                size: 50,
                color: _fallingItemType == "Recyclable" ? Colors.greenAccent : Colors.redAccent,
              ),
            ),
            Align(
              alignment: Alignment(_playerX, 0.8),
              child: Icon(Icons.android, size: 60, color: Colors.blue),
            ),
            Align(
              alignment: Alignment(0, 0.95),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                    onPressed: () => _movePlayer("left"),
                    child: Icon(Icons.arrow_left, size: 30),
                  ),
                  SizedBox(width: 20),
                  ElevatedButton(
                    onPressed: () => _movePlayer("right"),
                    child: Icon(Icons.arrow_right, size: 30),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

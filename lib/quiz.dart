import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: EWasteQuizGame(),
    );
  }
}

class EWasteQuizGame extends StatefulWidget {
  @override
  _EWasteQuizGameState createState() => _EWasteQuizGameState();
}

class _EWasteQuizGameState extends State<EWasteQuizGame> {
  int _score = 0;
  int _questionIndex = 0;
  bool _gameOver = false;

  final List<Map<String, dynamic>> _questions = [
    {'question': 'What is e-waste?', 'options': ['Electronic waste', 'Environmental waste', 'Energy waste', 'Earth waste'], 'answer': 'Electronic waste'},
    {'question': 'Which of these is NOT considered e-waste?', 'options': ['Old smartphone', 'Broken laptop', 'Plastic bottle', 'Used batteries'], 'answer': 'Plastic bottle'},
    {'question': 'Which metal is commonly found in e-waste?', 'options': ['Gold', 'Aluminum', 'Silver', 'All of the above'], 'answer': 'All of the above'},
    {'question': 'How should e-waste be disposed of?', 'options': ['Thrown in garbage', 'Burned', 'Recycled properly', 'Buried underground'], 'answer': 'Recycled properly'},
    {'question': 'Which of these devices contributes to e-waste?', 'options': ['Television', 'Refrigerator', 'Smartwatch', 'All of the above'], 'answer': 'All of the above'},
    {'question': 'Which toxic material is commonly found in e-waste?', 'options': ['Lead', 'Mercury', 'Cadmium', 'All of the above'], 'answer': 'All of the above'},
    {'question': 'Which organization promotes responsible e-waste disposal?', 'options': ['WHO', 'UNESCO', 'EPA', 'NASA'], 'answer': 'EPA'},
    {'question': 'What is the best way to manage e-waste?', 'options': ['Reduce, Reuse, Recycle', 'Throw it away', 'Store in home', 'Ignore it'], 'answer': 'Reduce, Reuse, Recycle'}
  ];

  void _checkAnswer(String selectedOption) {
    if (!_gameOver) {
      if (selectedOption == _questions[_questionIndex]['answer']) {
        setState(() {
          _score += 10;
        });
      }

      if (_questionIndex < _questions.length - 1) { // ✅ Fixed total questions issue
        setState(() {
          _questionIndex++;
        });
      } else {
        setState(() {
          _gameOver = true;
        });
      }
    }
  }

  void _restartGame() {
    setState(() {
      _score = 0;
      _questionIndex = 0;
      _gameOver = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[900],
      appBar: AppBar(
        title: Text("E-Waste Awareness Quiz"),
        backgroundColor: Colors.green[700],
      ),
      body: Center(
        child: _gameOver
            ? Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("Game Over!", style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold, color: Colors.white)),
            SizedBox(height: 10),
            Text("Your total score: $_score", style: TextStyle(fontSize: 22, color: Colors.white)),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _restartGame,
              style: ElevatedButton.styleFrom(backgroundColor: Colors.green, padding: EdgeInsets.symmetric(horizontal: 30, vertical: 12)),
              child: Text("Play Again", style: TextStyle(fontSize: 18)),
            )
          ],
        )
            : Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text("Question ${_questionIndex + 1}/${_questions.length}", // ✅ Fixed question counter
                  style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Colors.greenAccent)),
              SizedBox(height: 20),
              Container(
                padding: EdgeInsets.all(16),
                decoration: BoxDecoration(color: Colors.grey[800], borderRadius: BorderRadius.circular(12)),
                child: Text(_questions[_questionIndex]['question'],
                    textAlign: TextAlign.center, style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.white)),
              ),
              SizedBox(height: 20),
              ..._questions[_questionIndex]['options'].map((option) {
                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 5.0),
                  child: ElevatedButton(
                    onPressed: () => _checkAnswer(option),
                    style: ElevatedButton.styleFrom(backgroundColor: Colors.green[600], padding: EdgeInsets.symmetric(vertical: 12)),
                    child: Text(option, style: TextStyle(fontSize: 18, color: Colors.white)),
                  ),
                );
              }).toList(),
              SizedBox(height: 20),
              Text("Score: $_score", style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Colors.yellowAccent)),
            ],
          ),
        ),
      ),
    );
  }
}

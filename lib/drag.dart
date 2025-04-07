import 'package:flutter/material.dart';
import 'dart:math';

class EWasteCollectorGame extends StatefulWidget {
  const EWasteCollectorGame({super.key});

  @override
  _EWasteCollectorGameState createState() => _EWasteCollectorGameState();
}

class _EWasteCollectorGameState extends State<EWasteCollectorGame> {
  int _score = 0;
  int _itemsSorted = 0;
  bool _gameOver = false;
  String? _draggingItem;

  final List<Map<String, dynamic>> _items = [
    {'name': 'Old Phone', 'category': 'Recycle'},
    {'name': 'Broken Laptop', 'category': 'Recycle'},
    {'name': 'Used Battery', 'category': 'Hazardous'},
    {'name': 'CRT Monitor', 'category': 'Recycle'},
    {'name': 'Worn-out Headphones', 'category': 'Recycle'},
    {'name': 'Ink Cartridge', 'category': 'Hazardous'},
    {'name': 'Smartwatch', 'category': 'Reuse'},
    {'name': 'USB Cable', 'category': 'Recycle'},
    {'name': 'Old Keyboard', 'category': 'Reuse'},
    {'name': 'Damaged TV', 'category': 'Recycle'},
  ];

  final List<String> _bins = ['Recycle', 'Reuse', 'Hazardous'];

  void _checkDrop(String bin, String itemCategory) {
    setState(() {
      if (bin == itemCategory) {
        _score += 10;
      } else {
        _score -= 5;
      }
      _itemsSorted++;
      if (_itemsSorted == 10) {
        _gameOver = true;
      } else {
        _draggingItem = _items[Random().nextInt(_items.length)]['name'];
      }
    });
  }

  void _restartGame() {
    setState(() {
      _score = 0;
      _itemsSorted = 0;
      _gameOver = false;
      _draggingItem = _items[Random().nextInt(_items.length)]['name'];
    });
  }

  @override
  void initState() {
    super.initState();
    _draggingItem = _items[Random().nextInt(_items.length)]['name'];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF1A1A2E),
      appBar: AppBar(
        title: const Text("E-Waste Collector"),
        backgroundColor: const Color(0xFF16213E),
        centerTitle: true,
      ),
      body: Center(
        child: _gameOver
            ? Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              "Game Over!",
              style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold, color: Colors.redAccent),
            ),
            const SizedBox(height: 10),
            Text(
              "Your Total Score: $_score",
              style: const TextStyle(fontSize: 22, color: Colors.amberAccent),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _restartGame,
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blueAccent,
                padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 12),
              ),
              child: const Text("Play Again", style: TextStyle(fontSize: 18, color: Colors.white)),
            ),
          ],
        )
            : Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              "Drag & Drop the E-Waste Item",
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Colors.lightGreenAccent),
            ),
            const SizedBox(height: 20),
            Draggable<String>(
              data: _draggingItem,
              feedback: Material(
                color: Colors.transparent,
                child: Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.blueGrey,
                    borderRadius: BorderRadius.circular(12),
                    boxShadow: const [BoxShadow(color: Colors.black45, blurRadius: 5)],
                  ),
                  child: Text(
                    _draggingItem!,
                    style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.white),
                  ),
                ),
              ),
              childWhenDragging: Container(height: 50),
              child: Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  gradient: const LinearGradient(colors: [Colors.blueAccent, Colors.cyan]),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Text(
                  _draggingItem!,
                  style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.white),
                ),
              ),
            ),
            const SizedBox(height: 30),
            const Text(
              "Drop into the correct bin:",
              style: TextStyle(fontSize: 20, color: Colors.white),
            ),
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: _bins.map((bin) {
                return DragTarget<String>(
                  onAccept: (receivedItem) {
                    String category = _items.firstWhere((item) => item['name'] == receivedItem)['category'];
                    _checkDrop(bin, category);
                  },
                  builder: (context, candidateData, rejectedData) {
                    return Container(
                      width: 100,
                      height: 120,
                      alignment: Alignment.center,
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: bin == "Recycle"
                              ? [Colors.greenAccent, Colors.green]
                              : bin == "Reuse"
                              ? [Colors.orangeAccent, Colors.orange]
                              : [Colors.redAccent, Colors.red],
                        ),
                        borderRadius: BorderRadius.circular(12),
                        boxShadow: const [BoxShadow(color: Colors.black45, blurRadius: 5)],
                      ),
                      child: Text(
                        bin,
                        textAlign: TextAlign.center,
                        style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white),
                      ),
                    );
                  },
                );
              }).toList(),
            ),
            const SizedBox(height: 30),
            Text(
              "Score: $_score",
              style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Colors.amberAccent),
            ),
            const SizedBox(height: 10),
            Text(
              "Items Sorted: $_itemsSorted/10",
              style: const TextStyle(fontSize: 18, color: Colors.white),
            ),
          ],
        ),
      ),
    );
  }
}

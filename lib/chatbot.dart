import 'package:flutter/material.dart';

void main() {
  runApp(ERecycleChatbot());
}

class ERecycleChatbot extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: ChatScreen(),
    );
  }
}

class ChatScreen extends StatefulWidget {
  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final TextEditingController _controller = TextEditingController();
  final List<Map<String, String>> _messages = [];

  final Map<String, String> _qaDatabase = {
    "What is e-recycling?": "E-recycling is the process of reusing and recycling electronic devices to reduce e-waste.",
    "Where can I recycle my old phone?": "You can recycle your old phone at certified e-waste collection centers or through manufacturer take-back programs.",
    "Why is e-recycling important?": "E-recycling helps reduce environmental pollution and recover valuable materials from old devices.",
  };

  void _sendMessage(String message) {
    setState(() {
      _messages.add({"user": message});
      String response = _qaDatabase[message] ?? "Sorry, I don't have an answer for that.";
      _messages.add({"bot": response});
    });
    _controller.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("E-Recycle Chatbot")),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: _messages.length,
              itemBuilder: (context, index) {
                final entry = _messages[index].entries.first;
                final bool isUser = entry.key == "user";
                return Align(
                  alignment: isUser ? Alignment.centerRight : Alignment.centerLeft,
                  child: Container(
                    padding: EdgeInsets.all(10),
                    margin: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                    decoration: BoxDecoration(
                      color: isUser ? Colors.blue[200] : Colors.green[200],
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Text(entry.value),
                  ),
                );
              },
            ),
          ),
          Padding(
            padding: EdgeInsets.all(10),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _controller,
                    decoration: InputDecoration(
                      hintText: "Ask a question...",
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
                IconButton(
                  icon: Icon(Icons.send),
                  onPressed: () {
                    if (_controller.text.trim().isNotEmpty) {
                      _sendMessage(_controller.text.trim());
                    }
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
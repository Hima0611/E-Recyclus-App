import 'package:flutter/material.dart';

void main() {
  runApp(LearnEWasteApp());
}

class LearnEWasteApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Learn About E-Waste',
      theme: ThemeData(
        primarySwatch: Colors.green,
      ),
      home: HomeScreen(),
    );
  }
}

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Learn About E-Waste")),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              "What is E-Waste?",
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 10),
            Text(
              "Electronic waste (e-waste) refers to discarded electronic devices like phones, laptops, and TVs. These contain harmful substances and should be disposed of properly.",
              style: TextStyle(fontSize: 16),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => EWasteTypesScreen()));
              },
              child: Text("Types of E-Waste"),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => ImpactScreen()));
              },
              child: Text("Impact of E-Waste"),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => DisposalMethodsScreen()));
              },
              child: Text("How to Dispose of E-Waste"),
            ),
          ],
        ),
      ),
    );
  }
}

class EWasteTypesScreen extends StatelessWidget {
  final List<Map<String, String>> ewasteTypes = [
    {"title": "📱 Mobile Phones & Tablets", "description": "These devices contain lithium-ion batteries, rare earth metals, and plastic. Improper disposal can lead to toxic chemical leaks. Recycling allows the recovery of gold, silver, and other valuable materials."},
    {"title": "💻 Laptops & Computers", "description": "Laptops and computers have components like motherboards, RAM, and processors that contain gold, platinum, and hazardous substances like lead. Recycling helps in resource recovery and prevents environmental pollution."},
    {"title": "📺 TVs & Monitors", "description": "CRT monitors contain lead and phosphor dust, while modern LCDs and LEDs have mercury and other chemicals. Proper recycling ensures these toxic materials do not contaminate the environment."},
    {"title": "🔋 Batteries & Chargers", "description": "Batteries, including lithium-ion and nickel-cadmium types, contain hazardous chemicals. If not disposed of properly, they can leak harmful substances into the soil and water. Recycling extracts reusable metals and prevents contamination."},
    {"title": "❄ Refrigerators & ACs", "description": "Refrigerators and ACs contain refrigerants like CFCs and HFCs that harm the ozone layer. Safe recycling ensures proper handling of cooling gases and salvaging of metals and plastic for reuse."}
  ];


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Types of E-Waste")),
      body: ListView.builder(
        itemCount: ewasteTypes.length,
        itemBuilder: (context, index) {
          return Card(
            margin: EdgeInsets.all(8),
            child: ListTile(
              leading: Icon(Icons.devices),
              title: Text(ewasteTypes[index]["title"]!),
              trailing: Icon(Icons.arrow_forward_ios),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => EWasteDetailScreen(
                      title: ewasteTypes[index]["title"]!,
                      description: ewasteTypes[index]["description"]!,
                    ),
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }
}

class EWasteDetailScreen extends StatelessWidget {
  final String title;
  final String description;

  EWasteDetailScreen({required this.title, required this.description});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(title)),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              title,
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 10),
            Text(
              description,
              style: TextStyle(fontSize: 16),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}

class ImpactScreen extends StatelessWidget {
  final List<String> impacts = [
    "E-waste contains toxic materials like lead and mercury, harming the environment.",
    "Improper disposal leads to soil and water pollution.",
    "Burning e-waste releases hazardous gases into the air.",
    "E-waste recycling can recover valuable materials like gold and copper."
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Impact of E-Waste")),
      body: ListView.builder(
        itemCount: impacts.length,
        itemBuilder: (context, index) {
          return Card(
            margin: EdgeInsets.all(8),
            child: ListTile(
              leading: Icon(Icons.warning, color: Colors.red),
              title: Text(impacts[index]),
            ),
          );
        },
      ),
    );
  }
}

class DisposalMethodsScreen extends StatelessWidget {
  final List<String> disposalMethods = [
    "Take e-waste to authorized recycling centers.",
    "Donate or sell working electronics.",
    "Return old devices to manufacturers for recycling.",
    "Use certified e-waste disposal services."
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("How to Dispose of E-Waste")),
      body: ListView.builder(
        itemCount: disposalMethods.length,
        itemBuilder: (context, index) {
          return Card(
            margin: EdgeInsets.all(8),
            child: ListTile(
              leading: Icon(Icons.recycling, color: Colors.green),
              title: Text(disposalMethods[index]),
            ),
          );
        },
      ),
    );
  }
}

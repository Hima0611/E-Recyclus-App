import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class EwasteNewsPage extends StatefulWidget {
  @override
  _EwasteNewsPageState createState() => _EwasteNewsPageState();
}

class _EwasteNewsPageState extends State<EwasteNewsPage> {
  List articles = [
    {
      'title': '📺 The E-Waste Problem Explained',
      'url': 'https://youtu.be/GNCGwYq8VcE?si=N7QHbKsWOjeLAH57',
      'source': {'name': 'YouTube'},
      'urlToImage': 'https://img.youtube.com/vi/GNCGwYq8VcE/0.jpg',
    },
    {
      'title': '📺 How E-Waste Affects Our Environment',
      'url': 'https://youtu.be/QuBy6YzLMn0?si=WMT2LTUlul3Zok7q',
      'source': {'name': 'YouTube'},
      'urlToImage': 'https://img.youtube.com/vi/QuBy6YzLMn0/0.jpg',
    },
    {
      'title': '📺 Why E-Waste Recycling is Important',
      'url': 'https://youtu.be/ApdkhWd7SfQ?si=xYhKru5-kE47Rrxd',
      'source': {'name': 'YouTube'},
      'urlToImage': 'https://img.youtube.com/vi/ApdkhWd7SfQ/0.jpg',
    },
  ];

  List<String> facts = [
    "🔋 Over 50 million tons of e-waste are produced yearly.",
    "♻ Only 20% of e-waste is properly recycled.",
    "💰 Recycling e-waste can recover gold, silver, and platinum.",
    "⚠ Toxic elements like lead & mercury leak from e-waste.",
    "🔌 The world generates *6 kg of e-waste per person per year*.",
    "📱 An average smartphone has 60+ different materials inside.",
    "🌍 E-waste contributes to *70% of toxic landfill waste*.",
  ];

  void _openUrl(String url) async {
    final Uri uri = Uri.parse(url);
    if (!await launchUrl(uri, mode: LaunchMode.externalApplication)) {
      print("Could not launch $url");
    }
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          title: Text('♻ E-Waste Awareness', style: TextStyle(fontSize: 22)),
          flexibleSpace: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [Colors.green.shade700, Colors.teal.shade400],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
          ),
          bottom: TabBar(
            indicatorColor: Colors.white,
            tabs: [
              Tab(
                  icon: Icon(Icons.newspaper, color: Colors.white),
                  text: "News"),
              Tab(
                  icon: Icon(Icons.lightbulb, color: Color(0xffeded03)),
                  text: "Facts"),
              Tab(
                  icon: Icon(Icons.book, color: Color(0xff26bf08)),
                  text: "Articles"),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            // *News Section*
            ListView.builder(
              itemCount: articles.length,
              itemBuilder: (context, index) {
                return Card(
                  color: Colors.greenAccent.shade100,
                  elevation: 5,
                  margin: EdgeInsets.all(10),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12)),
                  child: ListTile(
                    leading: articles[index]['urlToImage'] != null
                        ? ClipRRect(
                      borderRadius: BorderRadius.circular(8),
                      child: Image.network(
                        articles[index]['urlToImage'],
                        width: 80,
                        height: 80,
                        fit: BoxFit.cover,
                      ),
                    )
                        : Icon(Icons.image_not_supported,
                        color: Colors.redAccent),
                    title: Text(
                      articles[index]['title'],
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    subtitle: Text(articles[index]['source']['name'],
                        style: TextStyle(color: Colors.grey[700])),
                    trailing: Icon(Icons.arrow_forward_ios, color: Colors.teal),
                    onTap: () => _openUrl(articles[index]['url']),
                  ),
                );
              },
            ),

            // *Facts Section*
            ListView.builder(
              itemCount: facts.length,
              itemBuilder: (context, index) {
                return Card(
                  color: Color(0xff98de7b),
                  shadowColor: Color(0xff76b76e),
                  elevation: 5,
                  margin: EdgeInsets.all(10),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12)),
                  child: ListTile(
                    leading:
                    Icon(FontAwesomeIcons.recycle, color: Colors.green),
                    title: Text(
                      facts[index],
                      style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.brown[800]),
                    ),
                  ),
                );
              },
            ),

            // *Articles Section*
            ListView(
              padding: EdgeInsets.all(10),
              children: [
                ArticleCard(
                  title: "🌎 The Environmental Impact of E-Waste",
                  content:
                  "E-waste is one of the fastest-growing waste problems in the world. Improper disposal can pollute water, soil, and air, leading to health issues.",
                ),
                ArticleCard(
                  title: "🔄 How to Properly Recycle Old Electronics",
                  content:
                  "You can recycle old electronics at certified e-waste recycling centers. Some companies offer trade-in programs for old devices.",
                ),
                ArticleCard(
                  title: "🏭 E-Waste and the Circular Economy",
                  content:
                  "A circular economy aims to reduce waste by reusing and recycling materials, minimizing environmental damage.",
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

// *Widget for Displaying Articles*
class ArticleCard extends StatelessWidget {
  final String title;
  final String content;

  ArticleCard({required this.title, required this.content});

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.blue.shade100,
      shadowColor: Colors.blueAccent,
      elevation: 5,
      margin: EdgeInsets.symmetric(vertical: 8),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(title,
                style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.indigo[900])),
            SizedBox(height: 8),
            Text(content,
                style: TextStyle(fontSize: 14, color: Colors.black87)),
          ],
        ),
      ),
    );
  }
}
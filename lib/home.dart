import 'package:flutter/material.dart';
import 'drop_off_tracker.dart';
import 'learn_e_waste.dart';
import 'three_r_page.dart';
import 'care_our_world_screen.dart';
import 'just_recycle_screen.dart';
import 'faq.dart';
import 'games.dart';
import 'package:e_recycle_app/screens/chat_screen.dart';
import 'pick_up.dart';
import 'package:provider/provider.dart';
import 'theme_provider.dart';
import 'ewaste_awareness_page.dart';
void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => ThemeProvider()),
      ],
      child: const MyApp(),
    ),
  );

}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<ThemeProvider>(
      builder: (context, themeProvider, child) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'E-Waste Recycling App',
          theme: ThemeData(
            brightness: Brightness.light,
            primarySwatch: Colors.green,
            scaffoldBackgroundColor: Colors.grey[100],
            appBarTheme: const AppBarTheme(backgroundColor: Colors.green),
          ),
          darkTheme: ThemeData(
            brightness: Brightness.dark,
            primarySwatch: Colors.green,
            scaffoldBackgroundColor: Colors.black,
            appBarTheme: const AppBarTheme(backgroundColor: Colors.black),
          ),
          themeMode: themeProvider.isDarkMode ? ThemeMode.dark : ThemeMode.light,
          home: const HomePage(),
        );
      },
    );
  }
}


class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('E-Waste Recycling'),
        actions: [
          IconButton(
            icon: Icon(themeProvider.isDarkMode ? Icons.laptop : Icons.power),
            onPressed: () {
              themeProvider.toggleTheme();
            },
          ),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.all(16.0),
        children: <Widget>[
          _buildHeroSection(context),
          const SizedBox(height: 20),
          _buildSectionTitle('Explore Our Services'),
          Row(
            children: <Widget>[
              Expanded(
                child: _buildFeatureCard(
                  Icons.delete_outline,
                  'Schedule Pickup',
                      () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) =>  PickupScheduleScreen()),
                    );

                  },
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: _buildFeatureCard(
                  Icons.location_on,
                  'Find Drop-off',
                      () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => DropOffTracker()),
                    );
                  },
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: _buildFeatureCard(
                  Icons.info_outline,
                  'Learn About E-Waste',
                      () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) =>  HomeScreen()), // Replace with actual screen
                    );
                  },
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),
          _buildChatbotWidget(context), // Added the chatbot widget
          const SizedBox(height: 20),
          _buildSectionTitle('Get Involved'),
          Row(
            children: <Widget>[
              Expanded(
                child: _buildInfoCard(
                  'Just Recycle',
                  'images/home.png', // Ensure these image assets exist
                      () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const JustRecycleScreen()),
                    );
                  },
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: _buildInfoCard(
                  'Three R',
                  'images/2.png', // Ensure these image assets exist
                      () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const ThreeRPage()),
                    );
                  },
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: _buildInfoCard(
                  'Care Our World',
                  'images/1.png', // Ensure these image assets exist
                      () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) =>  CareOurWorldScreen()),
                    );
                  },
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),
          _buildGameWidget(context),
          const SizedBox(height: 20),
          _buildCallToAction(context),
          const SizedBox(height: 30),
          const Text(
            'Developed in Batala, Punjab, India',
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 12, color: Colors.grey),
          ),
        ],
      ),
    );
  }

  Widget _buildHeroSection(BuildContext context) {
    return Card(
      elevation: 4,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Image.asset(
              'images/bin.png',
              height: 150,
              fit: BoxFit.contain,
            ),
            const SizedBox(height: 16),
            const Text(
              'Recycle Your E-Waste Responsibly',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            const Text(
              'Join us in creating a greener future by recycling your old electronics.',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => EwasteAwarenessPage()),
                );
              },
              child: const Text('E-waste Awareness'),
            ),
          ],
        ),
      ),
    );
  }


  // Section Title
  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Text(
        title,
        style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
      ),
    );
  }

  // Feature Card
  Widget _buildFeatureCard(IconData icon, String title, VoidCallback onTap) {
    return InkWell(
      onTap: onTap,
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Icon(icon, size: 30, color: Colors.green),
              const SizedBox(height: 8),
              Text(
                title,
                textAlign: TextAlign.center,
                style: const TextStyle(fontSize: 14),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Info Card
  Widget _buildInfoCard(String title, String image, VoidCallback onTap) {
    return InkWell(
      onTap: onTap,
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: <Widget>[
              Image.asset(
                image,
                height: 80,
                fit: BoxFit.contain,
              ),
              const SizedBox(height: 8),
              Text(
                title,
                textAlign: TextAlign.center,
                style: const TextStyle(fontWeight: FontWeight.w500),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Game Widget
  Widget _buildGameWidget(BuildContext context) {
    return Card(
      color: Colors.blue[100],
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: <Widget>[
            const Text(
              'Play & Learn!',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
            ),
            const SizedBox(height: 12),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const GamesPage()),
                );
              },
              child: const Text('Play Now'),
            ),
          ],
        ),
      ),
    );
  }

  // Call to Action
  Widget _buildCallToAction(BuildContext context) {
    return Card(
      color: Colors.lightGreen[100],
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: <Widget>[
            const Text(
              'Ready to Make a Difference',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
            ),
            const SizedBox(height: 12),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) =>  FAQScreen()),
                );
              },
              child: const Text('FAQ'),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildChatbotWidget(BuildContext context) {
    return Card(
      color: Colors.deepOrange[50],
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: <Widget>[
            const Text(
              'Chat with us!',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
            ),
            const SizedBox(height: 12),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => ChatScreen()),
                );
              },
              child: const Text('Start Chat'),
            ),
          ],
        ),
      ),
    );
  }}
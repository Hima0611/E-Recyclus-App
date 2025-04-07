import 'package:e_recycle_app/screens/map_screen.dart';
import 'package:flutter/material.dart';
import 'package:e_recycle_app/home.dart';
import 'package:e_recycle_app/donate_page.dart';
import 'rewards_page.dart';
import 'profile_page.dart';
import 'donation_page.dart';
import 'about_us.dart';
import 'sell_page.dart';
class BottomNavBar extends StatefulWidget {
  @override
  _BottomNavBarState createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomNavBar> {
  int _selectedIndex = 0;

  final List<Widget> _pages = [
    HomePage(),   // Home Page
    EwasteMapScreen(),    // Map Page
    DonationPage(),
    SellPage(), // Donate Page
    RewardPage(), // Rewards Page
    ProfilePage(),
    AboutUsPage(),
    // Profile Page
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.map), label: 'Map'),
          BottomNavigationBarItem(icon: Icon(Icons.volunteer_activism), label: 'Donate'),
          BottomNavigationBarItem(icon: Icon(Icons.shopping_cart), label: 'Sell'),
          BottomNavigationBarItem(icon: Icon(Icons.card_giftcard), label: 'Rewards'),

          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'),
          BottomNavigationBarItem(icon: Icon(Icons.info_outline), label: 'About Us'), // New tab


        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.green,
        unselectedItemColor: Colors.grey,
        onTap: _onItemTapped,
        type: BottomNavigationBarType.fixed,
      ),
    );
  }
}

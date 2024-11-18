import 'package:flutter/material.dart';

import 'package:nirva/Pages/mainmenu_page.dart';
import 'package:nirva/Pages/profile.dart';
import 'package:nirva/Pages/progress.dart';
import 'package:nirva/Pages/shop.dart';
import 'package:nirva/pages/Reminder/reminder_page.dart';
import 'Breathing/Breathing.dart';
import 'Meditation/Meditation.dart';
import 'package:nirva/hotbar/hotbar_navigation.dart';  // Make sure this import is correct for your project

class BreathAndMeditationScreen extends StatefulWidget {
  const BreathAndMeditationScreen({super.key});

  @override
  State<BreathAndMeditationScreen> createState() => _BreathAndMeditationScreenState();
}

class _BreathAndMeditationScreenState extends State<BreathAndMeditationScreen> {
  int _currentIndex = 1; // Set initial index for the bottom navigation

  // Define card item widget
  Widget cardItem(String title, String imagePath, Widget destinationScreen) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      padding: EdgeInsets.all(10.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15.0),
        boxShadow: [
          BoxShadow(
            color: const Color.fromARGB(255, 141, 141, 141).withOpacity(0.3),
            spreadRadius: 2,
            blurRadius: 5,
            offset: Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(10.0),
            child: Image.asset(
              imagePath,
              fit: BoxFit.cover,
              height: 220,
              width: double.infinity,
            ),
          ),
          SizedBox(height: 10.0),
          Text(
            title,
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          Align(
            alignment: Alignment.bottomRight,
            child: ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => destinationScreen),
                );
              },
              style: ElevatedButton.styleFrom(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20.0),
                ),
                backgroundColor: Colors.blue,
              ),
              child: Text(
                "Start",
                style: TextStyle(color: Colors.white, fontSize: 15, fontWeight: FontWeight.bold),
              ),
            ),
          ),
        ],
      ),
    );
  }

  // Bottom navigation bar handler
  void _onTabTapped(int index) {
    setState(() {
      _currentIndex = index;
    });

    // Handle navigation based on index (if necessary)
    if (index == 0) {
      Navigator.push(context, MaterialPageRoute(builder: (context) => ReminderPage()));
    } else if (index == 2) {
      Navigator.push(context, MaterialPageRoute(builder: (context) => MainMenu()));
    } else if (index == 3) {
      Navigator.push(context, MaterialPageRoute(builder: (context) => ShopPage()));
    } else if (index == 4) {
      Navigator.push(context, MaterialPageRoute(builder: (context) => ProgressPageApp()));
    }
  }

  // Build method is required in every State class
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue.shade100,
        elevation: 0,
        leading: IconButton(
          icon: CircleAvatar(
            backgroundImage: AssetImage('assets/image/Profile.png'), // Replace with your profile image path
          ),
          onPressed: () {
            Navigator.push(context, MaterialPageRoute(builder: (context) => ProfilePage()));
          }, // Add navigation for profile if necessary
        ),
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.blue.shade100, const Color.fromARGB(255, 255, 255, 255)],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: ListView(
          padding: EdgeInsets.fromLTRB(0, 0, 0, 20.0),
          children: [
            cardItem(
              "Breathing Exercises",
              "assets/image/breathing.png", 
              BreathingScreen(),
            ),
            cardItem(
              "Meditation Sessions",
              "assets/image/meditation.png", 
              MeditationScreen(),
            ),
          ],
        ),
      ),
      bottomNavigationBar: HotbarNavigation(
        currentIndex: _currentIndex,
        onTap: _onTabTapped,
      ),
    );
  }
}

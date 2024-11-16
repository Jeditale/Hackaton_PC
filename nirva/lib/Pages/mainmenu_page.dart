import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:nirva/Pages/BreathAndMeditation.dart';
import 'package:nirva/Pages/Breathing/Breathing.dart';
import 'package:nirva/Pages/Meditation/Meditation.dart';
import 'package:nirva/Pages/Quiz/quiz_page.dart';
import 'package:nirva/Pages/shop.dart';
import 'package:nirva/pages/progress.dart';
import 'profile.dart';
import 'Reminder/reminder_page.dart';
import 'getpremium_page.dart';
import 'package:nirva/hotbar/hotbar_navigation.dart';

class MainMenu extends StatefulWidget {
  @override
  _MainMenuState createState() => _MainMenuState();
}

class _MainMenuState extends State<MainMenu> {
  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();
  int _currentIndex = 2; // Default to Main Menu (middle icon)

  @override
  void initState() {
    super.initState();
    _initializeNotifications();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    // Reset the index to Main Menu if returning to this page
    setState(() {
      _currentIndex = 2;
    });
  }

  // Notification Initialization
  void _initializeNotifications() async {
    var androidSettings = AndroidInitializationSettings('app_icon');
    var initializationSettings = InitializationSettings(
      android: androidSettings,
    );
    await flutterLocalNotificationsPlugin.initialize(initializationSettings);
  }

  // Switch tabs
  void _onTabTapped(int index) {
    if (index == _currentIndex) return; // Stay on the current page if reselected
    setState(() {
      _currentIndex = index;
    });

    if (index == 0) {
      Navigator.push(context, MaterialPageRoute(builder: (context) => ReminderPage()));
    } else if (index == 1) {
      Navigator.push(context, MaterialPageRoute(builder: (context) => BreathAndMeditationScreen()));
    } else if (index == 3) {
      Navigator.push(context, MaterialPageRoute(builder: (context) => ShopPage()));
    } else if (index == 4) {
      Navigator.push(context, MaterialPageRoute(builder: (context) => ProgressPageApp()));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Background image with full-screen fit
          Positioned.fill(
            child: Image.asset(
              'assets/image/Bg.png',
              fit: BoxFit.cover, // Ensure it covers the entire screen
            ),
          ),
          // Profile Icon
          Positioned(
            top: 40,
            left: 20,
            child: IconButton(
              icon: CircleAvatar(
                radius: 25,
                backgroundImage: AssetImage('assets/image/Profile.png'),
              ),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => ProfilePage()),
                );
              },
            ),
          ),
          // Greeting Text
          Positioned(
            top: 120,
            left: 30,
            right: 30,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Hi, ',
                  style: TextStyle(
                    fontSize: 48,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                Text(
                  'User!',
                  style: TextStyle(
                    fontSize: 48,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF5493C6),
                  ),
                ),
                SizedBox(height: 10),
                Text(
                  'Which exercise would you like to do today?',
                  style: TextStyle(
                    fontSize: 18,
                    color: const Color.fromARGB(255, 0, 0, 0), // White text for better visibility
                  ),
                ),
              ],
            ),
          ),
          // Buttons Positioned Higher
          Positioned(
            bottom: 120, // Moved up by reducing the bottom property
            left: 20,
            right: 20,
            child: Wrap(
              spacing: 20,
              runSpacing: 20,
              alignment: WrapAlignment.center,
              children: [
                _buildMainButton('Breathing', Icons.air),
                _buildMainButton('Meditate', Icons.spa),
                _buildMainButton('Progress', Icons.star),
                // _buildMainButton('Quiz', Icons.question_answer),
              ],
            ),
          ),
        ],
      ),
      bottomNavigationBar: HotbarNavigation(
        currentIndex: _currentIndex,
        onTap: _onTabTapped,
      ),
    );
  }

  // Button Builder with custom size, background color and stroke
  Widget _buildMainButton(String title, IconData icon) {
    return ElevatedButton.icon(
      style: ElevatedButton.styleFrom(
        padding: EdgeInsets.symmetric(vertical: 20, horizontal: 16),
        backgroundColor: Color(0xFF7EB7F6), // Button background color
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
          side: BorderSide(color: Color(0xFFB6D3F3), width: 4), // Stroke color and width
        ),
        minimumSize: Size(140, 147), // Button size
      ),
      icon: Icon(icon, color: Color(0xFF5493C6), size: 28),
      label: Text(
        title,
        style: TextStyle(fontSize: 16, color: Colors.white), // Text color is white
      ),
      onPressed: () {
        print('$title button pressed');
        if('$title' == 'Breathing'){
          Navigator.push(context, MaterialPageRoute(builder: (context) => BreathingScreen()));
        }
        else if('$title' == 'Meditate'){
          Navigator.push(context, MaterialPageRoute(builder: (context) => MeditationScreen()));
        }
        else if('$title' == 'Progress'){
          Navigator.push(context, MaterialPageRoute(builder: (context) => ProgressPageApp()));
        }
        // else if('$title' == 'Quiz'){
        //   Navigator.push(context, MaterialPageRoute(builder: (context) => QuizPage()));
        // }
      },
    );
  }
}

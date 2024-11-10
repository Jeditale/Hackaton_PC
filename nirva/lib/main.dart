import 'package:flutter/material.dart';
import 'profile.dart';  // Import the profile page 

void main() => runApp(MainMenu());

class MainMenu extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Nirva',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MainPage(),
    );
  }
}

class MainPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Background image
          Positioned.fill(
            child: Opacity(
              opacity: 0.3, // Adjust for image visibility
              child: Image.asset(
                'assets/image/Bg.png', // Background image path
                fit: BoxFit.cover,
              ),
            ),
          ),
          // Profile Circle (top-left) 
          Positioned(
            top: 40,
            left: 20,
            child: IconButton(
              icon: CircleAvatar(
                radius: 25,
                backgroundImage: AssetImage('assets/image/Profile.png'), 
              ),
              onPressed: () {
                // Navigate to Profile Page
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => ProfilePage()),
                );
              },
            ),
          ),
          
          Positioned(
            top: 150, // Adjusted to be a little lower than before
            left: 40, // Adjusted to move the text more to the left
            child: RichText(
              text: TextSpan(
                children: [
                  TextSpan(
                    text: 'Hi ',
                    style: TextStyle(fontSize: 64, fontWeight: FontWeight.bold, color: Colors.white),
                  ),
                  TextSpan(
                    text: 'User',
                    style: TextStyle(fontSize: 64, fontWeight: FontWeight.bold, color: Color(0xFF5493C6)),
                  ),
                ],
              ),
              textAlign: TextAlign.left,
            ),
          ),
          // Centered Column for the buttons and other content
          Center(
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Which exercise would you like to do today?',
                    style: TextStyle(fontSize: 16, color: const Color.fromARGB(255, 0, 0, 0)), // Adjusted for visibility on background
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: 40),
                  Wrap(
                    spacing: 20,
                    runSpacing: 20,
                    alignment: WrapAlignment.center,
                    children: [
                      MainButton(
                        title: 'Breathing Exercises',
                        icon: Icons.air,
                        onPressed: () {},
                      ),
                      MainButton(
                        title: 'Meditation',
                        icon: Icons.self_improvement,
                        onPressed: () {},
                      ),
                      MainButton(
                        title: 'Progress Tracker',
                        icon: Icons.show_chart,
                        onPressed: () {},
                      ),
                      MainButton(
                        title: 'Schedule Reminder',
                        icon: Icons.access_alarm,
                        onPressed: () {},
                      ),
                    ],
                  ),
                  SizedBox(height: 20),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class MainButton extends StatelessWidget {
  final String title;
  final IconData icon;
  final VoidCallback onPressed;

  MainButton({required this.title, required this.icon, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 147,
      height: 140,
      child: ElevatedButton.icon(
        icon: Icon(icon, size: 28, color: Colors.teal[700]),
        label: Text(
          title,
          style: TextStyle(fontSize: 16, color: Colors.teal[800]), // Adjust text color
          textAlign: TextAlign.center,
        ),
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.white.withOpacity(0.8), // Adjust for background visibility
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
            side: BorderSide(color: Colors.teal),
          ),
        ),
        onPressed: onPressed,
      ),
    );
  }
}

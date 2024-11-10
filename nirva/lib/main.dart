import 'package:flutter/material.dart';

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
      // appBar: AppBar(
      //   title: Text('Mindful Practices'),
      //   centerTitle: true,
      //   backgroundColor: Colors.teal,
      // ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Hi User,',
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 10),
              Text(
                'which exercise would you like to do today?',
                style: TextStyle(fontSize: 16, color: Colors.grey[700]),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 40),
              MainButton(
                title: 'Breathing Exercises',
                icon: Icons.air,
                onPressed: () {
                  // Navigate to Breathing Exercises Page
                },
              ),
              MainButton(
                title: 'Meditation',
                icon: Icons.self_improvement,
                onPressed: () {
                  // Navigate to Meditation Page
                },
              ),
              MainButton(
                title: 'Progress Tracker',
                icon: Icons.show_chart,
                onPressed: () {
                  // Navigate to Progress Tracker Page
                },
                
              ),
              MainButton(
                title: 'Schedule Reminder',
                icon: Icons.show_chart,
                onPressed: () {
                  // Navigate to Progress Tracker Page
                },
                
              ),
              SizedBox(height: 20),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.teal, 
                ),
                onPressed: () {
                  // Schedule Reminders
                },
                child: Text('Theme and sound store!'),
              ),
            ],
          ),
        ),
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
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0),
      child: ElevatedButton.icon(
        icon: Icon(icon, size: 28, color: Colors.teal[700]),
        label: Text(title, style: TextStyle(fontSize: 18)),
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.white,
          foregroundColor: Colors.teal, // For text and icon color
          minimumSize: Size(double.infinity, 60),
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

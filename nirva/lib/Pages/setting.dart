import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Settings Page',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: SettingsPage(),
    );
  }
}

class SettingsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Colors.white, Colors.blue[100]!],
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 20),
              Text(
                'Settings',
                style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
              SizedBox(height: 20),
              SettingsOption(
                icon: Icons.account_circle,
                text: 'Account',
                onTap: () {
                  // Navigate to Account settings
                },
              ),
              SettingsOption(
                icon: Icons.notifications,
                text: 'Notification',
                onTap: () {
                  // Navigate to Notification settings
                },
              ),
              SettingsOption(
                icon: Icons.brightness_6,
                text: 'Appearance',
                onTap: () {
                  // Navigate to Appearance settings
                },
              ),
              SizedBox(height: 10),
              SettingsOption(
                icon: Icons.report,
                text: 'Report',
                onTap: () {
                  // Navigate to Report settings
                },
              ),
              SettingsOption(
                icon: Icons.article,
                text: 'Term of services',
                onTap: () {
                  // Navigate to Terms of Service
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class SettingsOption extends StatelessWidget {
  final IconData icon;
  final String text;
  final VoidCallback onTap;

  SettingsOption({required this.icon, required this.text, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Card(
        shape: RoundedRectangleBorder(),
        margin: EdgeInsets.symmetric(vertical: 8),
        color: const Color.fromARGB(255, 255, 255, 255),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 12.0),
          child: Row(
            children: [
              Icon(icon, color: Colors.blue),
              SizedBox(width: 16),
              Expanded(
                child: Text(
                  text,
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.black,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
              Icon(Icons.arrow_forward_ios, color: const Color.fromARGB(255, 137, 201, 254)),
            ],
          ),
        ),
      ),
    );
  }
}

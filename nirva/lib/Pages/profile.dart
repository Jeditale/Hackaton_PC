import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:nirva/Pages/BreathAndMeditation.dart';
import 'package:nirva/Pages/mainmenu_page.dart';
import 'package:nirva/Pages/progress.dart';
import 'package:nirva/Pages/setting.dart';
import 'package:nirva/Pages/welcome.dart';
import 'package:nirva/hotbar/hotbar_navigation.dart';
import 'package:nirva/pages/Reminder/reminder_page.dart';

class ProfilePage extends StatefulWidget {
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  String name = "Loading...";
  String email = "Loading...";
  String profileImageUrl = ""; // Add profile image URL if required
  int _currentIndex = 5;

  void _onTabTapped(int index) {
    if (index == _currentIndex) return; // Stay on the current page if reselected
    setState(() {
      _currentIndex = index;
    });

    if (index == 0) {
      Navigator.push(context, MaterialPageRoute(builder: (context) => ReminderPage()));
    } else if (index == 1) {
      Navigator.push(context, MaterialPageRoute(builder: (context) => BreathAndMeditationScreen()));
    } else if (index == 2) {
      Navigator.push(context, MaterialPageRoute(builder: (context) => MainMenu()));
    } else if (index == 4) {
      Navigator.push(context, MaterialPageRoute(builder: (context) => ProgressPageApp()));
    }
  }

  @override
  void initState() {
    super.initState();
    fetchUserData();
  }

  Future<void> fetchUserData() async {
    try {
      final user = FirebaseAuth.instance.currentUser;
      if (user != null) {
        final userDoc =
            await FirebaseFirestore.instance.collection('users').doc(user.uid).get();
        if (userDoc.exists) {
          setState(() {
            name = userDoc.data()?['name'] ?? "No Name";
            email = user.email ?? "No Email";
            profileImageUrl = userDoc.data()?['profileImageUrl'] ?? ""; // Optional
          });
        }
      }
    } catch (e) {
      print("Error fetching user data: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(color: Colors.white),
        child: SafeArea(
          child: Center(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // Background image with profile picture as a cover photo
                Stack(
                  alignment: Alignment.center,
                  clipBehavior: Clip.none,
                  children: [
                    // Cover Photo
                    Image.asset(
                      'assets/image/nirva.png', // Replace with your image path
                      height: 250,
                      width: double.infinity,
                      fit: BoxFit.cover,
                    ),
                    // Profile Picture
                    Positioned(
                      bottom: -50, // Adjust overlap position
                      child: CircleAvatar(
                        radius: 100,
                        backgroundImage: profileImageUrl.isNotEmpty
                            ? NetworkImage(profileImageUrl)
                            : const AssetImage('assets/image/Profile.png') // Default image
                                as ImageProvider,
                        backgroundColor: Colors.white,
                      ),
                    ),
                    // Settings icon
                    Positioned(
                      top: 8,
                      right: 8,
                      child: IconButton(
                        icon: const Icon(
                          Icons.settings,
                          color: Colors.white,
                          size: 30,
                        ),
                        onPressed: () {
                          Navigator.push(context,
                              MaterialPageRoute(builder: (context) => SettingsPage()));
                        },
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 60), // Adjust based on overlap
                // User Name
                Text(
                  name,
                  style: const TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 8),
                // Email
                Text(
                  email,
                  style: const TextStyle(
                    fontSize: 25,
                    color: Colors.grey,
                  ),
                ),
                const SizedBox(height: 20),
                // Log Out Button
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white,
                    side: const BorderSide(color: Colors.red, width: 2),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  onPressed: () async {
                    await FirebaseAuth.instance.signOut();
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => WelcomeScreen()));
                  },
                  child: const Text(
                    'Log Out',
                    style: TextStyle(
                      color: Colors.red,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: HotbarNavigation(
        currentIndex: _currentIndex,
        onTap: _onTabTapped,
      ),
    );
  }
}

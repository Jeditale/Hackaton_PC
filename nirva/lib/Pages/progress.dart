import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:nirva/Pages/BreathAndMeditation.dart';
import 'package:nirva/Pages/Reminder/reminder_page.dart';
import 'package:nirva/Pages/mainmenu_page.dart';
import 'package:nirva/Pages/profile.dart';
import 'package:nirva/Pages/shop.dart';
import 'package:pie_chart/pie_chart.dart';
import 'package:nirva/hotbar/hotbar_navigation.dart'; // Ensure this is the correct import for your project
import 'package:nirva/Pages/Progress/test_bar.dart';

void main() {
  runApp(ProgressPageApp());
}

class ProgressPageApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: ProgressPage(),
    );
  }
}

class ProgressPage extends StatefulWidget {
  @override
  _ProgressPageState createState() => _ProgressPageState();
}

class _ProgressPageState extends State<ProgressPage> {
  int _currentIndex = 4; // Set initial index for the bottom navigation

  // Bottom navigation bar handler
  void _onTabTapped(int index) {
    setState(() {
      _currentIndex = index;
    });

    // Handle navigation based on index (if necessary)
    if (index == 0) {
      Navigator.push(context, MaterialPageRoute(builder: (context) => ReminderPage())); // Adjust as needed
    } else if (index == 2) {
      Navigator.push(context, MaterialPageRoute(builder: (context) => MainMenu())); // Adjust as needed
    } else if (index == 3) {
      Navigator.push(context, MaterialPageRoute(builder: (context) => ShopPage())); // Adjust as needed
    } else if (index == 1) {
      Navigator.push(context, MaterialPageRoute(builder: (context) => BreathAndMeditationScreen())); // Adjust as needed
    }
  }
  

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
          image: DecorationImage(
            image: AssetImage('assets/image/Bg.png'), // Replace with your background image path
            fit: BoxFit.cover,
          ),
        ),
        child: SafeArea(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Profile picture
                  
                  
                  // Progress card with Pie Chart
                  Card(
                    color: Colors.blue[100]?.withOpacity(0.8), // Slight transparency for background visibility
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            'This month progress',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w500,
                              color: Colors.black,
                            ),
                          ),
                          SizedBox(height: 10),
                          SizedBox(
                            height: 300,
                            child: PiechartSample(), // Display the Pie Chart here
                          ),
                        ],
                      ),
                    ),
                  ),
                  
                  SizedBox(height: 20),
                  
                  // Breathing Exercise card
                  Card(
                    color: Colors.blue[100]?.withOpacity(0.8), // Slight transparency for background visibility
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            'Weekly Progress',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w500,
                              color: Colors.black,
                            ),
                          ),
                          SizedBox(height: 10),
                          SizedBox(
                            height: 300,
                            child: MyBarTotal(), // Display the Pie Chart here
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
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

class ProgressCard extends StatelessWidget {
  final IconData icon;
  final String title;

  const ProgressCard({
    super.key,
    required this.icon,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.blue[100]?.withOpacity(0.8), // Slight transparency for background visibility
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 16),
        child: Row(
          children: [
            CircleAvatar(
              backgroundColor: Colors.blue[300],
              child: Icon(
                icon,
                color: Colors.white,
              ),
            ),
            SizedBox(width: 16),
            Expanded(
              child: Text(
                title,
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                  color: Colors.black,
                ),
              ),
            ),
            ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue[300],
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
              child: Text(
                'View',
                style: TextStyle(color: Colors.white),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class PiechartSample extends StatefulWidget {
  const PiechartSample({super.key});

  @override
  State<PiechartSample> createState() => _PiechartSampleState();
}

class _PiechartSampleState extends State<PiechartSample> {
  Map<String, double> dataMap = {
    "Breathing Exercise": 0, // Default values
    "Meditation": 0,
  };

  final List<Color> colorList = [
    const Color.fromARGB(156, 215, 235, 255),
    const Color.fromRGBO(68, 121, 168, 100),
  ];

  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchData(); // Fetch Firestore data when the widget is initialized
  }

  Future<void> fetchData() async {
    try {
      final user = FirebaseAuth.instance.currentUser;
      final doc = await FirebaseFirestore.instance.collection('users').doc(user!.uid).get();
      
      if (doc.exists) {
        final data = doc.data() as Map<String, dynamic>;
        setState(() {
          dataMap = {
            "Breathing Exercise": (data['breathCount'] ?? 0).toDouble(),
            "Meditation": (data['meditateCount'] ?? 0).toDouble(),
          };
          isLoading = false; // Data has been loaded
        });
      } else {
        print("Document does not exist");
      }
    } catch (e) {
      print("Error fetching data: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return isLoading
        ? const Center(child: CircularProgressIndicator()) // Show loading spinner while fetching data
        : PieChart(
            colorList: colorList,
            dataMap: dataMap,
            chartRadius: MediaQuery.of(context).size.width / 1.5,
            legendOptions: const LegendOptions(
              showLegendsInRow: true,
              legendPosition: LegendPosition.bottom,
            ),
            chartValuesOptions: const ChartValuesOptions(
              showChartValuesInPercentage: true,
              showChartValuesOutside: false,
              showChartValueBackground: false,
              chartValueStyle: TextStyle(
                fontSize: 16,
                color: Colors.black,
                fontWeight: FontWeight.w500,
              ),
            ),
          );
  }
}

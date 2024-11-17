import 'package:flutter/material.dart';
import 'package:nirva/Pages/BreathAndMeditation.dart';
import 'package:nirva/Pages/Reminder/reminder_page.dart';
import 'package:nirva/Pages/mainmenu_page.dart';
import 'package:nirva/hotbar/hotbar_navigation.dart';
import 'package:nirva/pages/progress.dart';

class ShopPage extends StatefulWidget {
  @override
  _ShopPageState createState() => _ShopPageState();
}

class _ShopPageState extends State<ShopPage> {
  int _currentIndex = 3; // Default to ShopPage index in hotbar

  // Handle hotbar navigation
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
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Background Image
          Positioned.fill(
            child: Image.asset(
              'assets/image/Bg.png', // Replace with your image path
              fit: BoxFit.cover,
            ),
          ),
          // Page Content with Transparent Background
          SingleChildScrollView(
            padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 40), // Space for the status bar
                Text(
                  'Voice',
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
                SizedBox(height: 10),
                ProductCard(
                  imageUrl: 'assets/image/peter_voice.png',
                  title: 'The Art of Breathing',
                  description:
                      'Peter\'s soothing voice and calming music will guide you through a series of breathing exercises to help reduce anxiety and stress.',
                  price: 200,
                ),
                SizedBox(height: 20),
                Text(
                  'Tracks',
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
                SizedBox(height: 10),
                ProductCard(
                  imageUrl: 'assets/image/soothing_rain.png',
                  title: 'Soothing Rain',
                  description:
                      'Relaxing sounds of rain, great for meditation and falling asleep.',
                  price: 30,
                ),
                ProductCard(
                  imageUrl: 'assets/image/breath_of_life.png',
                  title: 'Breath of Life',
                  description: 'Guided meditation for beginners.',
                  price: 40,
                ),
                ProductCard(
                  imageUrl: 'assets/image/calm_ocean.png',
                  title: 'Calm Ocean',
                  description:
                      'The sound of waves hitting the shore is perfect for relaxation and sleep.',
                  price: 50,
                ),
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
}

class ProductCard extends StatelessWidget {
  final String imageUrl;
  final String title;
  final String description;
  final int price;

  ProductCard({
    required this.imageUrl,
    required this.title,
    required this.description,
    required this.price,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.white.withOpacity(0.9), // Semi-transparent card background
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      child: Padding(
        padding: EdgeInsets.all(16),
        child: Row(
          children: [
            SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                  SizedBox(height: 4),
                  Text(
                    description,
                    style: TextStyle(
                      color: Colors.grey[600],
                    ),
                  ),
                  SizedBox(height: 10),
                  ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color.fromRGBO(100, 173, 228, 100),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                    child: Text(
                      'Buy $price',
                      style: TextStyle(
                        color: const Color.fromRGBO(18, 23, 23, 100),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Image.asset(
                imageUrl,
                fit: BoxFit.cover,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

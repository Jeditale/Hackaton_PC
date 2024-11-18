import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:nirva/Pages/BreathAndMeditation.dart';
import 'package:nirva/Pages/Reminder/reminder_page.dart';
import 'package:nirva/Pages/mainmenu_page.dart';
import 'package:nirva/hotbar/hotbar_navigation.dart';
import 'package:nirva/pages/progress.dart';
import 'package:firebase_auth/firebase_auth.dart';

class ShopPage extends StatefulWidget {
  @override
  _ShopPageState createState() => _ShopPageState();
}

class _ShopPageState extends State<ShopPage> {
  int _currentIndex = 3; // Default to ShopPage index in hotbar
  final Set<String> ownedProducts = {}; // Track owned product IDs
  late String userId;
  bool isPremium = false;

  @override
  void initState() {
    super.initState();
    fetchOwnedItems(); // Fetch owned items when the page loads
  }

Future<void> fetchOwnedItems() async {
  try {
    final user = FirebaseAuth.instance.currentUser; // Get the current user
    if (user != null) {
      userId = user.uid; // Store the user's ID
      final userDoc = await FirebaseFirestore.instance
          .collection('users')
          .doc(userId)
          .get();

      final List<dynamic> items = userDoc.data()?['itemOwned'] ?? [];
      final bool premiumStatus = userDoc.data()?['premium'] ?? false;

      if (premiumStatus) {
        final nirvaVoiceDocs = await FirebaseFirestore.instance
            .collection('nirva-voice')
            .get();
        final nirvaShopDocs = await FirebaseFirestore.instance
            .collection('nirva-shop')
            .get();

        final allProductIds = [
          ...nirvaVoiceDocs.docs.map((doc) => doc.id),
          ...nirvaShopDocs.docs.map((doc) => doc.id),
        ];

        if (!items.contains(allProductIds)) {
          await FirebaseFirestore.instance
              .collection('users')
              .doc(userId)
              .update({'itemOwned': allProductIds});
        }

        setState(() {
          ownedProducts.addAll(allProductIds);
          isPremium = true; // Set premium status
        });
      } else {
        // Non-premium users
        setState(() {
          ownedProducts.addAll(items.cast<String>());
          isPremium = false; // Update premium status
        });
      }
    }
  } catch (e) {
    print('Error fetching owned items: $e');
  }
}


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

  // Handle product purchase
  Future<void> _handlePurchase(String productId) async {
    try {
      await FirebaseFirestore.instance.collection('users').doc(userId).update({
        'itemOwned': FieldValue.arrayUnion([productId]),
      });
      setState(() {
        ownedProducts.add(productId); // Mark product as owned locally
      });
    } catch (e) {
      print('Error purchasing product: $e');
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
              'assets/image/Bg.png', // Replace with your background image path
              fit: BoxFit.cover,
            ),
          ),
          // Page Content
          SingleChildScrollView(
            padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 40),
                Text(
                  'Voice',
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 10),
                StreamBuilder<QuerySnapshot>(
                  stream: FirebaseFirestore.instance
                      .collection('nirva-voice')
                      .snapshots(),
                  builder: (context, snapshot) {
                    if (!snapshot.hasData) {
                      return Center(child: CircularProgressIndicator());
                    }

                    return Column(
                      children: snapshot.data!.docs.map((doc) {
                        return ProductCard(
                          documentSnapshot: doc,
                          isOwned: isPremium || ownedProducts.contains(doc.id),
                          onBuy: () => _handlePurchase(doc.id),
                        );
                      }).toList(),
                    );
                  },
                ),
                SizedBox(height: 40), // Space for the status bar
                Text(
                  'Tracks',
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
                SizedBox(height: 10),
                StreamBuilder<QuerySnapshot>(
                  stream: FirebaseFirestore.instance
                      .collection('nirva-shop')
                      .snapshots(),
                  builder: (context, snapshot) {
                    if (!snapshot.hasData) {
                      return Center(child: CircularProgressIndicator());
                    }

                    return Column(
                      children: snapshot.data!.docs.map((doc) {
                        return ProductCard(
                          documentSnapshot: doc,
                          isOwned: isPremium || ownedProducts.contains(doc.id),
                          onBuy: () => _handlePurchase(doc.id),
                        );
                      }).toList(),
                    );
                  },
                ),
              ],
            ),
          ),
        ],
      ),
      // Add the Hotbar Navigation here (copied from MainMenu)
      bottomNavigationBar: HotbarNavigation(
        currentIndex: _currentIndex,
        onTap: _onTabTapped,
      ),
    );
  }
}

class ProductCard extends StatelessWidget {
  final DocumentSnapshot documentSnapshot;
  final bool isOwned; // Indicates if the product is owned or premium
  final VoidCallback onBuy; // Callback for the Buy button

  ProductCard({
    required this.documentSnapshot,
    required this.isOwned,
    required this.onBuy,
  });

  @override
  Widget build(BuildContext context) {
    final data = documentSnapshot.data() as Map<String, dynamic>;

    final String name = data['name'] ?? 'No Name';
    final String description = data['description'] ?? 'No Description';
    final int price = data['price'] ?? 0;
    final String imageUrl = data['imageURL'] ?? 'assets/image/peter_voice.png';

    return Card(
      color: Colors.white.withOpacity(0.9), // Semi-transparent card background
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      child: Padding(
        padding: EdgeInsets.all(16),
        child: Row(
          children: [
            // Expanded widget with text and button on the left side
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    name,
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
                    onPressed: isOwned ? null : onBuy, // Disable if owned or premium
                    style: ElevatedButton.styleFrom(
                      backgroundColor: isOwned ? Colors.grey : Colors.blue,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                    child: Text(isOwned ? 'Owned' : 'Buy $price'),
                  ),
                ],
              ),
            ),
            // Placeholder for product image (can be added later if image URLs are stored)
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

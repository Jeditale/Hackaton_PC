import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class ShopPage extends StatelessWidget {
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
          // Page Content with Transparent Background
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
                        return ProductCard(documentSnapshot: doc);
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
                        return ProductCard(documentSnapshot: doc);
                      }).toList(),
                    );
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class ProductCard extends StatefulWidget {
  final DocumentSnapshot documentSnapshot;

  ProductCard({required this.documentSnapshot});

  @override
  _ProductCardState createState() => _ProductCardState();
}

class _ProductCardState extends State<ProductCard> {
  bool isOwned = false; // Track if the product has been purchased

  @override
  Widget build(BuildContext context) {
    final data = widget.documentSnapshot.data() as Map<String, dynamic>;

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
                    onPressed: isOwned
                        ? null // Disable button if owned
                        : () {
                            setState(() {
                              isOwned = true; // Update state to "owned"
                            });
                          },
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

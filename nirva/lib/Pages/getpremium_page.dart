import 'package:flutter/material.dart';
import 'package:nirva/Pages/welcome.dart';
import 'package:nirva/pages/Quiz/quiz_page.dart';

class GetPremiumPage extends StatefulWidget {
  @override
  _GetPremiumPageState createState() => _GetPremiumPageState();
}

class _GetPremiumPageState extends State<GetPremiumPage> {
  String selectedChoice = ''; // Track the selected choice ("Annual" or "Monthly")

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/image/Bridge.png'), // Background image path
            fit: BoxFit.cover,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 40.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Top cross button
              Align(
                alignment: Alignment.topLeft,
                child: IconButton(
                  icon: Icon(Icons.close, color: Color(0xFF24446D), size: 30),
                  onPressed: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context) => WelcomeScreen()));
                  },
                ),
              ),
              
              SizedBox(height: 20),

              // Centered content
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // Title "Get Premium"
                    Text(
                      'Get Premium',
                      style: TextStyle(
                        fontSize: 32,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF24446D),
                      ),
                    ),

                    SizedBox(height: 10),

                    // Description text
                    Text(
                      'Unlock all sounds and themes, with new content added monthly just for you! '
                      'Enjoy an ad-free experience and access your favorite practices offline anytime.',
                      style: TextStyle(
                        fontSize: 16,
                        color: Color(0xFF24446D),
                      ),
                      textAlign: TextAlign.center,
                    ),

                    SizedBox(height: 20),

                    // Discount logo image
                    Image.asset(
                      'assets/image/Discount.png', // Logo image path
                      width: 358,
                      height: 164, // Adjust as necessary
                    ),

                    SizedBox(height: 20),

                    // Annual choice
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          selectedChoice = 'Annual';
                        });
                      },
                      child: Container(
                        width: 350,
                        height: 86,
                        padding: EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          color: Color(0x5C0D368C), // Transparent background color with 36% opacity
                          borderRadius: BorderRadius.circular(10),
                          border: selectedChoice == 'Annual'
                              ? Border.all(
                                  color: Color(0xFF0D368C), // Border color
                                  width: 2, // Stroke weight
                                )
                              : null, // No border if not selected
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black26,
                              blurRadius: 8,
                              offset: Offset(0, 4),
                            ),
                          ],
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Annual',
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.w600,
                                color: Color.fromARGB(255, 255, 255, 255),
                              ),
                            ),
                            SizedBox(height: 5),
                            Text(
                              'First 30 days free - Then ฿999.99/Year',
                              style: TextStyle(
                                fontSize: 14,
                                color: Color.fromARGB(255, 255, 255, 255),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),

                    SizedBox(height: 10),

                    // Monthly choice
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          selectedChoice = 'Monthly';
                        });
                      },
                      child: Container(
                        width: 350,
                        height: 86,
                        padding: EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          color: Color(0x5C0D368C), // Transparent background color with 36% opacity
                          borderRadius: BorderRadius.circular(10),
                          border: selectedChoice == 'Monthly'
                              ? Border.all(
                                  color: Color(0xFF0D368C), // Border color
                                  width: 2, // Stroke weight
                                )
                              : null, // No border if not selected
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black26,
                              blurRadius: 8,
                              offset: Offset(0, 4),
                            ),
                          ],
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Monthly',
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.w600,
                                color: Color.fromARGB(255, 255, 255, 255),
                              ),
                            ),
                            SizedBox(height: 5),
                            Text(
                              'First 7 days free - Then ฿99.99/Month',
                              style: TextStyle(
                                fontSize: 14,
                                color: Color.fromARGB(255, 255, 255, 255),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              // Start 30-day free trial button
              Center(
                child: SizedBox(
                  width: 350,
                  height: 46,
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.pop(context); // Navigate to main page for now
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Color(0xFF24446D),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                    child: Text(
                      'Start 30-day free trial',
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ),

              SizedBox(height: 20),

              // Terms and Privacy Policy text
              Center(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: Text(
                    'By placing this order, you agree to the Terms of Service and Privacy Policy. '
                    'Subscription automatically renews unless auto-renew is turned off at least 24-hours '
                    'before the end of the current period.',
                    style: TextStyle(
                      fontSize: 11,
                      color: Color(0xFF24446D),
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

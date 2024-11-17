import 'package:flutter/material.dart';
import 'package:nirva/Pages/welcome.dart';
// Import your MainMenu page if not already imported

class ResultPage extends StatelessWidget {
  final int totalScore;

  ResultPage({required this.totalScore});

  // This function returns the anxiety level based on the score range
  String get anxietyLevel {
    if (totalScore <= 9) {
      return 'You have a mild to average level anxiety';
    } else if (totalScore <= 14) {
      return 'You have moderate anxiety.';
    } else {
      return 'You have high anxiety.';
    }
  }

  // This function returns additional recommendations based on the score
  String get resultText {
    if (totalScore <= 9) {
      return 'We strongly recommend that you try our breathing exercises for relief.';
    } else if (totalScore <= 14) {
      return 'It is recommended to retake the assessment in 1-2 weeks.';
    } else {
      return 'You should be assessed by a specialist.';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/image/Bg.png'), // Ensure the image path is correct
            fit: BoxFit.cover,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children: [
              // Spacer to push the content towards the center
              Spacer(flex: 1),

              // "Your Results" text
              Column(
                children: [
                  Text(
                    'Your Results',
                    style: TextStyle(
                      fontSize: 32, // Same size as the question top text
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF24446D), // Same color as the question top text
                    ),
                  ),
                  SizedBox(height: 40), // Space between "Your Results" and the anxiety level message

                  // Anxiety Level inside a rounded white box
                  Container(
                    width: 298, // Set width to 298
                    height: 52, // Set height to 52
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black26,
                          blurRadius: 8,
                          offset: Offset(0, 4),
                        ),
                      ],
                    ),
                    child: Center(
                      child: Text(
                        anxietyLevel, // Display the anxiety level message
                        style: TextStyle(
                          fontSize: 18, // Font size for anxiety level message
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF24446D), // Same color as the question top text
                        ),
                        textAlign: TextAlign.center, // Center align the text
                      ),
                    ),
                  ),
                  SizedBox(height: 30), // Space between anxiety level message and result text

                  // Result text (recommended action)
                  Text(
                    resultText,
                    style: TextStyle(
                      fontSize: 16, // Smaller font size for the result text
                      color: Color(0xFF24446D), // Same color as the question top text
                    ),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),

              // Spacer to push the button to the bottom
              Spacer(flex: 2),

              SizedBox(
                width: 360,
                height: 73,
                child: ElevatedButton(
                  onPressed: () {
                    // Navigate to the MainMenu page
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(builder: (context) => WelcomeScreen()), 
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.black,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                  child: Text(
                    'Continue',
                    style: TextStyle(
                      fontSize: 30,
                      color: Colors.white,
                    ),
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

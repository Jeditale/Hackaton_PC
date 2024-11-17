import 'package:flutter/material.dart';
import 'package:nirva/Pages/LoginAndRegister/SignUp.dart';

class ResultPage extends StatelessWidget {
  final int totalScore;

  ResultPage({required this.totalScore});

  String get anxietyLevel {
    if (totalScore <= 9) {
      return 'You have a mild to average level anxiety';
    } else if (totalScore <= 14) {
      return 'You have moderate anxiety.';
    } else {
      return 'You have high anxiety.';
    }
  }

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
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/image/Bg.png'),
            fit: BoxFit.cover,
          ),
        ),
        child: Column(
          children: [
            Spacer(flex: 1),

            // Results section
            Column(
              children: [
                Text(
                  'Your Results',
                  style: TextStyle(
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF24446D),
                  ),
                ),
                SizedBox(height: 40),
                Container(
                  width: 298,
                  height: 52,
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
                      anxietyLevel,
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF24446D),
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
                SizedBox(height: 30),
                Text(
                  resultText,
                  style: TextStyle(
                    fontSize: 16,
                    color: Color(0xFF24446D),
                  ),
                  textAlign: TextAlign.center,
                ),
              ],
            ),

            Spacer(flex: 1), // Reduce space below the content to move the button up

            // Continue button
            SizedBox(
              width: 360,
              height: 73,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (context) => SignUpScreen()),
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

            SizedBox(height: 20), // Add a small gap below the button
          ],
        ),
      ),
    );
  }
}

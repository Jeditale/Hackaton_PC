import 'package:flutter/material.dart';
import 'package:nirva/Pages/Quiz/quiz_page.dart';
import 'LoginAndRegister/Login.dart';
import 'LoginAndRegister/SignUp.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // ภาพพื้นหลัง
          Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/image/background1.png'), // ระบุภาพพื้นหลัง
                fit: BoxFit.cover, // ให้ภาพเต็มหน้าจอ
              ),
            ),
          ),

          // เนื้อหาหลักของหน้าจอ
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 380, 20, 0),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(20, 0, 20, 70),
                  child: Column(
                    children: [
                      Text(
                        "Welcome",
                        style: TextStyle(
                          fontSize: 50,
                          fontWeight: FontWeight.bold,
                          color: Colors.white, // ใส่สีขาวให้ตัวหนังสือถ้ามองไม่เห็น
                        ),
                      )
                    ],
                  ),
                ),
                Column(
                  children: [
                    Text(
                      "Get started with us",
                      style: TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                        color: Colors.white, 
                      ),
                    ),
                    Text(
                      "Just small steps every day can make a big difference.",
                      style: TextStyle(fontSize: 25, 
                      color: Colors.white ), 
                    )
                  ],
                ),
                SizedBox(height: 40),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton.icon(
                    onPressed: () {
                      Navigator.push(context, MaterialPageRoute(
                        builder: (context) {
                          return LoginScreen();
                        },
                      ));
                    },
                    style: ElevatedButton.styleFrom(
                      padding: EdgeInsets.symmetric(vertical: 15),
                      backgroundColor: const Color.fromARGB(255, 255, 255, 255),
                      minimumSize: Size(double.infinity, 30),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(25),
                      ),
                    ),
                    label: Text(
                      "Login",
                      style: TextStyle(fontSize: 30, color: Colors.black),
                    ),
                  ),
                ),
                SizedBox(height: 10),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton.icon(
                    onPressed: () {
                      Navigator.push(context, MaterialPageRoute(
                        builder: (context) {
                          return QuizPage();
                        },
                      ));
                    },
                    style: ElevatedButton.styleFrom(
                      padding: EdgeInsets.symmetric(vertical: 15),
                      backgroundColor: Colors.black,
                      minimumSize: Size(double.infinity, 30),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(25),
                      ),
                    ),
                    label: Text(
                      "Sign Up",
                      style: TextStyle(fontSize: 30, color: Colors.white),
                    ),
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}

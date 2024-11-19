import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:nirva/Pages/mainmenu_page.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:nirva/pages/getpremium_page.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final FirebaseAuth _auth = FirebaseAuth.instance;

  bool _isLoading = false;

  void _showError(String errorMessage) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(errorMessage),
        backgroundColor: Colors.red,
      ),
    );
  }

  Future<void> _login() async {
    if (_formKey.currentState!.validate()) {
      setState(() {
        _isLoading = true;
      });

      try {
        // Sign in with email and password
        UserCredential userCredential = await _auth.signInWithEmailAndPassword(
          email: _emailController.text.trim(),
          password: _passwordController.text.trim(),
        );

        // Fetch the user's Firestore document
        final userDoc = await FirebaseFirestore.instance
            .collection('users')
            .doc(userCredential.user!.uid)
            .get();

        if (userDoc.exists) {
          final userData = userDoc.data() as Map<String, dynamic>;

          // Check the premium field
          bool isPremium = userData['premium'] ?? false;

          if (isPremium) {
            // Navigate to MainMenu if the user is premium
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => MainMenu()),
            );
          } else {
            // Navigate to GetPremiumPage if the user is not premium
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => GetPremiumPage()),
            );
          }
        } else {
          _showError('User data not found in Firestore.');
        }
      } on FirebaseAuthException catch (e) {
        // Handle Firebase authentication errors
        if (e.code == 'user-not-found') {
          _showError('No user found for this email.');
        } else if (e.code == 'wrong-password') {
          _showError('Incorrect password. Please try again.');
        } else if (e.code == 'invalid-email') {
          _showError('Invalid email format.');
        } else {
          _showError('Login failed. Please try again.');
        }
      } catch (e) {
        // Handle other errors
        _showError('An unexpected error occurred. Please try again.');
      } finally {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Background Image
          Container(
            width: double.infinity,
            height: double.infinity,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/image/Bg.png'),
                fit: BoxFit.cover,
              ),
            ),
          ),

          // Login Title Outside White Box
          Positioned(
            top: 90, // Adjusted lower
            left: 20,
            child: Text(
              "Login",
              style: TextStyle(
                fontSize: 36, // Larger font size
                fontWeight: FontWeight.bold,
                color: Color(0xFF24446D),
              ),
            ),
          ),

          // White container for form
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              height: MediaQuery.of(context).size.height * 0.8,
              width: double.infinity,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(30),
                  topRight: Radius.circular(30),
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25.0),
                child: Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: 40),

                      // Email Label
                      Text(
                        "E-mail",
                        style: TextStyle(
                          fontSize: 28, // Larger text
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF24446D),
                        ),
                      ),
                      // Email Input
                      TextFormField(
                        controller: _emailController,
                        keyboardType: TextInputType.emailAddress,
                        style: TextStyle(fontSize: 20), // Larger input text
                        decoration: InputDecoration(
                          hintText: 'Enter your email',
                          hintStyle: TextStyle(color: Colors.grey, fontSize: 18),
                          enabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.grey),
                          ),
                          focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Color(0xFF24446D)),
                          ),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter your email.';
                          }
                          if (!RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(value)) {
                            return 'Please enter a valid email.';
                          }
                          return null;
                        },
                      ),
                      SizedBox(height: 40),

                      // Password Label
                      Text(
                        "Password",
                        style: TextStyle(
                          fontSize: 28, // Larger text
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF24446D),
                        ),
                      ),
                      // Password Input
                      TextFormField(
                        controller: _passwordController,
                        obscureText: true,
                        style: TextStyle(fontSize: 20), // Larger input text
                        decoration: InputDecoration(
                          hintText: 'Enter your password',
                          hintStyle: TextStyle(color: Colors.grey, fontSize: 18),
                          enabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.grey),
                          ),
                          focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Color(0xFF24446D)),
                          ),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter your password.';
                          }
                          if (value.length < 6) {
                            return 'Password must be at least 6 characters long.';
                          }
                          return null;
                        },
                      ),
                      Spacer(), // Push Login button to the bottom

                      // Login Button
                      _isLoading
                          ? Center(child: CircularProgressIndicator())
                          : Center(
                              child: SizedBox(
                                width: 360,
                                height: 73,
                                child: ElevatedButton(
                                  onPressed: _login,
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: Colors.black,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(20),
                                    ),
                                  ),
                                  child: Text(
                                    "Login",
                                    style: TextStyle(
                                      fontSize: 30,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                      SizedBox(height: 20), // Padding below button
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

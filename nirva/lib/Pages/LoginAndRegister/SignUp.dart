import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:nirva/Pages/LoginAndRegister/Login.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _phoneController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<void> _signUp() async {
    if (_formKey.currentState!.validate()) {
      try {
        // Create the user
        UserCredential userCredential =
            await _auth.createUserWithEmailAndPassword(
          email: _emailController.text.trim(),
          password: _passwordController.text.trim(),
        );

        // Get the created user ID
        String uid = userCredential.user!.uid;

        // Save additional user data to Firestore
        await FirebaseFirestore.instance.collection('users').doc(uid).set({
          'name': _nameController.text.trim(),
          'phone': _phoneController.text.trim(),
          'email': _emailController.text.trim(),
          'breathCount': 0,
          'meditateCount': 0,
        });

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Signup successful! Please login.')),
        );

        // Navigate to login screen
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => LoginScreen()),
        );
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error: ${e.toString()}')),
        );
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

          // "Sign Up" Title Positioned Above White Box
          Positioned(
            top: 70,
            left: 20,
            child: Text(
              "Sign Up",
              style: TextStyle(
                fontSize: 36,
                fontWeight: FontWeight.bold,
                color: Color(0xFF24446D),
              ),
            ),
          ),

          // White Box
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              height: MediaQuery.of(context).size.height * 0.85,
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

                      // Name Field
                      Text(
                        "Name",
                        style: TextStyle(
                          fontSize: 28,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF24446D),
                        ),
                      ),
                      TextFormField(
                        controller: _nameController,
                        style: TextStyle(fontSize: 20),
                        decoration: InputDecoration(
                          hintText: "Enter your name",
                          hintStyle: TextStyle(fontSize: 18),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter your name.';
                          }
                          return null;
                        },
                      ),

                      SizedBox(height: 20),

                      // Phone Field
                      Text(
                        "Phone Number",
                        style: TextStyle(
                          fontSize: 28,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF24446D),
                        ),
                      ),
                      TextFormField(
                        controller: _phoneController,
                        style: TextStyle(fontSize: 20),
                        decoration: InputDecoration(
                          hintText: "Enter your phone number",
                          hintStyle: TextStyle(fontSize: 18),
                        ),
                        keyboardType: TextInputType.phone,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter your phone number.';
                          }
                          if (!RegExp(r'^[0-9]{10}$').hasMatch(value)) {
                            return 'Enter a valid phone number.';
                          }
                          return null;
                        },
                      ),

                      SizedBox(height: 20),

                      // Email Field
                      Text(
                        "E-mail",
                        style: TextStyle(
                          fontSize: 28,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF24446D),
                        ),
                      ),
                      TextFormField(
                        controller: _emailController,
                        style: TextStyle(fontSize: 20),
                        decoration: InputDecoration(
                          hintText: "Enter your email",
                          hintStyle: TextStyle(fontSize: 18),
                        ),
                        keyboardType: TextInputType.emailAddress,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter your email.';
                          }
                          if (!RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(value)) {
                            return 'Enter a valid email address.';
                          }
                          return null;
                        },
                      ),

                      SizedBox(height: 20),

                      // Password Field
                      Text(
                        "Password",
                        style: TextStyle(
                          fontSize: 28,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF24446D),
                        ),
                      ),
                      TextFormField(
                        controller: _passwordController,
                        style: TextStyle(fontSize: 20),
                        decoration: InputDecoration(
                          hintText: "Enter your password",
                          hintStyle: TextStyle(fontSize: 18),
                        ),
                        obscureText: true,
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

                      Spacer(),

                      // Sign Up Button
                      Center(
                        child: SizedBox(
                          width: 360,
                          height: 73,
                          child: ElevatedButton(
                            onPressed: _signUp,
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.black,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20),
                              ),
                            ),
                            child: Text(
                              "Sign Up",
                              style: TextStyle(
                                fontSize: 30,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: 20), // Padding below the button
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

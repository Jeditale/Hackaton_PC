import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:nirva/Pages/BreathAndMeditation.dart';
import 'package:nirva/Pages/Breathing/breathingStart.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class BreathingScreen extends StatefulWidget {
  @override
  _BreathingScreenState createState() => _BreathingScreenState();
}

class _BreathingScreenState extends State<BreathingScreen> {
  String selectedBreathingPattern = 'Breathing Pattern';
  String selectedVoice = 'Voice';
  int cycleCount = 0; // Default cycle count is 7
  int _breatheInDuration = 4;
  int _holdDuration = 2;
  int _breatheOutDuration = 6;
  int _remainingCycles = 0; // Default _remainingCycles

  void updateCycleCount(String pattern) {
    switch (pattern) {
      case 'Sleep Calm Breath':
        cycleCount = 5;
        _remainingCycles = 5;
        _breatheInDuration = 4;
        _holdDuration = 2;
        _breatheOutDuration = 6;
        break;
      case 'Quick Reset Breath':
        cycleCount = 3;
        _remainingCycles = 3;
        _breatheInDuration = 2;
        _breatheOutDuration = 2;
        break;
      case 'Triangle Breath':
        cycleCount = 5;
        _remainingCycles = 5;
        _breatheInDuration = 4;
        _holdDuration = 4;
        _breatheOutDuration = 4;
        break;
      case 'Single Step Breath':
        cycleCount = 10;
        _remainingCycles = 10;
        _breatheInDuration = 5;
        _breatheOutDuration = 5;
        break;
      case 'Box Breath':
        cycleCount = 4;
        _remainingCycles = 4;
        _breatheInDuration = 4;
        _holdDuration = 4;
        _breatheOutDuration = 4;
        break;
      default:
        cycleCount = 0; // Default value
        _remainingCycles = 0;
    }
  }
  // Method to update breathCount in Firestore
  Future<void> updateBreathCount(String userId) async {
    try {
      final userDoc = FirebaseFirestore.instance.collection('users').doc(userId);

      // Fetch
      final snapshot = await userDoc.get();
      if (snapshot.exists) {
        final data = snapshot.data() as Map<String, dynamic>;
        int currentBreathCount = data['breathCount'] ?? 0;

        // Calculate
        int newBreathCount = currentBreathCount + 1;

        // Update Firestore
        await userDoc.update({'breathCount': newBreathCount});
        print('breathCount updated successfully to $newBreathCount!');
      } else {
        print('User document does not exist. Creating a new one.');

      }
    } catch (e) {
      print('Error updating breathCount: $e');
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () {
            Navigator.push(context, MaterialPageRoute(
              builder: (context) {
                return BreathAndMeditationScreen();
              },
            ));
          },
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/image/background2.png'),
            fit: BoxFit.cover,
          ),
        ),
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Circular container with counter display on top
              Container(
                width: 200,
                height: 200,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: const Color.fromARGB(255, 255, 255, 255).withOpacity(0.4), // สีพื้นหลังวงกลม
                  border: Border.all(width: 2, color: Colors.black12), // สีขอบวงกลม
                ),
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    // Counter text on top of the circle
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          '$cycleCount', // Display dynamic cycle count
                          style: TextStyle(fontSize: 35, fontWeight: FontWeight.bold, color: const Color.fromARGB(255, 0, 0, 0)),
                        ),
                        Text(
                          'cycles',
                          style: TextStyle(fontSize: 20, color: const Color.fromARGB(255, 0, 0, 0)),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              SizedBox(height: 30),

              // Breathing Pattern button
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: PopupMenuButton<String>(
                  onSelected: (value) {
                    setState(() {
                      selectedBreathingPattern = value;
                      updateCycleCount(value); // Update the cycle count and breathing times based on selection
                    });
                  },
                  itemBuilder: (BuildContext context) => [
                    PopupMenuItem(
                      value: 'Sleep Calm Breath',
                      child: Text('Sleep Calm Breath', style: TextStyle(fontSize: 25)),
                    ),
                    PopupMenuItem(
                      value: 'Quick Reset Breath',
                      child: Text('Quick Reset Breath', style: TextStyle(fontSize: 25)),
                    ),
                    PopupMenuItem(
                      value: 'Triangle Breath',
                      child: Text('Triangle Breath', style: TextStyle(fontSize: 25)),
                    ),
                    PopupMenuItem(
                      value: 'Single Step Breath',
                      child: Text('Single Step Breath', style: TextStyle(fontSize: 25)),
                    ),
                    PopupMenuItem(
                      value: 'Box Breath',
                      child: Text('Box Breath', style: TextStyle(fontSize: 25)),
                    ),
                  ],
                  child: Container(
                    padding: EdgeInsets.symmetric(vertical: 30),
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black12,
                          blurRadius: 4,
                          offset: Offset(0, 4),
                        ),
                      ],
                    ),
                    child: Center(
                      child: Text(
                        selectedBreathingPattern,
                        style: TextStyle(fontSize: 25),
                      ),
                    ),
                  ),
                ),
              ),

              SizedBox(height: 10),

              // Voice button
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: PopupMenuButton<String>(
                  onSelected: (value) {
                    setState(() {
                      selectedVoice = value;
                    });
                  },
                  itemBuilder: (BuildContext context) => [
                    PopupMenuItem(
                      value: 'Eric',
                      child: Text('Eric', style: TextStyle(fontSize: 25)),
                    ),
                    PopupMenuItem(
                      value: 'Sarah',
                      child: Text('Sarah', style: TextStyle(fontSize: 25)),
                    ),
                  ],
                  child: Container(
                    padding: EdgeInsets.symmetric(vertical: 30),
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black12,
                          blurRadius: 4,
                          offset: Offset(0, 4),
                        ),
                      ],
                    ),
                    child: Center(
                      child: Text(
                        selectedVoice,
                        style: TextStyle(fontSize: 25),
                      ),
                    ),
                  ),
                ),
              ),

              SizedBox(height: 20),

              // Start button
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: ElevatedButton(
                  onPressed: (selectedBreathingPattern != 'Breathing Pattern' &&
                              selectedVoice != 'Voice')
                      ? () {
                          Navigator.push(context, MaterialPageRoute(
                            builder: (context) {
                              return BreathingstartScreen(
                                remainingCycles: _remainingCycles,
                                breatheInDuration: _breatheInDuration,
                                holdDuration: _holdDuration,
                                breatheOutDuration: _breatheOutDuration,
                                selectedVoice: selectedVoice, // ส่งเสียงที่เลือกไป
                              );
                            },
                          ));
                        }
                      : null, // ปิดการใช้งานปุ่มถ้ายังไม่ได้เลือก
                  style: ElevatedButton.styleFrom(
                    padding: EdgeInsets.fromLTRB(10, 25, 10, 25),
                    backgroundColor: Colors.black,
                    minimumSize: Size(double.infinity, 50),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                  ),
                  child: Text('Start', 
                    style: TextStyle(fontSize: 25, color: Colors.white)
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

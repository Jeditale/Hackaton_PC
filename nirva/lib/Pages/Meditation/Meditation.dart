import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:nirva/Pages/BreathAndMeditation.dart';
import 'meditationStart.dart';

class MeditationScreen extends StatefulWidget {
  @override
  _BreathingScreenState createState() => _BreathingScreenState();
}

class _BreathingScreenState extends State<MeditationScreen> {
  String selectedBreathingPattern = 'Background Music';
  int selectedTime = 1; // เวลาเริ่มต้น

  Future<void> updateMedCount(String userId) async {
    try {
      final userDoc = FirebaseFirestore.instance.collection('users').doc(userId);

      // Fetch the current
      final snapshot = await userDoc.get();
      if (snapshot.exists) {
        final data = snapshot.data() as Map<String, dynamic>;
        int currentMedCount = data['meditateCount'] ?? 0;

        // Calculate
        int newMedCount = currentMedCount + 1;

        // Update Firestore
        await userDoc.update({'meditateCount': newMedCount});
        print('meditateCount updated successfully to $newMedCount!');
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
              GestureDetector(
                onTap: () {
                  _showTimePicker();
                },
                child: Container(
                  width: 200,
                  height: 200,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: const Color.fromARGB(255, 255, 255, 255).withOpacity(0.4),
                    border: Border.all(width: 2, color: Colors.black12),
                  ),
                  child: Center(
                    child: Text(
                      '$selectedTime MIN',
                      style: TextStyle(fontSize: 35, fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 20),
              _buildMusicSelector(),

              SizedBox(height: 20),
              
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: ElevatedButton(
                  onPressed: (selectedBreathingPattern != 'Background Music') 
                      ? () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) {
                                return MeditationstartScreen(
                                  selectedTime: selectedTime,
                                  selectedBreathingPattern: selectedBreathingPattern,
                                );
                              },
                            ),
                          );
                        }
                      : null, 
                  style: ElevatedButton.styleFrom(
                    padding: EdgeInsets.fromLTRB(10, 25, 10, 25),
                    backgroundColor: Colors.black,
                    minimumSize: Size(double.infinity, 50),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                  ),
                  child: Text(
                    'Start',
                    style: TextStyle(fontSize: 25, color: Colors.white),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildMusicSelector() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: PopupMenuButton<String>(
        onSelected: (value) {
          setState(() {
            selectedBreathingPattern = value;
          });
        },
        itemBuilder: (BuildContext context) => [
          PopupMenuItem(
            value: 'Mountain',
            child: Text('Mountain', style: TextStyle(fontSize: 25)),
          ),
          PopupMenuItem(
            value: 'Low-fi Music',
            child: Text('Low-fi Music', style: TextStyle(fontSize: 25)),
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
    );
  }

  void _showTimePicker() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Select Time'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              DropdownButton<int>(
                value: selectedTime,
                items: [1, 5, 10, 15, 20]
                    .map((time) => DropdownMenuItem(
                          value: time,
                          child: Text('$time MIN', style: TextStyle(fontSize: 25),),
                        ))
                    .toList(),
                onChanged: (value) {
                  setState(() {
                    selectedTime = value!;
                  });
                  Navigator.pop(context);
                },
              ),
            ],
          ),
        );
      },
    );
  }
}

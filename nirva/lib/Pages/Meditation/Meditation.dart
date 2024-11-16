import 'package:flutter/material.dart';
import 'package:nirva/Pages/BreathAndMeditation.dart';
import 'meditationStart.dart';

class MeditationScreen extends StatefulWidget {
  @override
  _BreathingScreenState createState() => _BreathingScreenState();
}

class _BreathingScreenState extends State<MeditationScreen> {
  String selectedBreathingPattern = 'Background Music';
  String selectedVoice = 'Voice';

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
              // Circular counter display
              Container(
                width: 200,
                height: 200,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(width: 2),
                ),
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        '1 MIN',
                        style: TextStyle(fontSize: 35, fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 20),

              // Background Music button
              Padding(
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
                      child: Text('Mountain', style: TextStyle(fontSize: 20)),
                    ),
                    PopupMenuItem(
                      value: 'Low-fi Music',
                      child: Text('Low-fi Music', style: TextStyle(fontSize: 20)),
                    ),
                  ],
                  child: Container(
                    padding: EdgeInsets.symmetric(vertical: 30),
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10),
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
                      child: Text('Eric', style: TextStyle(fontSize: 20)),
                    ),
                    PopupMenuItem(
                      value: 'Sarah',
                      child: Text('Sarah', style: TextStyle(fontSize: 20)),
                    ),
                  ],
                  child: Container(
                    padding: EdgeInsets.symmetric(vertical: 30),
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10),
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

              SizedBox(height: 10),

              // Vibration toggle
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: Row(
                  children: [
                    Checkbox(
                      value: false,
                      onChanged: (bool? value) {},
                    ),
                    Text('Mute when finish', style: TextStyle(fontSize: 20)),
                  ],
                ),
              ),

              SizedBox(height: 20),

              // Start button
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.push(context, MaterialPageRoute(
                      builder: (context) {
                        return MeditationstartScreen();
                      },
                    ));
                  },
                  style: ElevatedButton.styleFrom(
                    padding: EdgeInsets.symmetric(vertical: 15),
                    backgroundColor: Colors.black,
                    minimumSize: Size(double.infinity, 50),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
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
}

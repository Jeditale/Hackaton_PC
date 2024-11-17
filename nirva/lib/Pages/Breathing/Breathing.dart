import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart'; // Import the video player package
import 'package:nirva/Pages/BreathAndMeditation.dart';
import 'package:nirva/Pages/Breathing/breathingStart.dart';

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
  late VideoPlayerController _controller;

  @override
  void initState() {
    super.initState();
    // Initialize the video controller with a local asset or network video
    _controller = VideoPlayerController.asset('assets/video/background_video.mp4')
      ..initialize().then((_) {
        setState(() {});
        _controller.setLooping(true); // Loop the video
        _controller.play(); // Start playing the video automatically
      });
  }

  @override
  void dispose() {
    _controller.dispose(); // Dispose the controller when the widget is disposed
    super.dispose();
  }

  void updateCycleCount(String pattern) {
    switch (pattern) {
      case 'Sleep Calm Breath':
        cycleCount = 10;
        _remainingCycles = 10;
        _breatheInDuration = 4;
        _holdDuration = 2;
        _breatheOutDuration = 6;
        break;
      case 'Quick Reset Breath':
        cycleCount = 5;
        _remainingCycles = 5;
        _breatheInDuration = 2;
        _holdDuration = 0;
        _breatheOutDuration = 2;
        break;
      case 'Triangle Breath':
        cycleCount = 8;
        _remainingCycles = 8;
        _breatheInDuration = 4;
        _holdDuration = 4;
        _breatheOutDuration = 4;
        break;
      case 'Single Step Breath':
        cycleCount = 15;
        _remainingCycles = 15;
        _breatheInDuration = 5;
        _holdDuration = 0;
        _breatheOutDuration = 5;
        break;
      case 'Box Breath':
        cycleCount = 6;
        _remainingCycles = 6;
        _breatheInDuration = 4;
        _holdDuration = 4;
        _breatheOutDuration = 4;
        break;
      default:
        cycleCount = 0; // Default value
        _remainingCycles = 0;
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
              // Circular video player with counter display on top
            // Circular video player with counter display on top
Container(
  width: 200,
  height: 200,
  decoration: BoxDecoration(
    shape: BoxShape.circle,
    border: Border.all(width: 2),
  ),
  child: Stack(
    alignment: Alignment.center,
    children: [
      // Video inside the circle
      ClipOval(
        child: _controller.value.isInitialized
            ? SizedBox(
                width: 200,
                height: 200,
                child: FittedBox(
                  fit: BoxFit.cover, // Ensures video fills the circle
                  child: SizedBox(
                    width: _controller.value.size.width,
                    height: _controller.value.size.height,
                    child: VideoPlayer(_controller),
                  ),
                ),
              )
            : Center(child: CircularProgressIndicator()), // Show loading while video initializes
      ),
      // Counter text on top of the video
      Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            '$cycleCount', // Display dynamic cycle count
            style: TextStyle(fontSize: 35, fontWeight: FontWeight.bold, color: Colors.white),
          ),
          Text(
            'cycles',
            style: TextStyle(fontSize: 20, color: Colors.white),
          ),
        ],
      ),
    ],
  ),
),

              SizedBox(height: 20),

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
                      child: Text('Sleep Calm Breath', style: TextStyle(fontSize: 20)),
                    ),
                    PopupMenuItem(
                      value: 'Quick Reset Breath',
                      child: Text('Quick Reset Breath', style: TextStyle(fontSize: 20)),
                    ),
                    PopupMenuItem(
                      value: 'Triangle Breath',
                      child: Text('Triangle Breath', style: TextStyle(fontSize: 20)),
                    ),
                    PopupMenuItem(
                      value: 'Single Step Breath',
                      child: Text('Single Step Breath', style: TextStyle(fontSize: 20)),
                    ),
                    PopupMenuItem(
                      value: 'Box Breath',
                      child: Text('Box Breath', style: TextStyle(fontSize: 20)),
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
                    Text('Vibration', style: TextStyle(fontSize: 20)),
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
                        return BreathingstartScreen(
                          remainingCycles: _remainingCycles,
                          breatheInDuration: _breatheInDuration,
                          holdDuration: _holdDuration,
                          breatheOutDuration: _breatheOutDuration,
                        );
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

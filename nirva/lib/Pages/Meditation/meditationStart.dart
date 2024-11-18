import 'dart:async';
import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:nirva/Pages/Meditation/Meditation.dart';

class MeditationstartScreen extends StatefulWidget {
  final int selectedTime;
  final String selectedBreathingPattern;

  const MeditationstartScreen({
    super.key,
    required this.selectedTime,
    required this.selectedBreathingPattern,
  });

  @override
  _MeditationstartScreenState createState() => _MeditationstartScreenState();
}

class _MeditationstartScreenState extends State<MeditationstartScreen> {
  late int timeLeft;
  late Timer _timer;
  bool isPaused = false;

  final AudioPlayer _audioPlayer = AudioPlayer();
  final AudioCache _audioCache = AudioCache();

  @override
  void initState() {
    super.initState();
    timeLeft = widget.selectedTime * 60;
    _startCountdown();
    _playSelectedMusic();
  }

  void _playSelectedMusic() async {
    String audioPath;

    if (widget.selectedBreathingPattern == 'Mountain') {
      audioPath = 'sound/mountain.mp3';
    } else if (widget.selectedBreathingPattern == 'Low-fi Music') {
      audioPath = 'sound/soundlowfi.mp3';
    } else {
      return;
    }

    await _audioCache.load(audioPath); // โหลดไฟล์เสียงล่วงหน้า
    _audioPlayer.play(AssetSource(audioPath), volume: 100.0);
    _audioPlayer.setReleaseMode(ReleaseMode.loop);
  }

  void _stopMusic() async {
    await _audioPlayer.stop();
  }

  void _startCountdown() {
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      if (timeLeft > 0 && !isPaused) {
        setState(() {
          timeLeft--;
        });
      } else if (timeLeft == 0) {
        _timer.cancel();
        _stopMusic();
        
      }
    });
  }

  void _togglePause() {
    setState(() {
      isPaused = !isPaused;
      if (isPaused) {
        _audioPlayer.pause();
      } else {
        _audioPlayer.resume();
      }
    });
  }

  @override
  void dispose() {
    _timer.cancel();
    _stopMusic();
    _audioPlayer.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    int minutes = timeLeft ~/ 60;
    int seconds = timeLeft % 60;

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => MeditationScreen()),
            );
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
        child: Padding(
          padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
          child: Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  width: 200,
                  height: 200,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.white.withOpacity(0.4),
                    border: Border.all(width: 2, color: Colors.black12),
                  ),
                  child: Center(
                    child: Text(
                      '$minutes:${seconds.toString().padLeft(2, '0')}',
                      style: TextStyle(fontSize: 35, fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
                SizedBox(height: 20),
                ElevatedButton(
                  onPressed: _togglePause,
                  style: ElevatedButton.styleFrom(
                    padding: EdgeInsets.symmetric(vertical: 15),
                    backgroundColor: Colors.white,
                    minimumSize: Size(double.infinity, 50),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  child: Text(
                    isPaused ? 'CONTINUE' : 'PAUSE',
                    style: TextStyle(fontSize: 25, color: Colors.black),
                  ),
                ),
                SizedBox(height: 20),
                
                ElevatedButton(
                  onPressed: () {
                    _stopMusic();
                    Navigator.push(
                      
                      context,
                      MaterialPageRoute(builder: (context) => MeditationScreen()),
                      
                    );
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
                    'Stop',
                    style: TextStyle(fontSize: 25, color: Colors.white),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

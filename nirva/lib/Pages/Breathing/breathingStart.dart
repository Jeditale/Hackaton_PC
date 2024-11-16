import 'dart:async'; // ตัวจับเวลา
import 'package:flutter/material.dart';
import 'package:nirva/Pages/Breathing/Breathing.dart';
import 'package:audioplayers/audioplayers.dart'; //  audioplayers

class BreathingstartScreen extends StatefulWidget {
  final int remainingCycles;
  final int breatheInDuration;
  final int holdDuration;
  final int breatheOutDuration;

  BreathingstartScreen({
    required this.remainingCycles,
    required this.breatheInDuration,
    required this.holdDuration,
    required this.breatheOutDuration,
  });

  @override
  _BreathingstartScreenState createState() => _BreathingstartScreenState();
}

class _BreathingstartScreenState extends State<BreathingstartScreen> {
  String _breatheText = 'Breathe In';
  late Timer _timer;
  bool _isPaused = false;
  int _elapsedSeconds = 0;
  late int _cycleDuration;
  late int _remainingCycles;
  late int _breatheInDuration;
  late int _holdDuration;
  late int _breatheOutDuration;

  final AudioPlayer _audioPlayer = AudioPlayer(); // สร้าง AudioPlayer สำหรับเล่นเสียง

  @override
  void initState() {
    super.initState();

    _remainingCycles = widget.remainingCycles;
    _breatheInDuration = widget.breatheInDuration;
    _holdDuration = widget.holdDuration;
    _breatheOutDuration = widget.breatheOutDuration;

    _cycleDuration = _breatheInDuration + _holdDuration + _breatheOutDuration;
    _startBreathingCycle();
  }

  // ฟังก์ชันสำหรับเล่นเสียง
  Future<void> _playSound(String soundPath) async {
    await _audioPlayer.play(AssetSource(soundPath));
  }

  void _startBreathingCycle() {
    _timer = Timer.periodic(Duration(seconds: 1), (Timer timer) {
      if (!_isPaused && _remainingCycles > 0) {
        setState(() {
          _elapsedSeconds++;
          int secondsInCycle = _elapsedSeconds % _cycleDuration;

          if (secondsInCycle == 0) {
            _playSound('assets/sound/ringtone.mp3'); // เล่นเสียง Breathe In
          }

          if (secondsInCycle < _breatheInDuration) {
            _breatheText = 'Breathe In';
          } else if (secondsInCycle == _breatheInDuration) {
            _playSound('assets/sound/ringtone.mp3'); // เล่นเสียง Hold
          } else if (secondsInCycle < _breatheInDuration + _holdDuration) {
            _breatheText = 'Hold';
          } else if (secondsInCycle == _breatheInDuration + _holdDuration) {
            _playSound('assets/sound/ringtone.mp3'); // เล่นเสียง Breathe Out
          } else if (secondsInCycle < _breatheInDuration + _holdDuration + _breatheOutDuration) {
            _breatheText = 'Breathe Out';
          }

          if (secondsInCycle == _cycleDuration - 1) {
            _remainingCycles--;
            if (_remainingCycles == 0) {
              _timer.cancel();
              _breatheText = 'FINISH';
              _playSound('assets/sound/ringtone.mp3'); // เล่นเสียง Finish
            }
          }
        });
      }
    });
  }

  @override
  void dispose() {
    _timer.cancel(); // หยุดจับเวลาเมื่อหน้า widget ถูกลบ
    _audioPlayer.dispose(); // ปิดการทำงานของ AudioPlayer
    super.dispose();
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
                return BreathingScreen();
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
            image: AssetImage('assets/sound/background2.png'), // เพิ่มภาพพื้นหลังเมฆ
            fit: BoxFit.cover,
          ),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // วงกลมข้อความหายใจ
              Container(
                width: 200,
                height: 200,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: const Color.fromARGB(255, 255, 255, 255).withOpacity(0.4), // สีพื้นหลังวงกลม
                  border: Border.all(width: 2, color: Colors.black12), // สีขอบวงกลม
                ),
                child: Center(
                  child: Text(
                    _breatheText, // ข้อความหายใจ
                    style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                      color: const Color.fromARGB(255, 0, 0, 0), // สีข้อความ
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
              
              SizedBox(height: 20),
              
              // ข้อความ "cycle left"
              Text(
                '$_remainingCycles cycle left',  // แสดงจำนวนรอบที่เหลือ
                style: TextStyle(
                  fontSize: 20,
                  color: Colors.black87, // สีข้อความ
                ),
              ),

              SizedBox(height: 50),

              // ปุ่ม PAUSE/RESUME
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: ElevatedButton(
                  onPressed: () {
                    setState(() {
                      _isPaused = !_isPaused;
                    });
                  },
                  style: ElevatedButton.styleFrom(
                    padding: EdgeInsets.symmetric(vertical: 15),
                    backgroundColor: const Color.fromARGB(255, 255, 255, 255),
                    minimumSize: Size(double.infinity, 50),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  child: Text(
                    _isPaused ? 'CONTINUE' : 'PAUSE',  // เปลี่ยนข้อความปุ่ม
                    style: TextStyle(
                      fontSize: 25,
                      color: Colors.black, // สีข้อความของปุ่ม
                    ),
                  ),
                ),
              ),

              SizedBox(height: 20),

              // ปุ่ม Stop
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: ElevatedButton(
                  onPressed: () {
                    _timer.cancel();
                    Navigator.push(context, MaterialPageRoute(
                      builder: (context) {
                        return BreathingScreen();
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
                    'STOP',
                    style: TextStyle(
                      fontSize: 25,
                      color: Colors.white, // สีข้อความของปุ่ม
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

import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart'; // สำหรับ rootBundle
import 'package:audioplayers/audioplayers.dart'; // audioplayers
import 'package:nirva/Pages/Breathing/Breathing.dart';

class BreathingstartScreen extends StatefulWidget {
  final int remainingCycles;
  final int breatheInDuration;
  final int holdDuration;
  final int breatheOutDuration;
  final String selectedVoice;

  BreathingstartScreen({
    required this.remainingCycles,
    required this.breatheInDuration,
    required this.holdDuration,
    required this.breatheOutDuration,
    required this.selectedVoice,
  });

  @override
  _BreathingstartScreenState createState() => _BreathingstartScreenState();
}

class _BreathingstartScreenState extends State<BreathingstartScreen> {
  String _breatheText = 'Start'; // เริ่มต้นด้วยข้อความ Start
  late Timer _timer;
  bool _isPaused = false;
  int _elapsedSeconds = 0;
  late int _cycleDuration;
  late int _remainingCycles;
  late int _breatheInDuration;
  late int _holdDuration;
  late int _breatheOutDuration;
  bool _isStartPhase = true; // ตัวแปรเพื่อเช็คว่าอยู่ในเฟสเริ่มต้นหรือไม่

  final AudioPlayer _audioPlayer = AudioPlayer(); // สร้าง AudioPlayer สำหรับเล่นเสียง

  @override
  void initState() {
    super.initState();

    _remainingCycles = widget.remainingCycles;
    _breatheInDuration = widget.breatheInDuration;
    _holdDuration = widget.holdDuration;
    _breatheOutDuration = widget.breatheOutDuration;

    _cycleDuration = _breatheInDuration + _holdDuration + _breatheOutDuration;

    _playStartSoundAndBeginCycle(); // เริ่มเล่นเสียง Start และเริ่มจับเวลา
  }

  // ฟังก์ชันสำหรับเล่นเสียงจาก assets
  Future<void> _playSound(String soundPath) async {
    try {
      final ByteData data = await rootBundle.load(soundPath); // โหลดไฟล์เสียงจาก assets
      final Uint8List bytes = data.buffer.asUint8List(); // แปลงเป็น Uint8List
      await _audioPlayer.setVolume(1.0); // ตั้งค่าเสียงดังสุด (ค่ารับได้ตั้งแต่ 0.0 ถึง 1.0)
      await _audioPlayer.play(BytesSource(bytes)); // เล่นเสียงจาก bytes
    } catch (e) {
      print('Error loading sound: $e'); // แสดงข้อความหากมีข้อผิดพลาด
    }
  }

  // ฟังก์ชันสำหรับเล่นเสียง Start และเริ่มจับเวลา
  Future<void> _playStartSoundAndBeginCycle() async {
    await _playSound('assets/sound/start.mp3');
    
    setState(() {
      _breatheText = 'Start'; // ตั้งค่าให้ข้อความแสดงเป็น "Start"
      _isStartPhase = false;  // เปลี่ยนสถานะเป็นเฟสหายใจ
    });
     // เล่นเสียง Breathe In ทันทีหลังจาก Start
    await Future.delayed(Duration(seconds: 3)); // เพิ่ม delay เพื่อให้เสียงเล่นต่อเนื่อง
    await _playSound(_getBreathingSound('Breathein')); // เล่นเสียง Breathe In
  
    _startBreathingCycle();  // เริ่มรอบหายใจ
  }

  // ฟังก์ชันสำหรับเลือกเสียงที่เลือกจาก user
  String _getBreathingSound(String action) {
    if (widget.selectedVoice == 'Eric') {
      // เสียงผู้ชาย (Eric)
      return 'assets/sound/eric_$action.mp3';
    } else if (widget.selectedVoice == 'Sarah') {
      // เสียงผู้หญิง (Sarah)
      return 'assets/sound/sarah_$action.mp3';
    } else {
      // ค่าเริ่มต้น
      return 'assets/sound/eric_$action.mp3';
    }
  }

  void _startBreathingCycle() {
    _timer = Timer.periodic(Duration(seconds: 1), (Timer timer) {
    if (!_isPaused && _remainingCycles > 0) {
      setState(() {
        _elapsedSeconds++;
        int secondsInCycle = _elapsedSeconds % _cycleDuration;

        if (secondsInCycle == 0) {
          _playSound(_getBreathingSound('Breathein')); // เล่นเสียง Breathe In
        }

        if (secondsInCycle < _breatheInDuration) {
          _breatheText = 'Breathe In';
        } else if (secondsInCycle == _breatheInDuration) {
          _playSound(_getBreathingSound('Hold')); // เล่นเสียง Hold
        } else if (secondsInCycle < _breatheInDuration + _holdDuration) {
          _breatheText = 'Hold';
        } else if (secondsInCycle == _breatheInDuration + _holdDuration) {
          _playSound(_getBreathingSound('Breatheout')); // เล่นเสียง Breathe Out
        } else if (secondsInCycle < _breatheInDuration + _holdDuration + _breatheOutDuration) {
          _breatheText = 'Breathe Out';
        }

        if (secondsInCycle == _cycleDuration - 1) {
          _remainingCycles--;
          if (_remainingCycles == 0) {
            _timer.cancel();
            _breatheText = 'FINISH';
            _playSound('assets/sound/finish.mp3'); // เล่นเสียง Finish
            
          }
        }
      });
    }
  });
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
            image: AssetImage('assets/image/background2.png'), // เพิ่มภาพพื้นหลังเมฆ
            fit: BoxFit.cover,
          ),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // วงกลมข้อความ
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

              SizedBox(height: 90),

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
                    padding: EdgeInsets.fromLTRB(10, 35, 10, 35),
                    backgroundColor: const Color.fromARGB(255, 255, 255, 255),
                    minimumSize: Size(double.infinity, 50),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                  child: Text(
                    _isPaused ? 'CONTINUE' : 'PAUSE',  // เปลี่ยนข้อความปุ่ม
                    style: TextStyle(
                      fontSize: 30,
                      color: Colors.black, // สีข้อความของปุ่ม
                    ),
                  ),
                ),
              ),

              SizedBox(height: 20),

              // ปุ่ม Stop
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 100.0),
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
                    padding: EdgeInsets.fromLTRB(10, 20, 10, 20),
                    backgroundColor: Colors.black,
                    minimumSize: Size(double.infinity, 50),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
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

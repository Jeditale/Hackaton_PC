import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class LoadingPage extends StatelessWidget {
  const LoadingPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
     backgroundColor: Colors.blue[200],
     body: Center(
      child: SpinKitPulse(
        color: Colors.white,
        size: 50.0,
      ),
     ),
    );
  }
}
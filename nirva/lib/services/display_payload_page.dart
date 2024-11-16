import 'package:flutter/material.dart';

class DisplayPayload extends StatefulWidget {
  final String? payloadData;
  const DisplayPayload({super.key, required this.payloadData});

  @override
  State<DisplayPayload> createState() => _DisplayPayloadState();
}

class _DisplayPayloadState extends State<DisplayPayload> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text(
          widget.payloadData ?? "No payload data found",
        ),
      ),
    );
  }
}

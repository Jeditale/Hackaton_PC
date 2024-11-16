import 'package:flutter/material.dart';

class Reminder {
  final int id;
  final String name;
  final TimeOfDay time;
  final String repeat;
  final int? day;  // Used for weekly repeat (Monday = 1, Sunday = 7)
  final String sound;

  Reminder({
    required this.id,
    required this.name,
    required this.time,
    required this.repeat,
    this.day,
    required this.sound,
  });
}

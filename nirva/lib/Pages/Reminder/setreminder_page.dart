import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:intl/intl.dart'; // for formatting time
import 'package:timezone/data/latest.dart' as tz;
import 'package:timezone/timezone.dart' as tz;

class SetReminderPage extends StatefulWidget {
  @override
  _SetReminderPageState createState() => _SetReminderPageState();
}

class _SetReminderPageState extends State<SetReminderPage> {
  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  TextEditingController _nameController = TextEditingController();
  TextEditingController _descriptionController = TextEditingController();
  TimeOfDay _selectedTime = TimeOfDay.now();
  DateTime _selectedDate = DateTime.now();
  List<String> _selectedDays = [];
  String _notificationSound = 'default';

  @override
  void initState() {
    super.initState();
    tz.initializeTimeZones();
  }

  // Set notification time
  void _selectTime() async {
    final TimeOfDay? newTime = await showTimePicker(
      context: context,
      initialTime: _selectedTime,
    );
    if (newTime != null) {
      setState(() {
        _selectedTime = newTime;
      });
    }
  }

  // Set the start date of the reminder
  void _selectDate() async {
    final DateTime? newDate = await showDatePicker(
      context: context,
      initialDate: _selectedDate,
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );
    if (newDate != null) {
      setState(() {
        _selectedDate = newDate;
      });
    }
  }

  // Toggle days of the week
  void _toggleDay(String day) {
    setState(() {
      if (_selectedDays.contains(day)) {
        _selectedDays.remove(day);
      } else {
        _selectedDays.add(day);
      }
    });
  }

  // Set notification sound
  void _selectSound(String sound) {
    setState(() {
      _notificationSound = sound;
    });
  }

  // Save the reminder
  void _saveReminder() async {
    // Check if the reminder name is empty
    if (_selectedDays.isEmpty && _nameController.text.isEmpty) {
      _showAlertDialog('Error', 'Please select at least one day and enter a name for the reminder');
      return;
    }
    if (_nameController.text.isEmpty) {
      _showAlertDialog('Error', 'Please enter a name for the reminder');
      return;
    }

    // Check if no days have been selected
    if (_selectedDays.isEmpty) {
      _showAlertDialog('Error', 'Please select at least one day');
      return;
    }

    // Combine all the data into a map
    DateTime reminderDateTime = DateTime(
      _selectedDate.year,
      _selectedDate.month,
      _selectedDate.day,
      _selectedTime.hour,
      _selectedTime.minute,
    );

    // Check if the selected reminder time is in the past today
    if (reminderDateTime.isBefore(DateTime.now())) {
      reminderDateTime = reminderDateTime.add(Duration(days: 1));
    }

    final reminderData = {
      'name': _nameController.text,
      'time': reminderDateTime,
      'repeat': _selectedDays.join(', '),
      'sound': _notificationSound,
      'description': _descriptionController.text,
    };

    // Schedule the notification
    await _scheduleNotification(reminderDateTime);

    // Return the reminder data to the previous screen
    Navigator.pop(context, reminderData);
  }

  // Function to show the alert dialog
  void _showAlertDialog(String title, String message) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(title),
          content: Text(message),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('OK'),
            ),
          ],
        );
      },
    );
  }

  // Scheduling the notification
  Future<void> _scheduleNotification(DateTime reminderDateTime) async {
    var androidDetails = AndroidNotificationDetails(
      'reminder_channel_id',
      'Reminders',
      channelDescription: 'This channel is for reminder notifications',
      importance: Importance.high,
      priority: Priority.high,
      sound: _notificationSound == 'default'
          ? null
          : RawResourceAndroidNotificationSound(
              _notificationSound),
    );

    var platformDetails = NotificationDetails(android: androidDetails);

    // Convert the reminder time into a timezone-aware time
    tz.TZDateTime scheduledDate = tz.TZDateTime.from(reminderDateTime, tz.local);

    // Schedule the notification
    await flutterLocalNotificationsPlugin.zonedSchedule(
      0,
      'Reminder: ${_nameController.text}',
      _descriptionController.text,
      scheduledDate,
      platformDetails,
      androidAllowWhileIdle: true,
      uiLocalNotificationDateInterpretation:
          UILocalNotificationDateInterpretation.wallClockTime,
      payload: 'reminder_payload',
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Set Reminder'),
        backgroundColor: Colors.transparent,
        elevation: 0, // Removes the shadow
      ),
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/image/Bg.png'),
            fit: BoxFit.cover,
          ),
        ),
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView( // This makes the form scrollable
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  children: [
                    TextField(
                      controller: _nameController,
                      decoration: InputDecoration(labelText: 'Reminder Name'),
                    ),
                    SizedBox(height: 10),
                    TextField(
                      controller: _descriptionController,
                      decoration: InputDecoration(labelText: 'Description'),
                    ),
                    SizedBox(height: 10),
                    Row(
                      children: [
                        Text('Select Time: '),
                        Text(_selectedTime.format(context)),
                        IconButton(
                          icon: Icon(Icons.access_time),
                          onPressed: _selectTime,
                        ),
                      ],
                    ),
                    SizedBox(height: 10),
                    Row(
                      children: [
                        Text('Start Date: '),
                        Text(DateFormat.yMd().format(_selectedDate)),
                        IconButton(
                          icon: Icon(Icons.calendar_today),
                          onPressed: _selectDate,
                        ),
                      ],
                    ),
                    SizedBox(height: 10),
                    Text('Repeat On:'),
                    Wrap(
                      spacing: 8,
                      children: ['Sun', 'Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat']
                          .map((day) {
                        return ChoiceChip(
                          label: Text(day),
                          selected: _selectedDays.contains(day),
                          onSelected: (_) => _toggleDay(day),
                        );
                      }).toList(),
                    ),
                    SizedBox(height: 10),
                    Row(
                      children: [
                        Text('Select Sound: '),
                        DropdownButton<String>(
                          value: _notificationSound,
                          onChanged: (String? newValue) {
                            if (newValue != null) {
                              _selectSound(newValue);
                            }
                          },
                          items: ['default', 'Frog', 'Wahh']
                              .map<DropdownMenuItem<String>>((String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Text(value),
                            );
                          }).toList(),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            // Save Button at the bottom
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: SizedBox(
                width: 360,  // width = 360
                height: 73,  // height = 73
                child: ElevatedButton(
                  onPressed: _saveReminder,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color(0xFF24446D),  // Background color
                    foregroundColor: Colors.white,  // Text color
                  ),
                  child: Text('Save Reminder'),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:intl/intl.dart'; // for formatting time
import 'package:timezone/data/latest.dart' as tz;
import 'package:timezone/timezone.dart' as tz;

class EditReminderPage extends StatefulWidget {
  final Map<String, dynamic> reminder;

  EditReminderPage({required this.reminder});

  @override
  _EditReminderPageState createState() => _EditReminderPageState();
}

class _EditReminderPageState extends State<EditReminderPage> {
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
    _nameController.text = widget.reminder['name'];
    _descriptionController.text = widget.reminder['description'];
    _selectedTime = TimeOfDay.fromDateTime(widget.reminder['time']);
    _selectedDate = widget.reminder['time'];
    _selectedDays = widget.reminder['repeat'].split(', ').toList();
    _notificationSound = widget.reminder['sound'] ?? 'default';
  }

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

  void _toggleDay(String day) {
    setState(() {
      if (_selectedDays.contains(day)) {
        _selectedDays.remove(day);
      } else {
        _selectedDays.add(day);
      }
    });
  }

  void _selectSound(String sound) {
    setState(() {
      _notificationSound = sound;
    });
  }

  void _saveReminder() async {
    if (_nameController.text.isEmpty) {
      _showAlertDialog('Error', 'Please enter a name for the reminder');
      return;
    }
    if (_selectedDays.isEmpty) {
      _showAlertDialog('Error', 'Please select at least one day');
      return;
    }

    DateTime reminderDateTime = DateTime(
      _selectedDate.year,
      _selectedDate.month,
      _selectedDate.day,
      _selectedTime.hour,
      _selectedTime.minute,
    );

    if (reminderDateTime.isBefore(DateTime.now())) {
      reminderDateTime = reminderDateTime.add(Duration(days: 1));
    }

    final reminderData = {
      'id': widget.reminder['id'], // Include the existing reminder ID
      'name': _nameController.text,
      'time': reminderDateTime,
      'repeat': _selectedDays.join(', '),
      'sound': _notificationSound,
      'description': _descriptionController.text,
    };

    await _scheduleNotification(reminderDateTime);

    Navigator.pop(context, reminderData); // Return updated reminder data
  }

  void _deleteReminder() {
    Navigator.pop(context, 'delete');
  }

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

    tz.TZDateTime scheduledDate = tz.TZDateTime.from(reminderDateTime, tz.local);

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
        title: Text('Edit Reminder'),
        backgroundColor: Colors.transparent,
        elevation: 0,
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
              child: SingleChildScrollView(
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
                    
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(5),
              child: SizedBox(
                width: 360,
                height: 73,
                child: ElevatedButton(
                  onPressed: _saveReminder,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color(0xFF24446D),
                    foregroundColor: Colors.white,
                  ),
                  child: Text('Save Reminder'),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(20),
              child: SizedBox(
                width: 360,
                height: 73,
                child: ElevatedButton(
                  onPressed: _deleteReminder,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.red,
                    foregroundColor: Colors.white,
                  ),
                  child: Text('Delete Reminder'),
                ),
              ),
            ),
            // TextButton(
            //   onPressed: _deleteReminder,
            //   style: TextButton.styleFrom(
            //     backgroundColor: Colors.red,
            //     foregroundColor: Colors.white),
            //   child: Text('Delete Reminder'),
            // ),
          ],
        ),
      ),
    );
  }
}

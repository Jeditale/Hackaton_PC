import 'package:flutter/material.dart';

class EditReminderPage extends StatefulWidget {
  final Map<String, dynamic> reminder;

  EditReminderPage({required this.reminder});

  @override
  _EditReminderPageState createState() => _EditReminderPageState();
}

class _EditReminderPageState extends State<EditReminderPage> {
  late TextEditingController _nameController;
  late TextEditingController _descriptionController;
  late TimeOfDay _selectedTime;
  late List<String> _selectedDays;
  String _notificationSound = 'default';

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController(text: widget.reminder['name']);
    _descriptionController = TextEditingController(text: widget.reminder['description']);

    final reminderTime = widget.reminder['time'];
    _selectedTime = reminderTime != null ? TimeOfDay.fromDateTime(reminderTime) : TimeOfDay.now();

    _selectedDays = widget.reminder['repeat'] != null ? widget.reminder['repeat'].split(', ') : [];
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

  void _toggleDay(String day) {
    setState(() {
      if (_selectedDays.contains(day)) {
        _selectedDays.remove(day);
      } else {
        _selectedDays.add(day);
      }
    });
  }

  void _saveReminder() {
    final updatedReminder = {
      'id': widget.reminder['id'],
      'name': _nameController.text,
      'time': DateTime(
        widget.reminder['time']?.year ?? DateTime.now().year,
        widget.reminder['time']?.month ?? DateTime.now().month,
        widget.reminder['time']?.day ?? DateTime.now().day,
        _selectedTime.hour,
        _selectedTime.minute,
      ),
      'repeat': _selectedDays.join(', '),
      'sound': _notificationSound,
      'description': _descriptionController.text,
    };

    Navigator.pop(context, updatedReminder);
  }

  void _deleteReminder() {
    Navigator.pop(context, 'delete');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Edit Reminder'),
        backgroundColor: Colors.white, // White AppBar
        elevation: 0,
      ),
      resizeToAvoidBottomInset: true, // Ensure layout is adjusted for keyboard
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/image/Bg.png'), // Correct image path
            fit: BoxFit.cover, // Ensures the image covers the screen
            alignment: Alignment.topCenter, // Aligns the top part of the image
          ),
        ),
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextField(
                  controller: _nameController,
                  decoration: InputDecoration(
                    labelText: 'Reminder Name',
                    filled: true,
                    fillColor: Colors.white,
                    border: OutlineInputBorder(),
                  ),
                ),
                SizedBox(height: 10),
                TextField(
                  controller: _descriptionController,
                  decoration: InputDecoration(
                    labelText: 'Description',
                    filled: true,
                    fillColor: Colors.white,
                    border: OutlineInputBorder(),
                  ),
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
                          setState(() {
                            _notificationSound = newValue;
                          });
                        }
                      },
                      items: ['default', 'sound1', 'sound2']
                          .map<DropdownMenuItem<String>>((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                        );
                      }).toList(),
                    ),
                  ],
                ),
                SizedBox(height: 20),
                // Save Reminder Button
                SizedBox(
                  width: double.infinity,
                  height: 73, // Custom height for the button
                  child: ElevatedButton(
                    onPressed: _saveReminder,
                    child: Text(
                      'Save Reminder',
                      style: TextStyle(color: Colors.white),
                    ),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Color(0xFF24446D), // Save button color
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.zero, // No rounding
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 10),
                // Delete Reminder Button
                SizedBox(
                  width: double.infinity,
                  height: 60, // Smaller delete button size
                  child: TextButton(
                    onPressed: _deleteReminder,
                    child: Text(
                      'Delete Reminder',
                      style: TextStyle(color: Colors.white),
                    ),
                    style: TextButton.styleFrom(
                      backgroundColor: Colors.red,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.zero, // No rounding
                      ),
                    ),
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

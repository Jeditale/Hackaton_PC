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
      appBar: AppBar(title: Text('Edit Reminder')),
      resizeToAvoidBottomInset: true, // Ensure layout is adjusted for keyboard
      body: SingleChildScrollView( // Makes the body scrollable
        child: Padding(
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
              ElevatedButton(
                onPressed: _saveReminder,
                child: Text('Save Reminder'),
              ),
              TextButton(
                onPressed: _deleteReminder,
                child: Text('Delete Reminder'),
                style: TextButton.styleFrom(backgroundColor: Colors.red),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

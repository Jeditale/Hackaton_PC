import 'package:flutter/material.dart';
import 'package:nirva/Pages/BreathAndMeditation.dart';
import 'package:nirva/Pages/progress.dart';
import 'package:nirva/Pages/shop.dart';
import 'setreminder_page.dart';
import 'editreminder_page.dart';
import 'package:nirva/hotbar/hotbar_navigation.dart';
import 'package:nirva/Pages/profile.dart';
import 'package:nirva/Pages/mainmenu_page.dart';

class ReminderPage extends StatefulWidget {
  @override
  _ReminderPageState createState() => _ReminderPageState();
}

class _ReminderPageState extends State<ReminderPage> {
  List<Map<String, dynamic>> reminders = [];
  int _currentIndex = 0; // Default to Reminder tab in Hotbar

  void _onTabTapped(int index) {
    if (index == _currentIndex) return;

    setState(() {
      _currentIndex = index;
    });

    if (index == 2) {
      Navigator.push(context, MaterialPageRoute(builder: (context) => MainMenu()));
    } else if (index == 1) {
      Navigator.push(context, MaterialPageRoute(builder: (context) => BreathAndMeditationScreen()));
    } else if (index == 3) {
      Navigator.push(context, MaterialPageRoute(builder: (context) => ShopPage()));
    } else if (index == 4) {
      Navigator.push(context, MaterialPageRoute(builder: (context) => ProgressPageApp()));
    }
  }

  void _addNewReminder() async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => SetReminderPage()),
    );
    if (result != null) {
      setState(() {
        reminders.add(result);
      });
    }
  }

  void _editReminder(int index) async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => EditReminderPage(reminder: reminders[index]),
      ),
    );

    if (result == 'delete') {
      setState(() {
        reminders.removeAt(index);
      });
    } else if (result != null) {
      setState(() {
        reminders[index] = result;
      });
    }
  }
@override
Widget build(BuildContext context) {
  return Scaffold(
    appBar: AppBar(
      title: Text('Reminders'),
      backgroundColor: Colors.transparent, // Makes the AppBar transparent
      elevation: 0, // Removes shadow under the AppBar
      leading: IconButton(
        icon: CircleAvatar(
          backgroundImage: AssetImage('assets/image/Profile.png'),
        ),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => ProfilePage()),
          );
        },
      ),
    ),
    body: Container(
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage('assets/image/Bg.png'), // Set the background image
          fit: BoxFit.cover,
        ),
      ),
      child: Padding(
        padding: EdgeInsets.only(top: 20), // Adds space from the top of the screen
        child: ListView.builder(
          itemCount: reminders.length,
          itemBuilder: (context, index) {
            final reminder = reminders[index];
            return Container(
              margin: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
              decoration: BoxDecoration(
                color: Color(0xFFB6D3F3), // Background color for notifications
                borderRadius: BorderRadius.circular(10),
              ),
              child: ListTile(
                title: Text(reminder['name']),
                subtitle: Text(
                  '${reminder['time'].toString()} - Repeat on: ${reminder['repeat']}',
                ),
                onTap: () => _editReminder(index),
              ),
            );
          },
        ),
      ),
    ),
    floatingActionButton: Container(
      width: 65, // Rounded button size
      height: 65,
      child: FloatingActionButton(
        onPressed: _addNewReminder,
        backgroundColor: Color(0xFF64ADE4), // Button background color
        child: Icon(Icons.add),
        shape: CircleBorder(
          side: BorderSide(color: Colors.black, width: 2), // Black border
        ),
      ),
    ),
    bottomNavigationBar: HotbarNavigation(
      currentIndex: _currentIndex,
      onTap: _onTabTapped,
    ),
  );
}
}
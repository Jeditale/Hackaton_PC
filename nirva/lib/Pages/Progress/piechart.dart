import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:pie_chart/pie_chart.dart';
import 'package:cloud_firestore/cloud_firestore.dart'; // Import Firestore

class PiechartSample extends StatefulWidget {
  const PiechartSample({super.key});

  @override
  State<PiechartSample> createState() => _PiechartSampleState();
}

class _PiechartSampleState extends State<PiechartSample> {
  Map<String, double> dataMap = {
    "Breathing Exercise": 0, // Default value
    "Meditation": 0,         // Default value
  };
  List<Color> colorList = [
    const Color.fromRGBO(182, 211, 243, 100),
    const Color.fromRGBO(68, 121, 168, 100),
  ];

  @override
  void initState() {
    super.initState();
    fetchData(); // Fetch data when the widget is initialized
  }

  // Fetch data from Firestore
  Future<void> fetchData() async {
    try {
      final user = FirebaseAuth.instance.currentUser;
      final doc = await FirebaseFirestore.instance.collection('users').doc(user!.uid).get(); // Replace 'user_id' with the actual user's UID
      if (doc.exists) {
        final data = doc.data() as Map<String, dynamic>;
        setState(() {
          dataMap = {
            "Breathing Exercise": (data['breathCount'] ?? 0).toDouble(),
            "Meditation": (data['meditateCount'] ?? 0).toDouble(),
          };
        });
      } else {
        print("Document does not exist");
      }
    } catch (e) {
      print("Error fetching data: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: const Text("Pie Chart"),
        centerTitle: true,
      ),
      body: Center(
        child: dataMap["Breathing Exercise"] == 0 && dataMap["Meditation"] == 0
            ? const CircularProgressIndicator() // Show a loading indicator until data is fetched
            : PieChart(
                colorList: colorList,
                dataMap: dataMap,
                chartRadius: MediaQuery.of(context).size.width / 1.5,
                legendOptions: const LegendOptions(
                  showLegendsInRow: true,
                  legendPosition: LegendPosition.bottom,
                ),
                chartValuesOptions: const ChartValuesOptions(
                  showChartValuesInPercentage: true,
                  showChartValueBackground: false,
                ),
              ),
      ),
    );
  }
}

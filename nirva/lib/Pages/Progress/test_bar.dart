import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';


class MyBarTotal extends StatefulWidget {
  const MyBarTotal({super.key});

  @override
  State<MyBarTotal> createState() => _MyBarState();
}

class _MyBarState extends State<MyBarTotal> {
  List<double> weeklySummary = [
    0,
    0,
  ];
  @override
  void initState() {
    super.initState();
    fetchWeeklyData(); // Fetch Firestore data when the widget is initialized
  }

  Future<void> fetchWeeklyData() async {
    try {
      final user = FirebaseAuth.instance.currentUser;
      final doc = await FirebaseFirestore.instance.collection('users').doc(user!.uid).get();

      if (doc.exists) {
        final data = doc.data() as Map<String, dynamic>;
        setState(() {
          weeklySummary = [
            (data['breathCount'] ?? 0).toDouble(),
            (data['meditateCount'] ?? 0).toDouble(),
          ];
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
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/image/Bg.png'), // Replace with your background image path
            fit: BoxFit.cover,
          ),
        ),
        child: Center(
          child: SizedBox(
            height: 250,
            child: MyBarChart(
              weeklySummary: weeklySummary,
            ),
          ),
        ),
      ),
    );
  }
}

class IndividualBar {
  final int x;
  final double y;

  IndividualBar({
    required this.x,
    required this.y,
  });
}

class BarData {
  final double breathAmount;
  final double medAmount;


  BarData({
    required this.breathAmount,
    required this.medAmount,

  });

  List<IndividualBar> barData = [];

  void initializeBarData() {
    barData = [
      IndividualBar(x: 0, y: breathAmount),
      IndividualBar(x: 1, y: medAmount),

    ];
  }

}

class MyBarChart extends StatelessWidget {
  final List weeklySummary;
  const MyBarChart({
    super.key, 
    required this.weeklySummary,
  });

  @override
  Widget build(BuildContext context) {
    BarData myBar = BarData(
      breathAmount: weeklySummary[0], 
      medAmount: weeklySummary[1], 
    );
    myBar.initializeBarData();
    return BarChart(
      BarChartData(
        backgroundColor: Colors.white,
        maxY: 25,
        minY: 0,
        gridData: FlGridData(show: false),
        borderData: FlBorderData(
          show: true,
          border: Border(
            left: BorderSide(color: Colors.grey, width: 1), // Show the Y-axis border
            bottom: BorderSide(color: Colors.grey, width: 1), // Show the X-axis border
            top: BorderSide.none, // Hide the top border
            right: BorderSide(color: const Color.fromARGB(255, 0, 0, 0), width: 1), // Hide the right border
          ),
        ),
        titlesData: FlTitlesData(
          show: true,
          topTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
          rightTitles: AxisTitles(
            sideTitles: SideTitles(
              showTitles: false,
              )
            ),
          bottomTitles: AxisTitles(
            sideTitles: SideTitles(
              showTitles: true,
              getTitlesWidget: getButtomTitles,
              reservedSize: 35,
            ),
          ),
        ),
        barGroups: myBar.barData
          .map(
            (data) => BarChartGroupData(
              x: data.x,
              barRods: [
                BarChartRodData(
                  toY: data.y,
                  color: Colors.lightBlue,
                  width: 30,
                  borderRadius: BorderRadius.circular(0),
                  backDrawRodData: BackgroundBarChartRodData(
                    show: true,
                    toY: 25,
                    color: const Color.fromARGB(105, 188, 226, 244),
                  )
                ),
              ]
            ),
          )
          .toList(),
      ),
    );
  }
}

Widget getButtomTitles(double value, TitleMeta meta) {
  const style = TextStyle(
    color: Colors.black,
    fontWeight: FontWeight.bold,
    fontSize: 14,
  );

  Widget text;
  switch (value.toInt()) {
    case 0:
      text = Text('Breathing', style: style);
      break;
    case 1:
      text = Text('Meditation', style: style);
      break;
    default:
      text = Text('', style: style);
      break;
  }
  
  return SideTitleWidget(axisSide: meta.axisSide, child: text);
}
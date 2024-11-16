import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';

void main() {
  runApp(TestBar());
}

class TestBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: MyWidget(),
    );
  }
}

class MyWidget extends StatefulWidget {
  const MyWidget({super.key});

  @override
  State<MyWidget> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<MyWidget> {
  List<double> weeklySummary = [
    10,
    50,
    40,
    10,
    20,
    35,
    10,
  ];
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
            height: 400,
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
  final double sunAmount;
  final double monAmount;
  final double tueAmount;
  final double wedAmount;
  final double thuAmount;
  final double friAmount;
  final double satAmount;

  BarData({
    required this.sunAmount,
    required this.monAmount,
    required this.tueAmount,
    required this.wedAmount,
    required this.thuAmount,
    required this.friAmount,
    required this.satAmount,
  });

  List<IndividualBar> barData = [];

  void initializeBarData() {
    barData = [
      IndividualBar(x: 0, y: sunAmount),
      IndividualBar(x: 0, y: monAmount),
      IndividualBar(x: 0, y: tueAmount),
      IndividualBar(x: 0, y: wedAmount),
      IndividualBar(x: 0, y: thuAmount),
      IndividualBar(x: 0, y: friAmount),
      IndividualBar(x: 0, y: satAmount),

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
      sunAmount: weeklySummary[0], 
      monAmount: weeklySummary[1], 
      tueAmount: weeklySummary[2], 
      wedAmount: weeklySummary[3], 
      thuAmount: weeklySummary[4], 
      friAmount: weeklySummary[5], 
      satAmount: weeklySummary[6],
    );
    myBar.initializeBarData();
    return BarChart(
      BarChartData(
        backgroundColor: Colors.white,
        maxY: 50,
        minY: 0,
        gridData: FlGridData(show: false),
        // borderData: FlBorderData(show: false),
        // titlesData: FlTitlesData(
        //   show: true,
        //   topTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
        //   leftTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
        //   rightTitles: AxisTitles(sideTitles: SideTitles(showTitles: false))
        // ),
        barGroups: myBar.barData
          .map(
            (data) => BarChartGroupData(
              x: data.x,
              barRods: [
                BarChartRodData(
                  toY: data.y,
                  color: Colors.lightBlue,
                  width: 25,
                  borderRadius: BorderRadius.circular(0),
                  backDrawRodData: BackgroundBarChartRodData(
                    show: true,
                    toY: 50,
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
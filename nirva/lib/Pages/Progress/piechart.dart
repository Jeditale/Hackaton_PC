import 'package:flutter/material.dart';
import 'package:pie_chart/pie_chart.dart';

void main() {
  runApp(const PiechartApp());
}

class PiechartApp extends StatelessWidget {
  const PiechartApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Pie Chart Example',
      home: PiechartSample(),
    );
  }
}

class PiechartSample extends StatelessWidget {
  Map<String, double> dataMap = {
    "Breathing Exercise": 7, //count from user
    "Meditation": 5,//count from user
  };
  List<Color> colorList =[
    const Color.fromRGBO(182, 211, 243, 100),
    const Color.fromRGBO(68, 121, 168, 100),
  ];

  PiechartSample({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: const Text("Pie Chart"),
        centerTitle: true,
      ),
      body: Center(
        child: PieChart(
          colorList: colorList,
          dataMap: dataMap,
          chartRadius: MediaQuery.of(context).size.width / 1.5,
          legendOptions: const LegendOptions(
            showLegendsInRow: true,
            legendPosition: LegendPosition.bottom
          ),
          chartValuesOptions: 
            const ChartValuesOptions(
              showChartValuesInPercentage: true,
              showChartValueBackground: false,
            ),
        )
      )
    );
  }
}

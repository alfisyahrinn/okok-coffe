import 'package:flutter/material.dart';
import 'package:okok_coffe/services/firebase_service.dart';
import 'package:okok_coffe/utils/color.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class ReportPage extends StatelessWidget {
  const ReportPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Text(
          "Report",
          style: TextStyle(
            color: MyColor.primary,
            fontSize: 20,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
      body: ListView(
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 16,
              ),
              Center(
                child: Text(
                  "Total penjualan",
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 18,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),
              SizedBox(
                height: 16,
              ),
              SizedBox(
                height: 300,
                child: SfCartesianChart(
                  // Initialize category axis
                  primaryXAxis: CategoryAxis(),
                  series: <LineSeries<SalesData, String>>[
                    LineSeries<SalesData, String>(
                        dataSource: <SalesData>[
                          SalesData('Nov', 0),
                          SalesData('Des', 10),
                        ],
                        xValueMapper: (SalesData sales, _) => sales.year,
                        yValueMapper: (SalesData sales, _) => sales.sales)
                  ],
                ),
              ),
              SizedBox(
                height: 16,
              ),
              SizedBox(
                height: 400,
                child: SfCircularChart(
                  title: ChartTitle(text: 'Produk Terlaris'),
                  legend: Legend(isVisible: true),
                  series: <PieSeries<_PieData, String>>[
                    PieSeries<_PieData, String>(
                        explode: true,
                        explodeIndex: 0,
                        dataSource: pieData,
                        xValueMapper: (_PieData data, _) => data.xData,
                        yValueMapper: (_PieData data, _) => data.yData,
                        dataLabelMapper: (_PieData data, _) => data.text,
                        dataLabelSettings: DataLabelSettings(isVisible: true)),
                  ],
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}

List<_PieData> pieData = [
  _PieData('Green Forever', 30, 'Green Forever'),
  _PieData('Bakso Urat', 20, 'Bakso Urat'),
  _PieData('Hot Caoklat', 50, 'Hot Coklat'),
];

class SalesData {
  SalesData(this.year, this.sales);
  final String year;
  final double sales;
}

class _PieData {
  _PieData(this.xData, this.yData, [this.text]);
  final String xData;
  final num yData;
  String? text;
}

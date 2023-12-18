import 'package:flutter/material.dart';
import 'package:okok_coffe/utils/color.dart';

class ReportPage extends StatelessWidget {
  const ReportPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Text(
          "Transaksi  ",
          style: TextStyle(
            color: MyColor.primary,
            fontSize: 20,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
      body: Center(
        child: Text("Report Page"),
      ),
    );
  }
}

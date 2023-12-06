import 'package:flutter/material.dart';
import 'package:okok_coffe/pages/home/home_page.dart';
import 'package:okok_coffe/pages/login/login_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: HomePage(),
    );
  }
}

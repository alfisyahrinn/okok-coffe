import 'package:flutter/material.dart';

class TransaksiPage extends StatefulWidget {
  const TransaksiPage({super.key});

  @override
  State<TransaksiPage> createState() => _TransaksiPageState();
}

class _TransaksiPageState extends State<TransaksiPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Transaksi"),
      ),
      body: Center(
        child: Text("Transaksi Page"),
      ),
      // bottomNavigationBar: Navbar(),
    );
  }
}
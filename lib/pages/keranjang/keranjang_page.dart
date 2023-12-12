import 'package:flutter/material.dart';

class KeranjangPage extends StatefulWidget {
  const KeranjangPage({super.key});

  @override
  State<KeranjangPage> createState() => _KeranjangPageState();
}

class _KeranjangPageState extends State<KeranjangPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Keranjang  "),
      ),
      body: Center(
        child: Text("Keranjang   Page"),
      ),
      // bottomNavigationBar: Navbar(),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:okok_coffe/pages/account/account_page.dart';
import 'package:okok_coffe/pages/home/home_page.dart';
import 'package:okok_coffe/pages/keranjang/keranjang_page.dart';
import 'package:okok_coffe/pages/transaksi/transaksi_page.dart';
import 'package:okok_coffe/utils/color.dart';

class Navbar extends StatefulWidget {
  final int initialIndex; // Tambahkan parameter opsional

  const Navbar({Key? key, this.initialIndex = 0})
      : super(key: key); // Set parameter opsional dengan nilai default 0

  @override
  _NavbarState createState() => _NavbarState(
      initialIndex); // Gunakan nilai initialIndex untuk inisialisasi _NavbarState
}

class _NavbarState extends State<Navbar> {
  int _currentIndex;

  // Konstruktor menerima nilai _currentIndex
  _NavbarState(this._currentIndex);

  final List<Widget> _pages = [
    HomePage(),
    KeranjangPage(),
    TransaksiPage(),
    AccountPage(),
  ];

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: _pages[_currentIndex],
        bottomNavigationBar: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          backgroundColor: Colors.white70,
          unselectedItemColor: Colors.black38,
          selectedItemColor: MyColor.primary,
          currentIndex: _currentIndex,
          onTap: (int index) {
            setState(() {
              _currentIndex = index;
            });
          },
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.shopping_cart),
              label: 'Trolley',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.account_balance_wallet_rounded),
              label: 'Transaction',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.account_circle),
              label: 'Account',
            ),
          ],
        ),
      ),
    );
  }
}

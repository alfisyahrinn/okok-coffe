import 'package:flutter/material.dart';

class AccountPage extends StatefulWidget {
  const AccountPage({super.key});

  @override
  State<AccountPage> createState() => _AccountPageState();
}

class _AccountPageState extends State<AccountPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Account"),
      ),
      body: Center(
        child: Text(
          "Acccount Mitha tellah di edit okokk",
          style: TextStyle(fontSize: 16),
        ),
      ),
      // bottomNavigationBar: Navbar(),
    );
  }
}

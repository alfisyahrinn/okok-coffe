import 'package:flutter/material.dart';
import 'package:okok_coffe/utils/color.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Center(
          child: Text("Okok"),
        ),
      ),
      body: ListView(
        padding: EdgeInsets.only(right: 20, left: 20, top: 230),
        children: [
          Container(
            width: 353,
            height: 50,
            decoration: BoxDecoration(
              color: MyColor.primary,
              borderRadius: BorderRadius.circular(12),
            ),
            child: TextField(
              decoration: InputDecoration(
                border: InputBorder.none,
                hintText: 'Email',
                contentPadding: EdgeInsets.all(12),
              ),
            ),
          ),
          SizedBox(
            height: 16,
          ),
          Container(
            width: 353,
            height: 50,
            decoration: BoxDecoration(
              color: Color(0xFFF5F7FB),
              borderRadius: BorderRadius.circular(12),
            ),
            child: TextField(
              decoration: InputDecoration(
                border: InputBorder.none,
                hintText: 'Password',
                contentPadding: EdgeInsets.all(12),
              ),
            ),
          ),
          SizedBox(
            height: 16,
          ),
          ElevatedButton(
            onPressed: () {},
            child: Text(
              "Login",
            ),
            style: ElevatedButton.styleFrom(
              minimumSize: Size(353, 50),
              primary: Color(0xFF00623B),
            ),
          ),
        ],
      ),
    );
  }
}

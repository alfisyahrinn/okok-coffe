import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:okok_coffe/consts/consts.dart';
import 'package:okok_coffe/controller/auth_controller.dart';
import 'package:okok_coffe/widgets/Loading.dart';
import 'package:okok_coffe/widgets/Navbar.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    auth.authStateChanges().listen((User? user) {
      if (user == null) {
        Get.to(() => LoginPage());
      } else {
        Get.to(() => Navbar());
      }
    });
    var controller = Get.put(AuthController());
    TextEditingController emailController = TextEditingController();
    TextEditingController passwordController = TextEditingController();
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Center(
          child: Text(""),
        ),
      ),
      body: ListView(
        padding: EdgeInsets.only(right: 20, left: 20, top: 230),
        children: [
          Container(
            width: 353,
            height: 50,
            decoration: BoxDecoration(
              color: Color(0xFFF5F7FB),
              borderRadius: BorderRadius.circular(12),
            ),
            child: TextField(
              controller: emailController,
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
              controller: passwordController,
              obscureText: true,
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
          Obx(
            () => ElevatedButton(
              onPressed: () {
                controller.isLoading(true);
                controller
                    .loginMethod(
                  email: emailController.text,
                  password: passwordController.text,
                )
                    .then((value) {
                  print(value);
                  if (value != null) {
                    Get.offAll(() => const Navbar());
                  }
                  controller.isLoading(false);
                });
              },
              child: controller.isLoading.value
                  ? Loading()
                  : Text(
                      "Login",
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
              style: ElevatedButton.styleFrom(
                minimumSize: Size(353, 50),
                backgroundColor: Color(0xFF00623B),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

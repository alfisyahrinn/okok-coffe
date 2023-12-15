import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:okok_coffe/pages/controller/auth_controller.dart';
import 'package:okok_coffe/utils/color.dart';
import 'package:okok_coffe/widgets/Navbar.dart';

class RegisterPage extends StatelessWidget {
  RegisterPage({super.key});

  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    var controller = Get.put(AuthController());

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: const Center(
          child: Text(""),
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.only(right: 20, left: 20, top: 113),
        children: [
          Center(
            child: Text(
              "Register.",
              style: TextStyle(
                color: MyColor.primary,
                fontSize: 24,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          const SizedBox(
            height: 14,
          ),
          Container(
            width: 353,
            height: 50,
            decoration: BoxDecoration(
              color: const Color(0xFFF5F7FB),
              borderRadius: BorderRadius.circular(12),
            ),
            child: TextField(
              controller: nameController,
              decoration: InputDecoration(
                border: InputBorder.none,
                hintText: 'Name',
                contentPadding: EdgeInsets.all(12),
              ),
            ),
          ),
          const SizedBox(
            height: 16,
          ),
          Container(
            width: 353,
            height: 50,
            decoration: BoxDecoration(
              color: const Color(0xFFF5F7FB),
              borderRadius: BorderRadius.circular(12),
            ),
            child: TextField(
              controller: emailController,
              decoration: InputDecoration(
                border: InputBorder.none,
                hintText: 'email',
                contentPadding: EdgeInsets.all(12),
              ),
            ),
          ),
          const SizedBox(
            height: 16,
          ),
          Container(
            width: 353,
            height: 50,
            decoration: BoxDecoration(
              color: const Color(0xFFF5F7FB),
              borderRadius: BorderRadius.circular(12),
            ),
            child: TextField(
              controller: passwordController,
              obscureText: true,
              decoration: InputDecoration(
                border: InputBorder.none,
                hintText: 'password',
                contentPadding: EdgeInsets.all(12),
              ),
            ),
          ),
          const SizedBox(
            height: 16,
          ),
          Container(
            width: 353,
            height: 50,
            decoration: BoxDecoration(
              color: const Color(0xFFF5F7FB),
              borderRadius: BorderRadius.circular(12),
            ),
            child: TextField(
              controller: confirmPasswordController,
              obscureText: true,
              decoration: InputDecoration(
                border: InputBorder.none,
                hintText: 'Confirm Password',
                contentPadding: EdgeInsets.all(12),
              ),
            ),
          ),
          const SizedBox(
            height: 16,
          ),
          ElevatedButton(
            onPressed: () async {
              try {
                controller
                    .registerMethod(
                      email: emailController.text,
                      password: passwordController.text,
                    )
                    .then((value) => Get.offAll(() => Navbar()));
              } catch (e) {}

              // Get.offAll(() => HomePage());
            },
            child: Text(
              "Register",
              style: TextStyle(
                color: Colors.white,
              ),
            ),
            style: ElevatedButton.styleFrom(
              minimumSize: const Size(353, 50),
              backgroundColor: const Color(0xFF00623B),
            ),
          ),
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:okok_coffe/pages/register/register_page.dart';
import 'package:okok_coffe/utils/color.dart';

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
          title: Center(
            child: Text("Account"),
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  CircleAvatar(
                    radius: 50,
                    backgroundImage:
                        NetworkImage('https://via.placeholder.com/100'),
                  ),
                  SizedBox(
                      width:
                          20), // Menambahkan jarak antara CircleAvatar dan teks
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        'Nama Pengguna',
                        style: TextStyle(
                          fontSize: 20,
                          color: MyColor.primary,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        'email@example.com',
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.grey[400],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              SizedBox(
                height: 42,
              ),
              GestureDetector(
                  onTap: () {
                    print("klik register");
                    Get.to(() => RegisterPage());
                  },
                  child: Row(
                    children: [
                      Icon(
                        Icons.accessibility_new,
                        color: MyColor.secondary,
                      ),
                      SizedBox(
                        width: 8,
                      ),
                      Text(
                        "Create new Account",
                        style: TextStyle(
                          color: MyColor.secondary,
                          fontSize: 18,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ],
                  )),
              SizedBox(
                height: 16,
              ),
              GestureDetector(
                onTap: () {
                  print("Logout");
                },
                child: Row(
                  children: [
                    Icon(
                      Icons.logout_outlined,
                      color: Colors.red[300],
                    ),
                    SizedBox(
                      width: 8,
                    ),
                    Text(
                      "Logout",
                      style: TextStyle(
                        color: Colors.red[300],
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ));
  }
}

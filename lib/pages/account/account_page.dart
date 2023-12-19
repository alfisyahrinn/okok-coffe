import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:okok_coffe/consts/consts.dart';
import 'package:okok_coffe/controller/auth_controller.dart';
import 'package:okok_coffe/pages/login/login_page.dart';
import 'package:okok_coffe/pages/register/register_page.dart';
import 'package:okok_coffe/pages/report/report_page.dart';
import 'package:okok_coffe/services/firebase_service.dart';
import 'package:okok_coffe/utils/color.dart';
import 'package:okok_coffe/widgets/Loading.dart';

class AccountPage extends StatefulWidget {
  const AccountPage({super.key});

  @override
  State<AccountPage> createState() => _AccountPageState();
}

class _AccountPageState extends State<AccountPage> {
  var controller = Get.put(AuthController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(
          child: Text("Account"),
        ),
      ),
      body: StreamBuilder(
        stream: FirebaseServie.getUser(controller.currentUser.value!.uid),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (!snapshot.hasData) {
            return Center(
              child: Loading(),
            );
          } else {
            if (snapshot.hasError) {
              return Center(
                child: Text('Error: ${snapshot.error}'),
              );
            } else if (snapshot.hasData && snapshot.data!.docs.isNotEmpty) {
              var data = snapshot.data!.docs[0];
              print(currentUser!.uid);
              return Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
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
                        SizedBox(width: 20),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text(
                              data['name'] ?? 'name',
                              style: TextStyle(
                                fontSize: 20,
                                color: MyColor.primary,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              currentUser?.email ?? 'email',
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
                    data['role'] == 'admin'
                        ? Column(
                            children: [
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
                                ),
                              ),
                              SizedBox(
                                height: 16,
                              ),
                              GestureDetector(
                                onTap: () {
                                  print("klik register");
                                  Get.to(() => ReportPage());
                                },
                                child: Row(
                                  children: [
                                    Icon(
                                      Icons.bar_chart,
                                      color: MyColor.secondary,
                                    ),
                                    SizedBox(
                                      width: 8,
                                    ),
                                    Text(
                                      "Report",
                                      style: TextStyle(
                                        color: MyColor.secondary,
                                        fontSize: 18,
                                        fontWeight: FontWeight.w400,
                                      ),
                                    ),
                                  ],
                                ),
                              )
                            ],
                          )
                        : Container(),
                    SizedBox(
                      height: 16,
                    ),
                    GestureDetector(
                      onTap: () {
                        controller
                            .logoutMethod()
                            .then((value) => Get.offAll(LoginPage()));
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
              );
            } else {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Something whrong!!",
                    ),
                    SizedBox(
                      height: 8,
                    ),
                    ElevatedButton(
                      onPressed: () {
                        controller
                            .logoutMethod()
                            .then((value) => Get.offAll(LoginPage()));
                      },
                      child:
                          Text("Logout", style: TextStyle(color: Colors.white)),
                      style:
                          ElevatedButton.styleFrom(backgroundColor: Colors.red),
                    ),
                  ],
                ),
              );
            }
          }
        },
      ),
    );
  }
}

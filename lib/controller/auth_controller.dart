import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:okok_coffe/consts/firebase_const.dart';

class AuthController extends GetxController {
  var isLoading = false.obs;
  Rx<User?> currentUser = Rx<User?>(FirebaseAuth.instance.currentUser);
  List datas = [];
  Future<UserCredential?> loginMethod({email, password}) async {
    UserCredential? userCredential;
    try {
      userCredential = await auth
          .signInWithEmailAndPassword(email: email, password: password)
          .then((value) {
        currentUser.value = value.user;
        print({currentUser.value!.uid, currentUser.value!.email});
        ;
      });
    } catch (e) {
      Get.snackbar(
        "Error",
        e.toString(),
        backgroundColor: Colors.red,
      );
    }
    return userCredential;
  }

  Future<UserCredential?> registerMethod({email, password}) async {
    UserCredential? userCredential;
    try {
      userCredential = await auth.createUserWithEmailAndPassword(
          email: email, password: password);
    } catch (e) {
      print(e);
    }
    return userCredential;
  }

  Future<void> logoutMethod() async {
    await auth.signOut().then((value) {
      currentUser.value = null;
    });
  }

  Future<void> storeUserData({name, email, password, uid}) async {
    DocumentReference result = await firestore.collection("users").doc(uid);

    result.set({
      'id': uid,
      'name': name,
      'email': email,
      'password': password,
      'role': 'user',
    });
  }

  // storeUserData({name, email, password}) async {
  //   await firestore.collection("users").doc(currentUser?.uid).set({
  //     'uuid': currentUser?.uid,
  //     'name': name,
  //     'email': email,
  //     'password': password,
  //   });
  // }
}

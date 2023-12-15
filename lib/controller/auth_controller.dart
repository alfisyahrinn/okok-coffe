import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:okok_coffe/consts/firebase_const.dart';

class AuthController extends GetxController {
  var isLoading = false.obs;
  Future<UserCredential?> loginMethod({email, password}) async {
    UserCredential? userCredential;
    try {
      userCredential = await auth.signInWithEmailAndPassword(
          email: email, password: password);
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
      await auth.createUserWithEmailAndPassword(
          email: email, password: password);
    } catch (e) {
      print(e);
    }
    return userCredential;
  }

  Future<void> logoutMethod() async {
    await auth.signOut();
  }

  Future<void> storeUserData({name, email, password}) async {
    DocumentReference result =
        await firestore.collection("users").doc(currentUser!.uid);

    result.set({
      'id': currentUser!.uid,
      'name': name,
      'email': email,
      'password': password,
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

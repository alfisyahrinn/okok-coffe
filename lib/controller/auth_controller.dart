import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:okok_coffe/consts/firebase_const.dart';

class AuthController extends GetxController {
  Future<UserCredential?> loginMethod({email, password}) async {
    UserCredential? userCredential;
    try {
      await auth.signInWithEmailAndPassword(email: email, password: password);
    } catch (e) {
      print(e);
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
        await firestore.collection("users").doc(currentUser?.uid);

    result.set({
      'uuid': currentUser?.uid,
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

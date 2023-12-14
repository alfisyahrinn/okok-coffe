import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:okok_coffe/consts/firebase_const.dart';

class AuthController extends GetxController {
  Future<UserCredential?> loginMethod({email, password}) async {
    UserCredential? userCredential;
    try {
      auth.signInWithEmailAndPassword(email: email, password: password);
    } on FirebaseAuthException catch (e) {
      Get.snackbar("Wrong password or email bg", e.toString());
    }
    return userCredential;
  }

  Future<UserCredential?> registerMethod({email, password}) async {
    UserCredential? userCredential;
    try {
      auth.createUserWithEmailAndPassword(email: email, password: password);
    } on FirebaseAuthException catch (e) {
      Get.snackbar("Wrong password or email bg", e.toString());
    }
    return userCredential;
  }

  storeUserData({name, email, password}) async {
    DocumentReference store =
        await firestore.collection("users").doc(currentUser!.uid);
    store.set({
      'uuid': currentUser?.uid,
      'name': name,
      'email': email,
      'password': password,
    });
  }

  signOutMethod() async {
    await auth.signOut();
  }
}

import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:okok_coffe/pages/consts/consts.dart';

class AuthController extends GetxController {
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
}

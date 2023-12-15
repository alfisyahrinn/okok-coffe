import 'package:okok_coffe/consts/consts.dart';

class FirebaseServie {
  static getUser(uid) {
    return firestore
        .collection("users")
        .where('id', isEqualTo: uid)
        .snapshots();
  }

  
}

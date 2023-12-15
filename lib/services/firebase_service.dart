import 'package:okok_coffe/consts/consts.dart';

class FirebaseServie {
  static getUser(uid) {
    return firestore
        .collection("users")
        .where('id', isEqualTo: uid)
        .snapshots();
  }

  static getBaranag() {
    return firestore.collection("products").get();
  }

  static checkCart(uid) {
    return firestore.collection("keranjangs").doc(uid).get();
  }
}

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:okok_coffe/consts/consts.dart';

class ProductController extends GetxController {
  Future<void> addToCart({name, uid, price, img, desc, category}) async {
    DocumentReference cart = await firestore.collection("keranjangs").doc(uid);
    cart.set({
      "uid": uid,
      "name": name,
      "price": price,
      "img": img,
      "desc": desc,
      "category": category,
      "qty": 1,
    });
  }

  Future<void> updateCartQty(uid, qty) async {
    await firestore.collection("keranjangs").doc(uid).update(
      {'qty': qty}
    );
  }
}

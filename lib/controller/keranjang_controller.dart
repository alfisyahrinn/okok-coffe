import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:okok_coffe/consts/consts.dart';
import 'package:okok_coffe/widgets/Navbar.dart';

class KeranjangController extends GetxController {
  // Variabel observable untuk quantity dari setiap produk
  RxMap productQty = {}.obs;
  RxMap productPrice = {}.obs;
  RxInt totalPrice = 0.obs;
  RxBool isRefresh = false.obs;

  void getDataFromSnapshot(snapshot) {
    snapshot.data!.docs.forEach((data) {
      String productId =
          data.id; // Ganti dengan key yang mengidentifikasi produk
      int qtyFromFirestore =
          data['qty']; // Ganti dengan nilai qty dari Firestore
      int priceFirestore = int.parse(data['price']);
      setQtyFromFirestore(productId, qtyFromFirestore);
      setTotalPrice(productId, priceFirestore);
    });
  }

  // Fungsi untuk mengatur nilai quantity dari Firestore
  void setQtyFromFirestore(String productId, int initialQty) {
    productQty[productId] = initialQty;
  }

  void setTotalPrice(String productId, int price) {
    productPrice[productId] = price;
    totalPrice += productPrice[productId] * productQty[productId];
    // print({productPrice[productId], productQty[productId]});
    // print(totalPrice);
  }

  // Fungsi untuk menambah nilai quantity
  void incrementQty(String productId) {
    productQty[productId] = (productQty[productId] ?? 0) + 1;
    print({productPrice[productId], productQty[productId]});
    totalPrice += productPrice[productId];
  }

  // Fungsi untuk mengurangi nilai quantity
  void decrementQty(String productId) {
    if (productQty[productId] != null && productQty[productId]! > 1) {
      productQty[productId] = productQty[productId]! - 1;
      totalPrice -= productPrice[productId];
    }
  }

  Future<void> deleteItemsKeranjang(id, name) async {
    await firestore
        .collection("keranjangs")
        .doc(id)
        .delete()
        .then(
          (value) => Get.snackbar(name, "Produk berhasil dihapus",
              backgroundColor: Colors.red),
        )
        .then((value) => Get.offAll(() => Navbar(initialIndex: 1)));
  }

  Future<void> setChekout({
    name,
    totalPrice,
    status,
    List<Map<String, dynamic>>? products,
    user,
    datetime,
  }) async {
    DocumentReference cart = await firestore.collection("transactions").add({
      "name": name,
      "totalPrice": totalPrice,
      "status": status,
      "user": user,
      "products": products,
      "datetime" : datetime,
    });
  }

  Future<void> deleteAllKeranjangs() async {
    List idList = productQty.keys.toList();
    for (String id in idList) {
      await firestore.collection("keranjangs").doc(id).delete();
    }
  }
}

import 'package:get/get.dart';

class KeranjangController extends GetxController {
  // Variabel observable untuk quantity dari setiap produk
  RxMap productQty = {}.obs;
  RxMap productPrice = {}.obs;
  RxInt totalPrice = 0.obs;

  // Fungsi untuk mengatur nilai quantity dari Firestore
  void setQtyFromFirestore(String productId, int initialQty) {
    productQty[productId] = initialQty;
  }

  void setTotalPrice(String productId, int initialQty, int price) {
    productPrice[productId] = price;
    // print({productPrice[productId], productQty[productId]});
    totalPrice += productPrice[productId] * productQty[productId];
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
}

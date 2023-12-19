import 'package:cloud_firestore/cloud_firestore.dart';

num totalPrice(QuerySnapshot snapshot) {
  num totalPrice = 0;

  snapshot.docs.forEach((DocumentSnapshot document) {
    Map<String, dynamic> data = document.data() as Map<String, dynamic>;
    // Pastikan field "price" dalam data memiliki tipe data numerik (num/int)
    totalPrice += int.parse(data['price']) * data['qty'];
    // Menambahkan harga dari setiap item dikali dengan quantity (qty) nya
  });

  return totalPrice;
}

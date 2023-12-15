import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:okok_coffe/consts/consts.dart';

class ProductController extends GetxController {
  Future<void> getProduct() async {
    QuerySnapshot querySnapshot = await firestore.collection("products").get();
  }
}

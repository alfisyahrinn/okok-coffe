import 'package:get/get.dart';
import 'package:okok_coffe/consts/firebase_const.dart';
import 'package:okok_coffe/widgets/Navbar.dart';

class TransactionController extends GetxController {
  Future<void> updateTransaction({uid, name}) async {
    await firestore
        .collection("transactions")
        .doc(uid)
        .update({
          'status': true,
        })
        .then((value) => Get.snackbar(
              "Meja ${name}",
              "Transaksi berhasil",
            ))
        .then((value) => Get.offAll(() => Navbar(initialIndex: 0)));
  }
}

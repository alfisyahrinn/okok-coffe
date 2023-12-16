import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:okok_coffe/controller/keranjang_controller.dart';
import 'package:okok_coffe/services/firebase_service.dart';
import 'package:okok_coffe/utils/color.dart';
import 'package:okok_coffe/utils/price_format.dart';
import 'package:okok_coffe/utils/total_price.dart';
import 'package:okok_coffe/widgets/Loading.dart';

class KeranjangPage extends StatefulWidget {
  const KeranjangPage({super.key});

  @override
  State<KeranjangPage> createState() => _KeranjangPageState();
}

class _KeranjangPageState extends State<KeranjangPage> {
  @override
  Widget build(BuildContext context) {
    var controller = Get.put(KeranjangController());
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Center(
          child: Text(
            "Keranjang",
            style: TextStyle(
              color: MyColor.primary,
              fontSize: 18,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      ),
      body: FutureBuilder(
        future: FirebaseServie.getKeranjangs(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          var asu = totalPrice(snapshot.data!);
          snapshot.data!.docs.forEach((data) {
            String productId =
                data.id; // Ganti dengan key yang mengidentifikasi produk
            int qtyFromFirestore =
                data['qty']; // Ganti dengan nilai qty dari Firestore
            int priceFirestore = int.parse(data['price']);
            controller.setQtyFromFirestore(productId, qtyFromFirestore);
            controller.setTotalPrice(
                productId, qtyFromFirestore, priceFirestore);
          });
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: Loading(),
            );
          } else {
            if (snapshot.data!.docs.isEmpty) {
              return Center(
                child: Text("Keranjang masih kosong"),
              );
            } else {
              return Stack(
                children: [
                  ListView.builder(
                    itemCount: snapshot.data!.docs.length,
                    itemBuilder: (context, index) {
                      var data = snapshot.data!.docs[index];
                      String productId = data.id;

                      return Card(
                        color: Colors.white70,
                        margin: const EdgeInsets.all(8),
                        child: ListTile(
                          leading: Container(
                              height: 58,
                              width: 58,
                              alignment: Alignment.center,
                              decoration: ShapeDecoration(
                                color: MyColor.primary,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(8)),
                              ),
                              child: Obx(
                                () => Text(
                                  controller.productQty[productId].toString(),
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 31,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              )),
                          title: Text(
                            "${data['name']}",
                            style: TextStyle(
                              // fontSize: 14,
                              color: MyColor.primary,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          subtitle: Text(
                            priceFormat(data["price"]),
                            style: TextStyle(
                              // fontSize: 10,
                              color: MyColor.primary,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          trailing: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              TextButton(
                                onPressed: () {
                                  controller.decrementQty(data.id);
                                },
                                child: Icon(
                                  Icons.remove,
                                  color: Colors.black,
                                ),
                              ),
                              Obx(
                                () => Text(
                                  controller.productQty[productId].toString(),
                                  style: TextStyle(
                                    fontSize: 16,
                                    color: Colors.black,
                                  ),
                                ),
                              ),
                              TextButton(
                                onPressed: () {
                                  controller.incrementQty(data.id);
                                },
                                child: Icon(
                                  Icons.add,
                                  color: Colors.black,
                                ),
                              ),
                              SizedBox(
                                width: 32,
                              ),
                              IconButton(
                                icon: const Icon(
                                  Icons.delete,
                                  color: Colors.redAccent,
                                ),
                                onPressed: () {
                                  Get.snackbar(
                                      "Delete", "Produk berhasil dihapus");
                                },
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                  Positioned(
                    left: 0,
                    right: 0,
                    bottom: 0,
                    child: Container(
                      width: MediaQuery.of(context).size.width,
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.bottomCenter,
                          end: Alignment.topCenter,
                          colors: [
                            Colors.black38,
                            Colors.black45,
                            Colors.black54,
                            Colors.transparent,
                          ],
                        ),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 8, vertical: 8),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'Total Harga : ',
                                  style: TextStyle(
                                    fontWeight: FontWeight.w500,
                                    color: Colors.white,
                                    fontSize: 18,
                                  ),
                                ),
                                Obx(
                                  () => Text(
                                    priceFormat(
                                      controller.totalPrice.toString(),
                                    ),
                                    style: TextStyle(
                                      fontWeight: FontWeight.w500,
                                      color: Colors.white,
                                      fontSize: 18,
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 8),
                            child: ElevatedButton(
                              onPressed: () {},
                              child: Text(
                                'Checkout',
                                style: TextStyle(
                                  fontSize: 16,
                                  color: Colors.white,
                                ),
                              ),
                              style: ElevatedButton.styleFrom(
                                backgroundColor: MyColor.primary,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 8,
                          )
                        ],
                      ),
                    ),
                  ),
                ],
              );
            }
          }
        },
      ),
    );
  }
}

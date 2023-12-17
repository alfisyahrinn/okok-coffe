import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:okok_coffe/consts/consts.dart';
import 'package:okok_coffe/controller/keranjang_controller.dart';
import 'package:okok_coffe/services/firebase_service.dart';
import 'package:okok_coffe/utils/color.dart';
import 'package:okok_coffe/utils/datetime.dart';
import 'package:okok_coffe/utils/price_format.dart';
import 'package:okok_coffe/widgets/Loading.dart';
import 'package:okok_coffe/widgets/Navbar.dart';

class KeranjangPage extends StatefulWidget {
  const KeranjangPage({super.key});

  @override
  State<KeranjangPage> createState() => _KeranjangPageState();
}

class _KeranjangPageState extends State<KeranjangPage> {
  @override
  void dispose() {
    Get.delete<KeranjangController>();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var controller = Get.put(KeranjangController());
    DateTime dateTime = DateTime.now();
    List<Map<String, dynamic>> productsList = [];
    Map<String, dynamic> userData = {
      'name': currentUser!.email,
      'uid': currentUser!.uid,
    };
    TextEditingController noMejaController = TextEditingController();
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
          controller.getDataFromSnapshot(snapshot);
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: Loading(),
            );
          } else {
            if (snapshot.hasError) {
              return Center(
                child: Text('Error: ${snapshot.error}'),
              );
            } else if (snapshot.hasData && snapshot.data!.docs.isNotEmpty) {
              return Stack(
                children: [
                  ListView.builder(
                    itemCount: snapshot.data!.docs.length,
                    itemBuilder: (context, index) {
                      var data = snapshot.data!.docs[index];

                      String productId = data.id;
                      Map<String, dynamic> productsData = {
                        'name': data['name'],
                        'price': data['price'],
                        'img': data['img'],
                        'desc': data['desc'],
                        'category': data['category'],
                        'qty': controller.productQty[productId],
                      };
                      productsList.add(productsData);
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
                                  try {
                                    controller.deleteItemsKeranjang(
                                        data.id, data['name']);
                                  } catch (e) {
                                    Get.snackbar("Error", e.toString(),
                                        backgroundColor: Colors.redAccent);
                                  }
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
                              onPressed: () {
                                Get.defaultDialog(
                                    title: "Nomor Meja",
                                    content: Container(
                                      width: 353,
                                      height: 50,
                                      decoration: BoxDecoration(
                                        color: Color(0xFFF5F7FB),
                                        borderRadius: BorderRadius.circular(12),
                                      ),
                                      child: TextField(
                                        controller: noMejaController,
                                        decoration: InputDecoration(
                                          border: InputBorder.none,
                                          hintText: 'No Meja',
                                          contentPadding: EdgeInsets.all(12),
                                        ),
                                      ),
                                    ),
                                    actions: [
                                      ElevatedButton(
                                        onPressed: () {
                                          try {
                                            controller
                                                .setChekout(
                                                    name: noMejaController.text,
                                                    status: false,
                                                    datetime: dateTime,
                                                    user: userData,
                                                    totalPrice: controller
                                                        .totalPrice
                                                        .toString(),
                                                    products: productsList)
                                                .then((value) {
                                              return controller
                                                  .deleteAllKeranjangs();
                                            }).then((value) {
                                              Get.snackbar("Success",
                                                  "Di tambahakan ke transaksi");
                                              Get.offAll(() =>
                                                  Navbar(initialIndex: 2));
                                            });
                                          } catch (e) {
                                            Get.snackbar("Error", e.toString(),
                                                backgroundColor:
                                                    Colors.redAccent);
                                          }
                                        },
                                        child: Text(
                                          "Checkout Now",
                                          style: TextStyle(
                                            fontSize: 16,
                                            color: Colors.white,
                                          ),
                                        ),
                                        style: ElevatedButton.styleFrom(
                                          backgroundColor: MyColor.primary,
                                          shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(8),
                                          ),
                                        ),
                                      )
                                    ]);
                              },
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
            } else {
              return Center(
                child: Text("Keranjang masih kosong"),
              );
            }
          }
        },
      ),
    );
  }
}

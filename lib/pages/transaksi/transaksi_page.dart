import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:okok_coffe/controller/transaction_controller.dart';
import 'package:okok_coffe/services/firebase_service.dart';
import 'package:okok_coffe/utils/color.dart';
import 'package:okok_coffe/utils/price_format.dart';
import 'package:okok_coffe/utils/price_item.dart';
import 'package:okok_coffe/widgets/Loading.dart';

import '../../utils/datetime.dart';

class TransaksiPage extends StatefulWidget {
  const TransaksiPage({super.key});

  @override
  State<TransaksiPage> createState() => _TransaksiPageState();
}

class _TransaksiPageState extends State<TransaksiPage> {
  var controller = Get.put(TransactionController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Center(
          child: Text(
            "Transaksi  ",
            style: TextStyle(
              color: MyColor.primary,
              fontSize: 20,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      ),
      body: FutureBuilder(
        future: FirebaseServie.getTransactions(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
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
                      print(data['products']);
                      return GestureDetector(
                        onTap: () {
                          Get.bottomSheet(
                            Container(
                              color: Colors.white,
                              child: Column(
                                children: [
                                  SizedBox(
                                    height: 16,
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 34),
                                    child: Text(
                                      "Produk Meja ${data['name']}",
                                      style: TextStyle(
                                        color: MyColor.primary,
                                        fontSize: 18,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 300,
                                    child: ListView.builder(
                                      itemCount: data['products'].length,
                                      itemBuilder: (context, index) {
                                        var product = data['products'][index];
                                        return Padding(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 34, vertical: 8),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            children: [
                                              Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.start,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    product['name'],
                                                    style:
                                                        TextStyle(fontSize: 18),
                                                  ),
                                                  Text(priceFormat(
                                                      product['price'])),
                                                ],
                                              ),
                                              Container(
                                                width: 150,
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    Text(product['qty']
                                                        .toString()),
                                                    Text(
                                                        priceFormat(itemPrice(
                                                                product['qty'],
                                                                product[
                                                                    'price'])
                                                            .toString()),
                                                        style: TextStyle(
                                                            fontSize: 16)),
                                                  ],
                                                ),
                                              ),
                                            ],
                                          ),
                                        );
                                      },
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 34),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          "Total Harga :",
                                          style: TextStyle(
                                            fontSize: 18,
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                        Text(
                                          priceFormat(data['totalPrice']),
                                          style: TextStyle(
                                            fontSize: 18,
                                            fontWeight: FontWeight.w600,
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                  SizedBox(
                                    height: 16,
                                  ),
                                  Container(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 8),
                                    height: 50,
                                    width: 400,
                                    child: ElevatedButton(
                                      onPressed: data['status'] == false
                                          ? () {
                                              controller.updateTransaction(
                                                  uid: data.id,
                                                  name: data['name']);
                                            }
                                          : null,
                                      child: Text(
                                        data['status'] == false
                                            ? "Bayar"
                                            : "Selesai",
                                        style: TextStyle(
                                          fontSize: 16,
                                          color: data['status'] == false
                                              ? Colors.white
                                              : MyColor.primary,
                                        ),
                                      ),
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor: data['status'] == false
                                            ? MyColor.primary
                                            : MyColor.secondary,
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(8),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                        child: Card(
                          color: data['status'] == false
                              ? Colors.white70
                              : MyColor.primary,
                          margin: const EdgeInsets.all(8),
                          child: ListTile(
                            leading: Container(
                              height: 58,
                              width: 58,
                              alignment: Alignment.center,
                              decoration: ShapeDecoration(
                                color: data['status'] == false
                                    ? MyColor.primary
                                    : Colors.white,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(8)),
                              ),
                              child: Text(
                                data['name'],
                                style: TextStyle(
                                  color: data['status'] == false
                                      ? Colors.white
                                      : MyColor.primary,
                                  fontSize: 31,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                            title: Row(
                              children: [
                                Text(
                                  "Meja ${data['name']}",
                                  style: TextStyle(
                                    // fontSize: 14,
                                    color: data['status'] == false
                                        ? MyColor.primary
                                        : Colors.white,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                SizedBox(
                                  width: 8,
                                ),
                                Container(
                                  alignment: Alignment.center,
                                  height: 16,
                                  width: 50,
                                  decoration: BoxDecoration(
                                    color: data['status'] == false
                                        ? Color.fromARGB(255, 250, 225, 87)
                                        : Color.fromARGB(255, 56, 255, 89),
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                  child: Text(
                                    data['status'] == false
                                        ? "Pending"
                                        : "Selesai",
                                    style: TextStyle(fontSize: 10),
                                  ),
                                )
                              ],
                            ),
                            subtitle: Text(
                              formatDateTime(data['datetime']),
                              style: TextStyle(
                                fontSize: 10,
                                color: data['status'] == false
                                    ? MyColor.primary
                                    : Colors.white,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            trailing: Text(
                              priceFormat(data["totalPrice"]),
                              style: TextStyle(
                                fontSize: 18,
                                color: data['status'] == false
                                    ? MyColor.primary
                                    : Colors.white,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                        ),
                      );
                    },
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

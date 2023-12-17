import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:okok_coffe/services/firebase_service.dart';
import 'package:okok_coffe/utils/color.dart';
import 'package:okok_coffe/utils/price_format.dart';
import 'package:okok_coffe/widgets/Loading.dart';

class TransaksiPage extends StatefulWidget {
  const TransaksiPage({super.key});

  @override
  State<TransaksiPage> createState() => _TransaksiPageState();
}

class _TransaksiPageState extends State<TransaksiPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Transaksi"),
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
                            child: Text(
                              "01",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 31,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                          title: Text(
                            "Meja 01",
                            style: TextStyle(
                              // fontSize: 14,
                              color: MyColor.primary,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          subtitle: Text(
                            priceFormat('10000000'),
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
                                onPressed: () {},
                                child: Icon(
                                  Icons.remove,
                                  color: Colors.black,
                                ),
                              ),
                              Text(
                                '1',
                                style: TextStyle(
                                  fontSize: 16,
                                  color: Colors.black,
                                ),
                              ),
                              TextButton(
                                onPressed: () {},
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
                                onPressed: () {},
                              ),
                            ],
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

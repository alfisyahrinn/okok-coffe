import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:okok_coffe/controller/product_controller.dart';
import 'package:okok_coffe/models/CategoryModel.dart';
import 'package:okok_coffe/services/firebase_service.dart';
import 'package:okok_coffe/utils/color.dart';
import 'package:okok_coffe/utils/price_format.dart';
import 'package:okok_coffe/widgets/Loading.dart';

class HomePage extends StatefulWidget {
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // const HomePage({super.key});
  List<CategoryModel> categories = [];

  void _getCategories() {
    categories = CategoryModel.getCategories();
  }

  @override
  Widget build(BuildContext context) {
    var controller = Get.put(ProductController());
    _getCategories();
    return DefaultTabController(
      length: 8,
      child: Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.transparent,
            elevation: 0,
            title: Center(
              child: Text(
                "",
                style: TextStyle(
                  color: MyColor.primary,
                  fontSize: 28,
                  fontWeight: FontWeight.w600,
                  height: 0.02,
                ),
              ),
            ),
          ),
          body: FutureBuilder(
            future: FirebaseServie.getBaranag(),
            builder:
                (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(
                  child: Loading(),
                );
              } else {
                if (snapshot.data!.docs.isEmpty) {
                  return Center(
                    child: Text("Tidak ada data"),
                  );
                } else {
                  return Padding(
                    padding: const EdgeInsets.all(20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "okok.",
                          style: TextStyle(
                            color: MyColor.primary,
                            fontSize: 32,
                            fontWeight: FontWeight.w600,
                            height: 0.02,
                          ),
                        ),
                        SizedBox(
                          height: 24,
                        ),
                        SizedBox(
                          height: 60,
                          width: double.infinity,
                          child: ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemCount: categories.length,
                            itemBuilder: (context, index) {
                              return GestureDetector(
                                child: Container(
                                  margin: EdgeInsets.all(8),
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 18, vertical: 4),
                                  decoration: BoxDecoration(
                                      color: categories[index].name == 'All'
                                          ? MyColor.primary
                                          : Color(0x0A00623B),
                                      borderRadius: BorderRadius.circular(48)),
                                  child: Center(
                                    child: Text(
                                      categories[index].name,
                                      style: TextStyle(
                                        color: categories[index].name == 'All'
                                            ? Colors.white
                                            : MyColor.secondary,
                                        fontSize: 16,
                                        fontWeight: FontWeight.w300,
                                      ),
                                    ),
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                        SizedBox(
                          height: 24,
                        ),
                        Expanded(
                          child: GridView.builder(
                            gridDelegate:
                                SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2,
                              crossAxisSpacing: 8,
                              mainAxisSpacing: 8.0,
                            ),
                            itemCount: snapshot.data!.docs.length,
                            itemBuilder: (context, index) {
                              var data = snapshot.data!.docs[index];
                              return GestureDetector(
                                onTap: () async {
                                  try {
                                    DocumentSnapshot keranjangs =
                                        await FirebaseServie.checkCart(data.id);
                                    if (keranjangs.exists) {
                                      int qty = keranjangs['qty'] + 1;
                                      controller
                                          .updateCartQty(data.id, qty)
                                          .then((value) => Get.snackbar(
                                              "${data['name']}",
                                              "Nambah 1, Total ${qty} ${data['name']}"));
                                    } else {
                                      controller
                                          .addToCart(
                                              name: data['name'],
                                              price: data['price'],
                                              img: data['img'],
                                              category: data['category'],
                                              desc: data['desc'],
                                              uid: data.id)
                                          .then((value) => Get.snackbar(
                                              '${data['name']}',
                                              "Add to card"));
                                    }
                                  } catch (e) {
                                    Get.snackbar('Error', "${e}");
                                  }
                                },
                                child: Container(
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Container(
                                        height: 80,
                                        width: 80,
                                        child: Image.network(
                                          '${data['img']}',
                                          fit: BoxFit.fill,
                                        ),
                                      ),
                                      SizedBox(height: 8),
                                      Text(
                                        '${data['name']}',
                                        style: TextStyle(
                                          color: Colors.black
                                              .withOpacity(0.7099999785423279),
                                          fontSize: 20,
                                          fontFamily: 'Poppins',
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                      SizedBox(height: 8),
                                      Text(
                                        priceFormat(data["price"]),
                                        style: TextStyle(
                                          color: Color(0xFF00623B),
                                          fontSize: 16,
                                          fontFamily: 'Poppins',
                                          fontWeight: FontWeight.w400,
                                        ),
                                      )
                                    ],
                                  ),
                                  decoration: ShapeDecoration(
                                    color: Color(0x0A00623B),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(18),
                                    ),
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                      ],
                    ),
                  );
                }
              }
            },
          )),
    );
  }
}

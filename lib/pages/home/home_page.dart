import 'package:flutter/material.dart';
import 'package:okok_coffe/models/CategoryModel.dart';
import 'package:okok_coffe/pages/account/account_page.dart';
import 'package:okok_coffe/pages/keranjang/keranjang_page.dart';
import 'package:okok_coffe/pages/transaksi/transaksi_page.dart';
import 'package:okok_coffe/utils/color.dart';

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

  int selectTabIndex = 0;

  void onNavBarTapped(int index) {
    Navigator.of(context).push(MaterialPageRoute(builder: (context) {
      if (index == 0) {
        return HomePage();
      } else if (index == 1) {
        return TransaksiPage();
      } else if (index == 2) {
        return KeranjangPage();
      } else if (index == 3) {
        return AccountPage();
      } else {
        return HomePage();
      }
    }));
    setState(() {
      selectTabIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    final listPage = [
      // Navigator.of(context).push(MaterialPageRoute(builder: (context) {
      //   return LoginPage();
      // })),
      // Navigator.of(context).push(MaterialPageRoute(builder: (context) {
      //   return LoginPage();
      // })),
      const Text("Trolly"),
      const Text("Trolly"),
      const Text("Trolly"),
      const Text("Account"),
    ];
    final bottomNavBarItems = [
      const BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
      const BottomNavigationBarItem(
          icon: Icon(Icons.account_balance_wallet_rounded),
          label: "Transaction"),
      const BottomNavigationBarItem(icon: Icon(Icons.trolley), label: "Trolly"),
      const BottomNavigationBarItem(
          icon: Icon(Icons.supervised_user_circle_rounded), label: "Account"),
    ];

    final bottomNavBar = BottomNavigationBar(
      items: bottomNavBarItems,
      type: BottomNavigationBarType.fixed,
      backgroundColor: Colors.white70,
      currentIndex: selectTabIndex,
      unselectedItemColor: Colors.black38,
      selectedItemColor: MyColor.primary,
      onTap: onNavBarTapped,
    );

    _getCategories();
    return DefaultTabController(
      length: 8, // Ganti dengan jumlah tab yang diinginkan
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
        body: Padding(
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
                    return Container(
                      margin: EdgeInsets.all(8),
                      padding:
                          EdgeInsets.symmetric(horizontal: 18, vertical: 4),
                      decoration: BoxDecoration(
                          color: MyColor.primary,
                          borderRadius: BorderRadius.circular(48)),
                      child: Center(
                        child: Text(
                          categories[index].name,
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.w300,
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
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 8,
                    mainAxisSpacing: 8.0,
                  ),
                  itemCount: 10,
                  itemBuilder: (context, index) {
                    return Container(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image.network(
                            'https://via.placeholder.com/150', // Ganti dengan URL gambar yang sesuai
                            height: 100,
                            width: 100,
                            fit: BoxFit.cover,
                          ),
                          SizedBox(height: 8),
                          Text(
                            'Cappucno',
                            style: TextStyle(
                              color:
                                  Colors.black.withOpacity(0.7099999785423279),
                              fontSize: 20,
                              fontFamily: 'Poppins',
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          SizedBox(height: 8),
                          Text(
                            'Rp.20.000',
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
                    );
                  },
                ),
              ),
            ],
          ),
        ),
        bottomNavigationBar: bottomNavBar,
      ),
    );
  }
}

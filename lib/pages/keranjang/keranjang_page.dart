import 'package:flutter/material.dart';
import 'package:okok_coffe/utils/color.dart';

class KeranjangPage extends StatefulWidget {
  const KeranjangPage({super.key});

  @override
  State<KeranjangPage> createState() => _KeranjangPageState();
}

class _KeranjangPageState extends State<KeranjangPage> {
  @override
  Widget build(BuildContext context) {
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
        body: ListView.builder(
          itemCount: 15,
          itemBuilder: (context, index) {
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
                  "Udin",
                  style: TextStyle(
                    // fontSize: 14,
                    color: MyColor.primary,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                subtitle: Text(
                  "Rp.200.000",
                  style: TextStyle(
                    // fontSize: 10,
                    color: MyColor.primary,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                trailing: IconButton(
                  icon: const Icon(Icons.delete),
                  onPressed: () {
                    final snackBar = SnackBar(
                      content: Text('${index} Berhasil di Hapus'),
                      backgroundColor: (Colors.black12),
                      action: SnackBarAction(
                        label: 'hide',
                        onPressed: () {},
                      ),
                    );
                    ScaffoldMessenger.of(context).showSnackBar(snackBar);
                  },
                ),
              ),
            );
          },
        )
        // bottomNavigationBar: Navbar(),
        );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:volume_pekerjaan/page/HomeList.dart';
import 'package:volume_pekerjaan/page/PengecatanCat.dart';
import 'package:volume_pekerjaan/widget/Button.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      appBar: AppBar(
        title: Text("Menghitung Volume Pekerjaan"),
        centerTitle: true,
        backgroundColor: Colors.transparent,
      ),
      body: Container(
          child: Center(
        child: Column(
          children: [
            SizedBox(
              height: 40,
            ),
            MyButton(
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) {
                    return MyPengecataCat();
                  }));
                },
                text: "Pengecatan Cat"),
            SizedBox(
              height: 10,
            ),
            MyButton(
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) {
                    return MyPengecataCat();
                  }));
                },
                text: "Pengecatan Cat"),
            SizedBox(
              height: 10,
            ),
            MyButton(
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) {
                    return MyPengecataCat();
                  }));
                },
                text: "Pengecatan Cat"),
            SizedBox(
              height: 10,
            ),
            MyButton(
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) {
                    return MyPengecataCat();
                  }));
                },
                text: "Pengecatan Cat"),
          ],
        ),
      )),
    );
  }
}

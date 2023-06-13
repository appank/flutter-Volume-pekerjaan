import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:volume_pekerjaan/page/HomeList.dart';
import 'package:volume_pekerjaan/page/HomePage.dart';
import 'package:volume_pekerjaan/page/HomeSheet.dart';
import 'package:volume_pekerjaan/page/_page.dart';

class MyHome extends StatefulWidget {
  const MyHome({Key? key}) : super(key: key);

  @override
  State<MyHome> createState() => _MyHomeState();
}

class _MyHomeState extends State<MyHome> {
  List Screens = [
    HomePage(),
    MyHomeSheet(),
    MyPage(),
    MyPage(),
    HomePage(),
  ];
  int _page = 0;
  GlobalKey<CurvedNavigationBarState> _bottomNavigationKey = GlobalKey();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        bottomNavigationBar: CurvedNavigationBar(
          // key: _bottomNavigationKey,
          index: _page,
          height: 60.0,
          items: <Widget>[
            Icon(Icons.add, size: 30),
            Icon(Icons.list, size: 30),
            Icon(Icons.compare_arrows, size: 30),
            Icon(Icons.call_split, size: 30),
            Icon(Icons.perm_identity, size: 30),
          ],
          color: Colors.white,
          buttonBackgroundColor: Colors.white,
          backgroundColor: Colors.grey,
          animationCurve: Curves.easeInOut,
          animationDuration: Duration(milliseconds: 400),
          onTap: (index) {
            setState(() {
              _page = index;
            });
          },
          // letIndexChange: (index) => true,
        ),
        body: Screens[_page]);
  }
}

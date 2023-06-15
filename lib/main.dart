import 'package:flutter/material.dart';
import 'package:volume_pekerjaan/api/add_sheets_api.dart';
import 'package:volume_pekerjaan/api/user_sheets_api.dart';
import 'package:volume_pekerjaan/page/Home.dart';
import 'package:volume_pekerjaan/page/HomePage.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await UserSheetsApi.init();
  await AddSheetsApi.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(debugShowCheckedModeBanner: false, home: MyHome());
  }
}

// ignore_for_file: non_constant_identifier_names

import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:volume_pekerjaan/api/user.dart';
import 'package:volume_pekerjaan/api/user_sheets_api.dart';
import 'package:volume_pekerjaan/components/widgetForm_M1.dart';
import 'package:volume_pekerjaan/components/widgetForm_M2.dart';
import 'package:volume_pekerjaan/components/widgetForm_M3.dart';

class MyPengecataCat extends StatefulWidget {
  MyPengecataCat({Key? key}) : super(key: key);
  @override
  State<MyPengecataCat> createState() => _MyPengecataCatState();
}

class _MyPengecataCatState extends State<MyPengecataCat> {
  User? user;

  @override
  void initState() {
    super.initState();

    getUsers();
  }

  Future getUsers() async {
    final users = await UserSheetsApi.getById(1);

    setState(() {
      this.user = users;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Pengecatan Cat'),
        backgroundColor: Colors.transparent,
      ),
      backgroundColor: Colors.grey[300],
      body: SafeArea(
        child: SingleChildScrollView(
            child: WidgetFormM3(
          users: user,
        )),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:volume_pekerjaan/api/add.dart';
import 'package:volume_pekerjaan/api/add_sheets_api.dart';
import 'package:volume_pekerjaan/api/user.dart';
import 'package:volume_pekerjaan/api/user_sheets_api.dart';
import 'package:volume_pekerjaan/components/widgetForm_M1.dart';
import 'package:volume_pekerjaan/components/widgetForm_M2.dart';
import 'package:volume_pekerjaan/components/widgetForm_M3.dart';

class MyPekerjaanBatuGunung extends StatefulWidget {
  MyPekerjaanBatuGunung({Key? key}) : super(key: key);
  @override
  State<MyPekerjaanBatuGunung> createState() => _MyPekerjaanBatuGunungState();
}

class _MyPekerjaanBatuGunungState extends State<MyPekerjaanBatuGunung> {
  User? user;
  AddUser? adduser;
  String title = 'Pekerjaan Batu Gunung';

  @override
  void initState() {
    super.initState();

    getUsers();
  }

  //Dapatkan Data dari Colum Google Sheet
  Future getUsers() async {
    final users = await UserSheetsApi.getById(4);

    setState(() {
      this.user = users;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Pekerjaan Batu Gunung'),
        centerTitle: true,
        backgroundColor: Colors.transparent,
      ),
      backgroundColor: Colors.grey[300],
      body: SafeArea(
        child: SingleChildScrollView(
            child: WidgetFormM1(
          title: title,
          users: user,
          addUser: adduser,
          onSavedUser: (add) async {
            final id = await AddSheetsApi.getRowCount() + 1;
            final newUser = add.Copy(Id: id);
            await AddSheetsApi.insert([newUser.toJson()]);
          },
        )),
      ),
    );
  }
}

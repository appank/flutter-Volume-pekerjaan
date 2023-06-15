import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:volume_pekerjaan/api/add.dart';
import 'package:volume_pekerjaan/api/user.dart';
import 'package:volume_pekerjaan/sql/db_halper.dart';
import 'package:volume_pekerjaan/widget/Button.dart';
import 'package:volume_pekerjaan/widget/TextFile.dart';
import 'package:volume_pekerjaan/widget/TextSatuanHarga.dart';
import 'package:intl/intl.dart';
import 'package:volume_pekerjaan/widget/TextTitle.dart';

class WidgetFormM3 extends StatefulWidget {
  final User? users;
  final AddUser? addUser;
  final ValueChanged<AddUser> onSavedUser;
  String? title;
  WidgetFormM3(
      {Key? key,
      required this.users,
      required this.title,
      required this.addUser,
      required this.onSavedUser})
      : super(key: key);

  @override
  State<WidgetFormM3> createState() => _WidgetFormState();
}

class _WidgetFormState extends State<WidgetFormM3> {
  List<Map<String, dynamic>> _allData = [];
  bool _isLoading = true;
  String dbtile = "bacot";
  //Get Data From DataBase

  final fromkey = GlobalKey<FormState>();

  final panjang = TextEditingController();

  final lebar = TextEditingController();
  final tinggi = TextEditingController();

  late TextEditingController Satuan;
  late TextEditingController Title;
  var totalHarga = 0;

  @override
  void initState() {
    // super.initState();

    initUser();
    //Refresh Data
  }

  @override
  void didUpdateWidget(covariant WidgetFormM3 oldWidget) {
    super.didUpdateWidget(oldWidget);

    initUser();
  }

  void initUser() {
    //Dapatkan Data Dari Google Sheet
    final satuan = widget.users == null ? '' : widget.users!.satuan;
    var title = widget.title;

    //Tambahkan Data ke Google Sheet
    final dbTittle = widget.addUser == null ? '' : widget.addUser!.Title;
    final dbSatuan = widget.addUser == null ? '' : widget.addUser!.Satuan;
    final dbTotalHarga =
        widget.addUser == null ? '' : widget.addUser!.TotalHarga;

    setState(() {
      Satuan = TextEditingController(
          text: satuan == '' ? dbSatuan.toString() : satuan);

      Title = TextEditingController(
          text: title == '' ? dbTittle.toString() : title);
      totalHarga.toString();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: fromkey,
      child: Padding(
        padding: EdgeInsets.all(25.0),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(height: 30),
              MyTextTitle(
                controler: Title,
                hintTex: "Title",
              ),
              SizedBox(
                height: 20,
              ),
              MyTxtFile(
                controler: panjang,
                hintTex: "Panjang",
              ),
              SizedBox(
                height: 20,
              ),
              MyTxtFile(
                controler: lebar,
                hintTex: "Lebar",
              ),
              SizedBox(
                height: 20,
              ),
              MyTxtFile(
                controler: tinggi,
                hintTex: "Tinggi",
              ),
              SizedBox(
                height: 20,
              ),
              MyTextSatuanHarga(
                controler: Satuan,
              ),
              SizedBox(
                height: 30,
              ),
              SizedBox(
                width: double.infinity,
                height: 100,
                child: Stack(
                  children: [
                    Card(
                      clipBehavior: Clip.antiAliasWithSaveLayer,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10)),
                      elevation: 10,
                      child: Center(
                        child: Text(
                          NumberFormat.currency(locale: 'id', symbol: 'Rp. ')
                              .format(totalHarga),
                          style: TextStyle(
                              fontSize: 20, fontStyle: FontStyle.normal),
                        ),
                      ),
                    )
                  ],
                ),
              ),
              SizedBox(
                height: 30,
              ),
              MyButton(
                  text: "Nilai Pekerjaan",
                  onTap: () {
                    if (fromkey.currentState!.validate()) {
                      totalHarga = int.parse(panjang.text) *
                          int.parse(lebar.text) *
                          int.parse(tinggi.text) *
                          int.parse(Satuan.text);

                      setState(() {
                        totalHarga;
                      });
                    }
                    null;
                  }),
              SizedBox(
                height: 25,
              ),
              MyButton(
                  text: 'Save',
                  onTap: () {
                    final Id =
                        widget.addUser == null ? null : widget.addUser!.Id;
                    int _Satuan = int.parse(Satuan.text);
                    final ad = AddUser(
                        Id: Id,
                        Title: Title.text,
                        Satuan: _Satuan,
                        TotalHarga: totalHarga); //tostring()

                    widget.onSavedUser(ad);
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text('Data berhasil disimpan'),
                        duration: Duration(seconds: 2),
                      ),
                    );
                  }),
              SizedBox(
                height: 25,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:volume_pekerjaan/api/user.dart';
import 'package:volume_pekerjaan/sql/db_halper.dart';
import 'package:volume_pekerjaan/widget/Button.dart';
import 'package:volume_pekerjaan/widget/TextFile.dart';
import 'package:volume_pekerjaan/widget/TextSatuanHarga.dart';
import 'package:intl/intl.dart';
import 'package:volume_pekerjaan/widget/TextTitle.dart';

class WidgetFormM3 extends StatefulWidget {
  final User? users;
  String? title;
  WidgetFormM3({Key? key, required this.users, required this.title})
      : super(key: key);

  @override
  State<WidgetFormM3> createState() => _WidgetFormState();
}

class _WidgetFormState extends State<WidgetFormM3> {
  List<Map<String, dynamic>> _allData = [];
  bool _isLoading = true;
  String dbtile = "bacot";
  //Get Data From DataBase
  void _refreshData() async {
    final data = await SQLHaleper.getAllData();

    setState(() {
      _allData = data;
      _isLoading = false;
    });
  }

  final fromkey = GlobalKey<FormState>();

  final panjang = TextEditingController();

  final lebar = TextEditingController();
  final tinggi = TextEditingController();

  late TextEditingController Satuan;
  late TextEditingController Title;
  var totalHarga = 0;

  // final Jumlah = TextEditingController();
  // final TextLa = TextEditingController(text: 'Bacot');
  @override
  void initState() {
    // super.initState();

    initUser();
    //Refresh Data
    _refreshData();
  }

  //Add Data
  Future<void> _addData() async {
    await SQLHaleper.createData(Title.text, panjang.text, lebar.text,
        tinggi.text, Satuan.text, totalHarga);
    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text("Add Data"), backgroundColor: Colors.redAccent));
    _refreshData();
  }

  @override
  void didUpdateWidget(covariant WidgetFormM3 oldWidget) {
    super.didUpdateWidget(oldWidget);

    initUser();
  }

  //Fungsi Button Save
  void SaveData(int? id) async {
    if (id != null) {
      final existingData =
          _allData.firstWhere((element) => element['id'] == id);
      Title.text = existingData['db_title'];
      panjang.text = existingData['db_panjang'];
      lebar.text = existingData['db_lebar'];
      tinggi.text = existingData['db_tinggi'];
      Satuan.text = existingData['db_satuan'];
      totalHarga = existingData['db_jumlah'];
    }

    await _addData();
    Title.text = "";
    panjang.text = "";
    lebar.text = "";
    tinggi.text = "";
    Satuan.text = "";
    totalHarga = totalHarga;

    //Hidden button sheet
    Navigator.of(context).pop();
    print("Data Added");
  }

  void initUser() {
    final satuan = widget.users == null ? '' : widget.users!.satuan;
    var title = widget.title;

    setState(() {
      Satuan = TextEditingController(text: satuan);
      Title = TextEditingController(text: title);
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
              const SizedBox(height: 20),
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
                    SaveData(null);
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

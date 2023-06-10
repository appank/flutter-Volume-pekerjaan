import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:volume_pekerjaan/api/user.dart';
import 'package:volume_pekerjaan/widget/Button.dart';
import 'package:volume_pekerjaan/widget/TextFile.dart';
import 'package:volume_pekerjaan/widget/TextSatuanHarga.dart';
import 'package:intl/intl.dart';

class WidgetFormM2 extends StatefulWidget {
  final User? users;
  const WidgetFormM2({Key? key, required this.users}) : super(key: key);

  @override
  State<WidgetFormM2> createState() => _WidgetFormState();
}

class _WidgetFormState extends State<WidgetFormM2> {
  final fromkey = GlobalKey<FormState>();

  final panjang = TextEditingController();

  final lebar = TextEditingController();

  late TextEditingController Satuan;

  var totalHarga = 0;

  final Jumlah = TextEditingController();
  final TextLa = "";
  @override
  void initState() {
    // super.initState();

    initUser();
  }

  @override
  void didUpdateWidget(covariant WidgetFormM2 oldWidget) {
    super.didUpdateWidget(oldWidget);

    initUser();
  }

  void initUser() {
    final satuan = widget.users == null ? '' : widget.users!.satuan;

    setState(() {
      Satuan = TextEditingController(text: satuan);
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
              // Container(
              //   height: 140,
              //   decoration: BoxDecoration(
              //     color: Colors.white,
              //     boxShadow: [
              //       BoxShadow(
              //         color: Colors.black.withOpacity(0.5),
              //         offset: Offset(2, 2),
              //         blurRadius: 5,
              //       ),
              //     ],
              //   ),
              // ),

              const SizedBox(height: 50),
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
            ],
          ),
        ),
      ),
    );
  }
}

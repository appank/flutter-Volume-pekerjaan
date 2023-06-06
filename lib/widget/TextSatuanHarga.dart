import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';

class MyTextSatuanHarga extends StatelessWidget {
  final controler;

  const MyTextSatuanHarga({Key? key, required this.controler})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controler,
      inputFormatters: [FilteringTextInputFormatter.digitsOnly],
      decoration: InputDecoration(
        enabledBorder: const OutlineInputBorder(
          borderSide: BorderSide(color: Colors.white),
        ),
        focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.grey.shade400)),
        fillColor: Colors.grey.shade200,
        filled: true,
        enabled: false,
        prefixText: "Satuan : Rp ",
        // prefixIcon: Icon(Icons.monetization_on),
      ),
      validator: (value) {
        if (value!.isEmpty) {
          return 'Harus Terisi Bosss!!!';
        }
        null;
      },
    );
  }
}

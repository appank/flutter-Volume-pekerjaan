import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';

class MyTxtFile extends StatelessWidget {
  final controler;
  final String hintTex;
  const MyTxtFile({
    Key? key,
    required this.controler,
    required this.hintTex,
  }) : super(key: key);

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
        hintText: hintTex,
        hintStyle: TextStyle(color: Colors.grey[500]),
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

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';

class MyJumlah extends StatelessWidget {
  final controler;
  final String hintTex;
  const MyJumlah({
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
        fillColor: Color.fromRGBO(238, 238, 238, 1),
        filled: true,
        enabled: false,

        // prefixIcon: Icon(Icons.monetization_on),
        hintText: hintTex,
        hintStyle: TextStyle(color: Colors.black),
      ),
    );
  }
}

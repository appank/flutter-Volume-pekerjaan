import 'dart:math';

import 'package:flutter/material.dart';
import 'package:volume_pekerjaan/page/HomeSheet.dart';
import 'package:volume_pekerjaan/page/PekerjaanBatuGunung.dart';
import 'package:volume_pekerjaan/page/PekerjaanBatuKosong.dart';
import 'package:volume_pekerjaan/page/PekerjaanGalianTanah.dart';
import 'package:volume_pekerjaan/page/PekerjaanKolom.dart';
import 'package:volume_pekerjaan/page/PekerjaanPasirUruk.dart';
import 'package:volume_pekerjaan/page/PekerjaanSloef.dart';
import 'package:volume_pekerjaan/page/PekerjaanPengecatan.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Map<String, dynamic>> _allData = [
    {
      'Button': 'Pekerjaan Galian Tanah',
      'page': MyPekerjaanGalianTanah(),
    },
    {'Button': 'Pekerjaan Pasir Uruk', 'page': MyPekerjaanPasirUruk()},
    {'Button': 'Pekerjaan Batu Kosong', 'page': MyPekerjaanBatuKosong()},
    {'Button': 'Pekerjaan Batu Gunugn', 'page': MyPekerjaanBatuGunung()},
    {'Button': 'Pekerjaan Sloef', 'page': MyPekerjaanSloef()},
    {'Button': 'Pekerjaan Kolom', 'page': MyPekerjaanKolom()},
    {'Button': 'Pekerjaan Pengecatan', 'page': MyPekerjaanPengecatan()},
  ];

  List<Map<String, dynamic>> _searchResult = [];

  TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    _searchController.addListener(() {
      _onSearchTextChanged();
    });
    super.initState();
  }

  void _onSearchTextChanged() {
    _searchResult.clear();
    if (_searchController.text.isEmpty) {
      setState(() {});
      return;
    }
    _allData.forEach((map) {
      if (map.values.first
          .toLowerCase()
          .contains(_searchController.text.toLowerCase())) {
        _searchResult.add(map);
      }
    });
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: 50,
          ),
          Padding(
            padding: EdgeInsets.only(top: 30, left: 25.0),
            child: Text(
              'Menghitung Volume',
              style: TextStyle(
                fontSize: 30,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: 20.0, vertical: 5.0),
            child: TextFormField(
              controller: _searchController,
              decoration: InputDecoration(
                enabledBorder: const OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.white),
                ),
                focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.grey.shade400)),
                fillColor: Colors.grey.shade200,
                filled: true,
                hintStyle: TextStyle(color: Colors.grey[500]),
                hintText: 'Cari Volume di sini...', //Search...
              ),
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: ListView.builder(
                itemCount: _searchResult.length != 0 ||
                        _searchController.text.isNotEmpty
                    ? _searchResult.length
                    : _allData.length,
                itemBuilder: (context, index) => Container(
                  height: 50,
                  margin: EdgeInsets.all(8.0),
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      primary: Colors.black, // warna latar belakang button
                      onPrimary: Colors.grey[300], // warna teks pada button
                    ),
                    onPressed: () {
                      if (index >= 0 && index < _searchResult.length) {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (_) =>
                                  _allData != null && _allData.length != 0 ||
                                          _searchController.text.isNotEmpty
                                      ? _searchResult[index]['page']
                                      : _allData[index]['page']),
                        );
                      } else if (index >= 0 && index < _allData.length) {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (_) => _allData[index]['page']),
                        );
                      } else {
                        print("Indeks diluar jangkauan yang valid");
                      }
                    },
                    child: Text(
                      _searchResult.length != 0 ||
                              _searchController.text.isNotEmpty
                          ? _searchResult[index]['Button']
                          : _allData[index]['Button'],
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

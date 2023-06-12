import 'package:excel/excel.dart' as prefix;
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:intl/intl.dart';
import 'package:volume_pekerjaan/sql/db_halper.dart';
import 'dart:io';
import 'package:excel/excel.dart' as prefix;
import 'package:path_provider/path_provider.dart';

class MyHomeList extends StatefulWidget {
  const MyHomeList({Key? key}) : super(key: key);

  @override
  State<MyHomeList> createState() => _MyHomeListState();
}

class _MyHomeListState extends State<MyHomeList> {
  List<Map<String, dynamic>> _allData = [];

  bool _isLoading = true;

  void _refreshData() async {
    final data = await SQLHaleper.getAllData();

    setState(() {
      _allData = data;
      _isLoading = false;
    });
  }

  void exportToExcel(int index) async {
    // Mendapatkan path direktori aplikasi
    Directory directory = await getApplicationDocumentsDirectory();
    String path = directory.path;

    // Membuat objek Excel
    var excel = prefix.Excel.createExcel();

    // Membuat sheet baru pada file Excel
    var sheet = excel['Sheet1'];

    // Menambahkan header pada sheet
    sheet.appendRow(
        ['Title', 'Panjang', 'Lebar', 'Tinggi', 'Harga Satuan', 'Total Harga']);

    // Menambahkan data dari item yang dipilih ke sheet
    var item = _allData[index];
    sheet.appendRow([
      item['db_title'],
      item['db_panjang'],
      item['db_lebar'],
      item['db_tinggi'],
      item['db_satuan'],
      NumberFormat.currency(locale: 'id', symbol: 'Rp. ', decimalDigits: 0)
          .format(item['db_jumlah']),
    ]);

    // Menyimpan file Excel
    var fileBytes = excel.save();
    File('$path/data.xlsx').writeAsBytes(fileBytes!);

    // Menampilkan pesan berhasil
    print('Data exported to Excel successfully!');
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _refreshData();
  }

  //Delete Data
  void _deleteData(int id) async {
    await SQLHaleper.deletData(id);
    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text("Data Deleted"), backgroundColor: Colors.redAccent));
    _refreshData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      body: _isLoading
          ? Center(
              child: CircularProgressIndicator(),
            )
          : Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: EdgeInsets.only(top: 20),
                  child: Text(
                    'Daftar Data',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Expanded(
                  child: ListView.builder(
                    itemCount: _allData.length,
                    itemBuilder: (context, index) => Card(
                      clipBehavior: Clip.antiAliasWithSaveLayer,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10)),
                      elevation: 10,
                      margin: EdgeInsets.all(10),
                      child: ListTile(
                        title: Padding(
                          padding: EdgeInsets.symmetric(vertical: 5),
                          child: Text(
                            _allData[index]['db_title'],
                            style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                        subtitle: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Text('Panjang : '),
                                Text(
                                  _allData[index]['db_panjang'],
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                Text('Lebar : '),
                                Text(
                                  _allData[index]['db_lebar'],
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                Text('Tinggi : '),
                                Text(
                                  _allData[index]['db_tinggi'],
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                Text('Harga Satuan : '),
                                Text(_allData[index]['db_satuan']),
                              ],
                            ),
                            Row(
                              children: [
                                Text('Total Harga : '),
                                Text(NumberFormat.currency(
                                        locale: 'id',
                                        symbol: 'Rp. ',
                                        decimalDigits: 0)
                                    .format(_allData[index]['db_jumlah'])),

                                //  _allData[index]['db_jumlah'])
                              ],
                            ),
                          ],
                        ),
                        trailing: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            IconButton(
                                onPressed: () {
                                  _deleteData(_allData[index]['id']);
                                },
                                icon: Icon(
                                  Icons.delete,
                                  color: Colors.redAccent,
                                )),
                            IconButton(
                              onPressed: () {
                                exportToExcel(index);
                              },
                              icon: Icon(
                                Icons.file_download,
                                color: Colors.green,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                )
              ],
            ),
    );
  }
}

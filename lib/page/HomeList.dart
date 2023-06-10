import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:intl/intl.dart';
import 'package:volume_pekerjaan/sql/db_halper.dart';

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
          : ListView.builder(
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
                          ))
                    ],
                  ),
                ),
              ),
            ),
    );
  }
}

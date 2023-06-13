import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:intl/intl.dart';
import 'package:volume_pekerjaan/api/add.dart';
import 'package:volume_pekerjaan/api/add_sheets_api.dart';

class MyHomeSheet extends StatefulWidget {
  const MyHomeSheet({Key? key}) : super(key: key);

  @override
  State<MyHomeSheet> createState() => _MyHomeSheetState();
}

class _MyHomeSheetState extends State<MyHomeSheet> {
  List<AddUser> _allData = [];
  bool _isLoading = true;

  void _refreshData() async {
    await AddSheetsApi.init();
    List<AddUser> data = await AddSheetsApi.getAll();

    setState(() {
      _allData = data;
      _isLoading = false;
    });
  }

  void _deleteData() async {
    final user = _allData.length;
    await AddSheetsApi.deleteById(user);
    _refreshData();
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
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
          : SafeArea(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: EdgeInsets.only(top: 30, left: 25.0),
                    child: Text(
                      'Daftar Data',
                      style: TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 25,
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10.0),
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
                                '${_allData[index].Title}',
                                style: TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                            subtitle: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: EdgeInsets.symmetric(vertical: 5),
                                  child: Text(
                                    'Nilai Satuan : ${_allData[index].Satuan}',
                                  ),
                                ),
                                Text(
                                  'Total Harga : ${_allData[index].TotalHarga}',
                                ),
                              ],
                            ),
                            trailing: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                IconButton(
                                    onPressed: () {
                                      _deleteData();
                                    },
                                    icon: Icon(
                                      Icons.delete,
                                      color: Colors.redAccent,
                                    )),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
    );
  }
}

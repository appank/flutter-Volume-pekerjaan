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

  List<int> selectedIds = [];
  void _refreshData() async {
    await AddSheetsApi.init();
    List<AddUser> data = await AddSheetsApi.getAll();

    if (mounted) {
      setState(() {
        _allData = data;
        _isLoading = false;
      });
    }
  }

  double _calculateTotal(List<AddUser> data) {
    double sum = 0;
    selectedIds.forEach((id) {
      sum += data.firstWhere((item) => item.Id == id).TotalHarga;
    });
    return sum;
  }

  void _toggleCheckbox(bool? value, int id) {
    setState(() {
      if (value!) {
        selectedIds.add(id);
      } else {
        selectedIds.remove(id);
      }
    });
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
                      padding: const EdgeInsets.all(8.0),
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
                                Text('Nilai Satuan : ${NumberFormat.currency(
                                  locale: 'id',
                                  symbol: 'Rp. ',
                                  decimalDigits: 0,
                                ).format(_allData[index].Satuan)}'),
                                Text('Harga : ${NumberFormat.currency(
                                  locale: 'id',
                                  symbol: 'Rp. ',
                                  decimalDigits: 0,
                                ).format(_allData[index].TotalHarga)}'),
                              ],
                            ),
                            trailing: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Checkbox(
                                  onChanged: (bool? value) => _toggleCheckbox(
                                      value, _allData[index].Id!),
                                  value:
                                      selectedIds.contains(_allData[index].Id),
                                  checkColor: Colors.white,
                                  activeColor: Colors.green,
                                ),
                                IconButton(
                                    onPressed: () async {
                                      int? idToDelete = _allData[index].Id;

                                      try {
                                        await AddSheetsApi.deleteById(
                                            idToDelete!);
                                      } catch (e) {
                                        print('Error deleting data: $e');
                                      }
                                      _refreshData();
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
                  Container(
                    width: double.infinity,
                    height: 60, // Fixed height for container
                    color: Colors.grey, // Change this to desired color
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 25.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          SizedBox(
                            height: 10,
                          ),
                          FutureBuilder<void>(
                            builder: (context, snapshot) {
                              double sum = 0.0;
                              if (_allData.isNotEmpty) {
                                _allData.forEach((data) {
                                  sum += data.TotalHarga;
                                });
                                _refreshData();
                              }
                              return Text(
                                'Total Harga : ${NumberFormat.currency(
                                  locale: 'id',
                                  symbol: 'Rp. ',
                                  decimalDigits: 0,
                                ).format(_calculateTotal(_allData))}',
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.w600,
                                ),
                              );
                            },
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
    );
  }
}

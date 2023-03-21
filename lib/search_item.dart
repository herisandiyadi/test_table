import 'package:flutter/material.dart';
import 'package:test_table/databases_service.dart';
import 'package:test_table/edit_page.dart';

import 'model/table_model.dart';

class SearchItemPage extends StatefulWidget {
  const SearchItemPage({super.key});

  @override
  State<SearchItemPage> createState() => _SearchItemPageState();
}

enum Category { id, name, barcode }

class _SearchItemPageState extends State<SearchItemPage> {
  DatabaseService databaseService = DatabaseService();
  TextEditingController searchController = TextEditingController();
  List listData = [];

  Category? _category = Category.id;
  Future idSearch() async {
    try {
      var idList =
          await databaseService.selectById(int.parse(searchController.text));

      if (idList.isNotEmpty) {
        listData.clear();

        final data = idList.map((data) => TableModel.fromJson(data));
        listData.addAll(data);
      }
    } catch (e) {
      Exception(e);
    }
  }

  Future nameSearch() async {
    try {
      var nameList = await databaseService.selectByName(searchController.text);

      if (nameList.isNotEmpty) {
        listData.clear();

        final data = nameList.map((data) => TableModel.fromJson(data));
        listData.addAll(data);
      }
    } catch (e) {
      Exception(e);
    }
  }

  Future barcodeSearch() async {
    try {
      var bcodeList =
          await databaseService.selectByBarcode(searchController.text);

      if (bcodeList.isNotEmpty) {
        listData.clear();

        final data = bcodeList.map((data) => TableModel.fromJson(data));
        listData.addAll(data);
      }
    } catch (e) {
      Exception(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Search Item'),
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          children: [
            const SizedBox(
              height: 30,
            ),
            const Text(
              'Data Table',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
            ),
            const SizedBox(
              height: 30,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 30),
              child: Row(
                children: [
                  const SizedBox(width: 50, child: Text('Search')),
                  SizedBox(
                    width: 180,
                    child: TextFormField(
                      controller: searchController,
                      keyboardType: TextInputType.text,
                      decoration: InputDecoration(
                        fillColor: Colors.white,
                        filled: true,
                        hintText: 'Search',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5),
                        ),
                        contentPadding: const EdgeInsets.all(12),
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 16,
                  ),
                  ElevatedButton(
                      onPressed: () {
                        if (_category == Category.id) {
                          idSearch();
                          setState(() {});
                        } else if (_category == Category.name) {
                          nameSearch();
                          setState(() {});
                        } else if (_category == Category.barcode) {
                          barcodeSearch();
                          setState(() {});
                        }
                        setState(() {});
                      },
                      child: const Text('Find'))
                ],
              ),
            ),
            Row(
              children: [
                Row(
                  children: [
                    Radio<Category>(
                      value: Category.id,
                      groupValue: _category,
                      onChanged: (Category? value) {
                        setState(() {
                          _category = value;
                        });
                      },
                    ),
                    const Text(
                      'Search By id',
                      style: TextStyle(fontSize: 10),
                    )
                  ],
                ),
                Row(
                  children: [
                    Radio<Category>(
                      value: Category.name,
                      groupValue: _category,
                      onChanged: (Category? value) {
                        setState(() {
                          _category = value;
                        });
                      },
                    ),
                    const Text(
                      'Search By name',
                      style: TextStyle(fontSize: 10),
                    )
                  ],
                ),
                Row(
                  children: [
                    Radio<Category>(
                      value: Category.barcode,
                      groupValue: _category,
                      onChanged: (Category? value) {
                        setState(() {
                          _category = value;
                        });
                      },
                    ),
                    const Text(
                      'Search By barcode',
                      style: TextStyle(fontSize: 10),
                    )
                  ],
                ),
              ],
            ),
            const SizedBox(
              height: 40,
            ),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      children: [
                        Table(
                            columnWidths: const {
                              0: FixedColumnWidth(40),
                              1: FixedColumnWidth(80),
                              2: FixedColumnWidth(80),
                              3: FixedColumnWidth(80),
                              4: FixedColumnWidth(150),
                            },
                            border: TableBorder.all(
                                width: 0.8, color: Colors.black),
                            children: const [
                              TableRow(
                                  decoration: BoxDecoration(color: Colors.grey),
                                  children: [
                                    Padding(
                                      padding: EdgeInsets.all(3.0),
                                      child: Text('NO'),
                                    ),
                                    Padding(
                                      padding: EdgeInsets.all(3.0),
                                      child: Text('Item Id'),
                                    ),
                                    Padding(
                                      padding: EdgeInsets.all(3.0),
                                      child: Text('Item Name'),
                                    ),
                                    Padding(
                                      padding: EdgeInsets.all(3.0),
                                      child: Text('Barcode'),
                                    ),
                                    Padding(
                                      padding: EdgeInsets.all(3.0),
                                      child: Text('Action'),
                                    ),
                                  ]),
                            ]),
                        Table(
                            columnWidths: const {
                              0: FixedColumnWidth(40),
                              1: FixedColumnWidth(80),
                              2: FixedColumnWidth(80),
                              3: FixedColumnWidth(80),
                              4: FixedColumnWidth(150),
                            },
                            border: TableBorder.all(
                                width: 1.0, color: Colors.black),
                            textDirection: TextDirection.ltr,
                            // children: dataTable.map((data) => data).toList())
                            children: List.generate(
                                listData.length,
                                (index) => TableRow(children: [
                                      Padding(
                                        padding: const EdgeInsets.only(left: 8),
                                        child: Text('${index + 1}',
                                            textScaleFactor: 1),
                                      ),
                                      Text(listData[index].itemid.toString(),
                                          textScaleFactor: 1),
                                      Text(listData[index].itemname,
                                          textScaleFactor: 1),
                                      Text(listData[index].barcode,
                                          textScaleFactor: 1),
                                      Padding(
                                        padding: const EdgeInsets.all(3.0),
                                        child: Row(
                                          children: [
                                            ElevatedButton(
                                                style: ButtonStyle(
                                                    backgroundColor:
                                                        MaterialStateProperty
                                                            .all(Colors.blue)),
                                                onPressed: () {
                                                  Navigator.of(context).push(
                                                    MaterialPageRoute(
                                                      builder: (context) =>
                                                          EditPage(
                                                        tableModel:
                                                            listData[index],
                                                      ),
                                                    ),
                                                  );
                                                },
                                                child: const Text('Edit')),
                                            const SizedBox(
                                              width: 8,
                                            ),
                                            ElevatedButton(
                                                onPressed: () {
                                                  databaseService.delete(
                                                      listData[index].itemid);
                                                  setState(() {});
                                                },
                                                child: const Text('Delete'))
                                          ],
                                        ),
                                      )
                                    ]))),
                      ],
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

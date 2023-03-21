import 'package:flutter/material.dart';
import 'package:test_table/databases_service.dart';
import 'package:test_table/edit_page.dart';
import 'package:test_table/item_page.dart';
import 'package:test_table/model/table_model.dart';
import 'package:test_table/search_item.dart';

class Homepage extends StatefulWidget {
  const Homepage({super.key});

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  List<Map> dataList = [];
  DatabaseService databaseService = DatabaseService();
  late TableModel data;

  void getData() async {
    await databaseService.readAllData();
  }

  @override
  void initState() {
    super.initState();
    getData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SizedBox(
              height: 100,
            ),
            GestureDetector(
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => ItemPage()));
              },
              child: Container(
                width: 100,
                height: 45,
                decoration: const BoxDecoration(color: Colors.blue),
                child: const Center(
                    child: Text(
                  'Item',
                  style: TextStyle(color: Colors.white),
                )),
              ),
            ),
            const SizedBox(
              height: 30,
            ),
            GestureDetector(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const SearchItemPage()));
              },
              child: Container(
                width: 100,
                height: 45,
                decoration: const BoxDecoration(color: Colors.blue),
                child: const Center(
                    child: Text(
                  'Search Item',
                  style: TextStyle(color: Colors.white),
                )),
              ),
            ),
            const SizedBox(
              height: 30,
            ),
            const Text(
              'Data Table',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
            ),
            const SizedBox(
              height: 14,
            ),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: SizedBox(
                height: 500,
                width: 450,
                child: FutureBuilder<List<TableModel>>(
                    future: databaseService.readAllData(),
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        List<TableRow> listData = [];
                        final data = snapshot.data!;
                        for (var i = 0; i < snapshot.data!.length; i++) {
                          listData.add(TableRow(children: [
                            Padding(
                              padding: const EdgeInsets.only(left: 8),
                              child: Text('${i + 1}', textScaleFactor: 1),
                            ),
                            Text(data[i].itemid.toString(), textScaleFactor: 1),
                            Text(data[i].itemname, textScaleFactor: 1),
                            Text(data[i].barcode, textScaleFactor: 1),
                            Padding(
                              padding: const EdgeInsets.all(3.0),
                              child: Row(
                                children: [
                                  ElevatedButton(
                                      style: ButtonStyle(
                                          backgroundColor:
                                              MaterialStateProperty.all(
                                                  Colors.blue)),
                                      onPressed: () {
                                        Navigator.of(context)
                                            .push(MaterialPageRoute(
                                                builder: (context) => EditPage(
                                                      tableModel: data[i],
                                                    )));
                                      },
                                      child: const Text('Edit')),
                                  const SizedBox(
                                    width: 8,
                                  ),
                                  ElevatedButton(
                                      onPressed: () {
                                        databaseService.delete(data[i].itemid);
                                        setState(() {});
                                      },
                                      child: const Text('Delete'))
                                ],
                              ),
                            )
                          ]));
                        }

                        return Padding(
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
                                        decoration:
                                            BoxDecoration(color: Colors.grey),
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
                                  children:
                                      listData.map((data) => data).toList()),
                            ],
                          ),
                        );
                      }
                      return const SizedBox();
                    }),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

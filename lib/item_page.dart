import 'package:flutter/material.dart';
import 'package:test_table/databases_service.dart';
import 'package:test_table/homepage.dart';
import 'package:test_table/model/table_model.dart';

class ItemPage extends StatelessWidget {
  final TextEditingController idControler = TextEditingController();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController barcodeController = TextEditingController();
  final DatabaseService databaseService = DatabaseService();
  ItemPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text('Add Item'),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 14),
          child: Container(
            width: MediaQuery.of(context).size.width,
            height: 350,
            decoration: const BoxDecoration(color: Colors.lightBlueAccent),
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      const SizedBox(width: 90, child: Text('ItemId')),
                      SizedBox(
                        width: 200,
                        child: TextFormField(
                          controller: idControler,
                          keyboardType: TextInputType.number,
                          decoration: InputDecoration(
                            fillColor: Colors.white,
                            filled: true,
                            hintText: 'Item Id',
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(5),
                            ),
                            contentPadding: const EdgeInsets.all(12),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 14,
                  ),
                  Row(
                    children: [
                      const SizedBox(width: 90, child: Text('ItemName')),
                      SizedBox(
                        width: 200,
                        child: TextFormField(
                          controller: nameController,
                          keyboardType: TextInputType.text,
                          decoration: InputDecoration(
                            fillColor: Colors.white,
                            filled: true,
                            hintText: 'Item Name',
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(5),
                            ),
                            contentPadding: const EdgeInsets.all(12),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 14,
                  ),
                  Row(
                    children: [
                      const SizedBox(width: 90, child: Text('Barcode')),
                      SizedBox(
                        width: 200,
                        child: TextFormField(
                          controller: barcodeController,
                          keyboardType: TextInputType.text,
                          decoration: InputDecoration(
                            fillColor: Colors.white,
                            filled: true,
                            hintText: 'Barcode',
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(5),
                            ),
                            contentPadding: const EdgeInsets.all(12),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 50,
                  ),
                  Center(
                    child: ElevatedButton(
                        onPressed: () async {
                          databaseService.insert(TableModel(
                              itemid: int.parse(idControler.text),
                              itemname: nameController.text,
                              barcode: barcodeController.text));

                          await Navigator.pushAndRemoveUntil(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const Homepage()),
                              (route) => false);
                        },
                        child: const Text('Save')),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

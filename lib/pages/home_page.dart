import 'package:flutter/material.dart';

import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:my_barcode_scanner/pages/qr_generator.dart';
import 'package:my_barcode_scanner/resources/database_helper.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String scanResult = '';

  DatabaseHelper db = DatabaseHelper();
  //  List<ItemModel> _items;
  int count = 0;

  Future<List<Map>> _getItems() async {
    // var items = await db.getAllItems();

    // for (var i = 0; i < items.length; i++) {
    //   _items.add(ItemModel.map(items[i]));
    // }

    // return _items;

    return db.queryAllRows();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("QR Scanner"),
        centerTitle: true,
      ),
      body: Container(
        child: FutureBuilder(
          future: _getItems(),
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            if (snapshot.data == null) {
              return Container(
                child: Center(
                  child: Text('Loading ...'),
                ),
              );
            } else {
              return ListView.builder(
                itemCount: snapshot.data.length,
                itemBuilder: (BuildContext context, int i) {
                  return Padding(
                    padding: EdgeInsets.all(5.0),
                    child: Card(
                      child: Row(
                        children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: snapshot.data[i]['itemPicturePath'] == null
                                ? Image.asset(
                                    'assets/img/no-image.jpg',
                                    height: 120.0,
                                    width: 120.0,
                                    fit: BoxFit.cover,
                                  )
                                : Image.asset(
                                    snapshot.data[i]['itemPicturePath'],
                                    height: 120.0,
                                    width: 120.0,
                                    fit: BoxFit.cover,
                                  ),
                          ),
                          Expanded(
                            child: Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 8.0),
                              child: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Text(
                                    snapshot.data[i]['itemName'],
                                    style: TextStyle(
                                        fontSize: 25,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  SizedBox(height: 20),
                                  Text(
                                    'Qty = ${snapshot.data[i]['itemQty']}',
                                    style: TextStyle(
                                      color: Colors.grey,
                                      fontSize: 17,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Container(
                              alignment: Alignment.topRight,
                              height: 130,
                              child: IconButton(
                                onPressed: () {},
                                icon: Icon(Icons.more_vert),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              );
            }
          },
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        label: Text('Scan'),
        onPressed: _qrScanner,
        icon: Icon(Icons.camera_alt),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }

  Future _qrScanner() async {
    String res;
    res = await FlutterBarcodeScanner.scanBarcode('#4caf50', 'لغو', true);

    setState(() {
      scanResult = res;
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => QrGenerator(res),
        ),
      );
    });
  }
}

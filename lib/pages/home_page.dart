import 'package:flutter/material.dart';

import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:my_barcode_scanner/models/items_card.dart';
import 'package:my_barcode_scanner/pages/qr_generator.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String scanResult = '';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("QR Scanner"),
        centerTitle: true,
      ),
      body: ListView(
        children: <Widget>[
          ItemsCard(
            itemID: '123',
            itemPicturePath: 'assets/img/bg2.jpg',
            itemName: 'Item 1',
            itemNotes: 'jdcnsladcnadkcm',
            itemPrice: 125.0,
            itemQty: 5,
            itemTag: null,
            itemTotalPrice: 625.0,
          ),
          ItemsCard(
            itemID: '123',
            itemPicturePath: 'assets/img/2.jpg',
            itemName: 'Item 2',
            itemNotes: 'jdcnsladcnadkcm',
            itemPrice: 125.0,
            itemQty: 5,
            itemTag: null,
            itemTotalPrice: 625.0,
          ),
          ItemsCard(
            itemID: '123',
            itemPicturePath: 'assets/img/1.jpg',
            itemName: 'Item 3',
            itemNotes: 'jdcnsladcnadkcm',
            itemPrice: 125.0,
            itemQty: 5,
            itemTag: null,
            itemTotalPrice: 625.0,
          ),
          ItemsCard(
            itemID: '123',
            itemPicturePath: 'assets/img/bg.jpg',
            itemName: 'Item 4',
            itemNotes: 'jdcnsladcnadkcm',
            itemPrice: 125.0,
            itemQty: 5,
            itemTag: null,
            itemTotalPrice: 625.0,
          ),
        ],
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

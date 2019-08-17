import 'package:flutter/material.dart';
import 'package:my_barcode_scanner/models/item_model.dart';
import 'package:my_barcode_scanner/resources/database_helper.dart';
import 'package:my_barcode_scanner/service_locator.dart';

import 'pages/home_page.dart';


void main() async {
  
  
  setupLocator();
  runApp(MyApp());
  
    // #region Sqflite Example


  // var db = DatabaseHelper();

  // List _items = await db.queryAllRows();
  // for (var i = 0; i < _items.length; i++) {
  //   ItemModel item = ItemModel.map(_items[i]);
  //   print('Saved Items ${item.itemName} , ${item.itemID},${item.itemPicturePath}');
  // }
  // int saved = await db.addItem(
  //   ItemModel(
  //   // itemID: "1",
  //     itemName: "amin",
  //     itemNotes: "sknvjo",
  //     itemPicturePath: "assets/img/bg2.jpg",
  //     itemPrice: 55,
  //     itemQty: 2,
  //     itemTag: "cdc",
  //     itemTotalPrice: 125.5));

  //     print('Add $saved .........................');

  // #endregion
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Barcode Scanner',
      theme: ThemeData(
        primaryColor: Colors.red,
        accentColor: Colors.redAccent,
      ),
      home: HomePage(),
    );
  }
}

import 'package:bottom_navy_bar/bottom_navy_bar.dart';
import 'package:flutter/material.dart';
import 'package:my_barcode_scanner/models/item_model.dart';
import 'package:my_barcode_scanner/models/placeholder.dart';
import 'package:my_barcode_scanner/pages/item_details.dart';
import 'package:my_barcode_scanner/pages/more_page.dart';
import 'package:my_barcode_scanner/pages/search_page.dart';
import 'package:my_barcode_scanner/pages/settings_page.dart';
import 'package:my_barcode_scanner/pages/tag_page.dart';
import 'package:my_barcode_scanner/resources/database_helper.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'pages/home_page.dart';

void main() async {
  runApp(MyApp());

  // #region Sqflite Example

  // var db = DatabaseHelper();
  // List _items = await db.getAllItems();
  // for (var i = 0; i < _items.length; i++) {
  //   ItemModel item = ItemModel.map(_items[i]);
  //   print(
  //       'Saved Items ${item.itemName} ,${item.itemQty}, ${item.itemID}, ${item.itemNotes}, ${item.itemTag},${item.itemPicturePath}');
  // }
  // int saved = await db.addItem(
  //   ItemModel(
  //   // itemID: "1",
  //     itemName: "Mobile",
  //     itemNotes: "The best of best",
  //     itemPicturePath: "assets/img/3.jpg",
  //     itemPrice: 55,
  //     itemQty: 6,
  //     itemTag: "qweasdfzc",
  //     itemTotalPrice: 1615.5));

  //     print('Add $saved .........................');

  // await db.updateItem(
  //   ItemModel(
  //    itemID: 1,
  //     itemName: "Mobile",
  //     itemNotes: "The best of best",
  //     itemPicturePath: "assets/img/3.jpg",
  //     itemPrice: 55,
  //     itemQty: 6,
  //     itemTag: "qweasdfzc",
  //     itemTotalPrice: 1615.5)
  // );

  // #endregion
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  int _selectedIndex = 0;

  final pages = [
    HomePage(),
    SearchPage(),
    TagPage(),
    SettingsPage(),
  ];

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Barcode Scanner',
      theme: ThemeData(
        primaryColor: Colors.red,
        accentColor: Colors.redAccent,
      ),
      home: Scaffold(
        body: pages[_selectedIndex],
        bottomNavigationBar: BottomNavyBar(
          iconSize: 40,
          selectedIndex: _selectedIndex,
          showElevation: true,
          onItemSelected: (index) => setState(() {
            _selectedIndex = index;
          }),
          items: [
            BottomNavyBarItem(
              icon: Icon(Icons.menu),
              title: Text('Items'),
              activeColor: Colors.blueAccent,
            ),
            BottomNavyBarItem(
              icon: Icon(Icons.search),
              title: Text('Search'),
              activeColor: Colors.redAccent,
            ),
            BottomNavyBarItem(
              icon: Icon(Icons.label_important),
              title: Text('Tags'),
              activeColor: Colors.orangeAccent,
            ),
            BottomNavyBarItem(
                icon: Icon(Icons.more_horiz),
                title: Text('More'),
                activeColor: Colors.blueGrey),
          ],
        ),
      ),
    );
  }
}

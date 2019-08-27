import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:my_barcode_scanner/components/item_card.dart';
import 'package:my_barcode_scanner/components/modal_icon_button.dart';

import 'package:sqflite/sqlite_api.dart';
import 'package:bottom_navy_bar/bottom_navy_bar.dart';

import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:my_barcode_scanner/models/item_model.dart';
import 'package:my_barcode_scanner/pages/item_details.dart';
import 'package:my_barcode_scanner/pages/qr_generator.dart';
import 'package:my_barcode_scanner/resources/database_helper.dart';

class HomePage extends StatefulWidget {
  // final searchValue;

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String scanResult = '';
  String _query;

  DatabaseHelper dbHelper = DatabaseHelper();

  int count = 0;

  List<ItemModel> _itemsList;
  List<ItemModel> _filterList;

  bool _firstSearch = true;

  TextEditingController _searchController = TextEditingController();

 
  _HomePageState() {
    _searchController.addListener(() {
      if (_searchController.text.isEmpty) {
        setState(() {
          _firstSearch = true;
          _query = '';
        });
      } else {
        setState(() {
          _firstSearch = false;
          _query = _searchController.text;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    if (_itemsList == null) {
      _itemsList = List<ItemModel>();
      updateListView();
    }

    return Scaffold(
      resizeToAvoidBottomPadding: false,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: searchCard(),
        centerTitle: true,
      ),
      body:_firstSearch? ItemCard(itemList: _itemsList ,):_performSearch(),

      // #region ListView with Futurebuilder

      // child: FutureBuilder(
      //   future: _getItems(),
      //   builder: (BuildContext context, AsyncSnapshot snapshot) {
      //     if (snapshot.data == null) {
      //       return Container(
      //         child: Center(
      //           child: CircularProgressIndicator(),
      //         ),
      //       );
      //     } else {
      //       return ListView.builder(
      //         itemCount: snapshot.data.length,
      //         itemBuilder: (BuildContext context, int i) {
      //           return Padding(
      //             padding: EdgeInsets.all(5.0),
      //             child: InkWell(
      //               onTap: () => Navigator.push(
      //                 context,
      //                 MaterialPageRoute(
      //                   builder: (context) =>
      //                       ItemInfo(itemModel: snapshot.data[i]),
      //                 ),
      //               ),
      //               child: Card(
      //                 child: Row(
      //                   children: <Widget>[
      //                     Padding(
      //                       padding: const EdgeInsets.all(8.0),
      //                       child: snapshot.data[i]['itemPicturePath'] == null
      //                           ? Image.asset(
      //                               'assets/img/no-image.jpg',
      //                               height: 120.0,
      //                               width: 120.0,
      //                               fit: BoxFit.cover,
      //                             )
      //                           : Image.asset(
      //                               snapshot.data[i]['itemPicturePath'],
      //                               height: 120.0,
      //                               width: 120.0,
      //                               fit: BoxFit.cover,
      //                             ),
      //                     ),
      //                     Expanded(
      //                       child: Padding(
      //                         padding:
      //                             const EdgeInsets.symmetric(horizontal: 8.0),
      //                         child: Column(
      //                           mainAxisAlignment:
      //                               MainAxisAlignment.spaceAround,
      //                           crossAxisAlignment: CrossAxisAlignment.start,
      //                           children: <Widget>[
      //                             Text(
      //                               snapshot.data[i]['itemName'],
      //                               style: TextStyle(
      //                                   fontSize: 25,
      //                                   fontWeight: FontWeight.bold),
      //                             ),
      //                             SizedBox(height: 20),
      //                             Text(
      //                               'Qty = ${snapshot.data[i]['itemQty']}',
      //                               style: TextStyle(
      //                                 color: Colors.grey,
      //                                 fontSize: 17,
      //                                 fontWeight: FontWeight.bold,
      //                               ),
      //                             ),
      //                           ],
      //                         ),
      //                       ),
      //                     ),
      //                     Padding(
      //                       padding: const EdgeInsets.all(8.0),
      //                       child: Container(
      //                         alignment: Alignment.topRight,
      //                         height: 130,
      //                         child: IconButton(
      //                           onPressed: () {
      //                             print('xcxx cx');
      //                           },
      //                           icon: Icon(Icons.more_vert),
      //                         ),
      //                       ),
      //                     ),
      //                   ],
      //                 ),
      //               ),
      //             ),
      //           );
      //         },
      //       );
      //     }
      //   },
      // ),
      // #endregion

      floatingActionButton: FloatingActionButton.extended(
        label: Text('Scan'),
        //  onPressed: _qrScanner,
        onPressed: () => navigateToInfoPage(
            ItemModel(
                itemName: '',
                itemNotes: '',
                itemPicturePath: '',
                itemPrice: null,
                itemQty: null,
                itemTag: '',
                itemTotalPrice: 0),
            'ADD'),
        icon: Icon(Icons.camera_alt),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }

  Widget _performSearch() {
    _filterList = List<ItemModel>();
    for (var i = 0; i < _itemsList.length; i++) {
      var item = _itemsList[i];
      if (item.itemName.toLowerCase().contains(_query.toLowerCase())||
      item.itemNotes.toLowerCase().contains(_query.toLowerCase())) {
        _filterList.add(item);
      }
    }
    return ItemCard(itemList: _filterList ,);
  }

  Widget searchCard() => Padding(
        padding: const EdgeInsets.all(1.0),
        child: Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20.0),
          ),
          elevation: 2.0,
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 1, horizontal: 8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                IconButton(
                  color: Colors.black,
                  icon: Icon(Icons.search),
                  iconSize: 25,
                  onPressed: () {},
                ),
                SizedBox(
                  width: 5.0,
                ),
                Expanded(
                  child: TextField(
                    controller: _searchController,
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: "Search your Items...",
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      );

  Future _qrScanner() async {
    String res;
    res = await FlutterBarcodeScanner.scanBarcode('#4caf50', null, true);

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

  void navigateToInfoPage(ItemModel itemModel, String title) async {
    bool result =
        await Navigator.push(context, MaterialPageRoute(builder: (context) {
      return ItemDetails(
        itemModel: itemModel,
        appBarTitle: title,
      );
    }));

    if (result == true) {
      updateListView();
    }
  }

  void updateListView() async {
    var dbHelperFuture = dbHelper.initDb();
    dbHelperFuture.then((database) {
      Future<List<ItemModel>> itemListFuture = dbHelper.getItemList();
      itemListFuture.then((itemList) {
        setState(() {
          this._itemsList = itemList;
          this.count = itemList.length;
        });
      });
    });
  }
}


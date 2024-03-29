import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:my_barcode_scanner/components/item_card.dart';
import 'package:my_barcode_scanner/components/modal_icon_button.dart';
import 'package:my_barcode_scanner/models/placeholder.dart';
import 'package:shared_preferences/shared_preferences.dart';

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
  String fontfamily;

  DatabaseHelper dbHelper = DatabaseHelper();

  int count = 0;

  List<ItemModel> _itemsList;
  List<ItemModel> _filterList;
  List<String> theme;

  bool _firstSearch = true;

  TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    theme = PlaceHolder.theme ?? PlaceHolder.theme1;
    // fontfamily = PlaceHolder.fontfamily ?? PlaceHolder.fontFamilyRoboto;
    onchange().then((_) {
      setState(() {
        theme = PlaceHolder.theme ?? PlaceHolder.theme1;
        // fontfamily = PlaceHolder.fontfamily ?? PlaceHolder.fontFamilyRoboto;
      });
    });
  }

  onchange() async {
    final SharedPreferences pref = await SharedPreferences.getInstance();
    String fontsize = pref.getString("fontsize");
    String theme = pref.getString("theme");
   // String fontfamily = pref.getString("fontfamily");

    if (fontsize == null) {
      pref.setString("fontsize", "f2");
      PlaceHolder.fontsize = PlaceHolder.fontsize2;
      PlaceHolder.fs = 1;
    }
    if (theme == null) {
      pref.setString("theme", "t2");
      PlaceHolder.theme = PlaceHolder.theme2;
      PlaceHolder.ts = 1;
    }
    // if (fontfamily == null) {
    //   pref.setString("fontfamily", "ff2");
    //   PlaceHolder.fontfamily = PlaceHolder.fontFamilyPacifico;
    //   PlaceHolder.ffs = 1;
    // }
    if (fontsize != null && theme != null ) {
      setState(() {
        String ttype = pref.getString("theme");
        String ftype = pref.getString("fontsize");
        // String fftype = pref.getString("fontfamily");

        if (ttype == "t1") {
          PlaceHolder.theme = PlaceHolder.theme1;
          PlaceHolder.ts = 0;
        } else if (ttype == "t2") {
          PlaceHolder.theme = PlaceHolder.theme2;
          PlaceHolder.ts = 1;
        } else if (ttype == "t3") {
          PlaceHolder.theme = PlaceHolder.theme3;
          PlaceHolder.ts = 2;
        } else if (ttype == "t4") {
          PlaceHolder.theme = PlaceHolder.theme4;
          PlaceHolder.ts = 3;
        }

        if (ftype == "f1") {
          PlaceHolder.fontsize = PlaceHolder.fontsize1;
          PlaceHolder.fs = 0;
        } else if (ftype == "f2") {
          PlaceHolder.fontsize = PlaceHolder.fontsize2;
          PlaceHolder.fs = 1;
        } else if (ftype == "f3") {
          PlaceHolder.fontsize = PlaceHolder.fontsize3;
          PlaceHolder.fs = 2;
        }

        // if (fftype == "ff1") {
        //   PlaceHolder.fontfamily = PlaceHolder.fontFamilyRoboto;
        //   PlaceHolder.ffs = 0;
        // } else if (fftype == "ff2") {
        //   PlaceHolder.fontfamily = PlaceHolder.fontFamilyPacifico;
        //   PlaceHolder.ffs = 1;
        // }
      });
    }
  }

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
      backgroundColor:  Color(PlaceHolder.hexToInt(theme[2])),
      resizeToAvoidBottomPadding: false,
      appBar: AppBar(
        backgroundColor:  Color(PlaceHolder.hexToInt(theme[0])),
        automaticallyImplyLeading: false,
        title: searchCard(),
        centerTitle: true,
      ),
      body: _firstSearch
          ? ItemCard(
              itemList: _itemsList,
            )
          : _performSearch(),

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
        backgroundColor: Color(PlaceHolder.hexToInt(theme[0])),
        label: Text('Scan'),
        //  onPressed: _qrScanner,
        onPressed: () => _qrScanner(),
        // navigateToInfoPage(
        //     ItemModel(
        //         itemName: '',
        //         itemNotes: '',
        //         itemPicturePath: '',
        //         itemPrice: null,
        //         itemQty: null,
        //         itemTag: '',
        //         itemTotalPrice: 0),
        //     'ADD'),
        icon: Icon(Icons.camera_alt),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }

  Widget _performSearch() {
    _filterList = List<ItemModel>();
    for (var i = 0; i < _itemsList.length; i++) {
      var item = _itemsList[i];
      if (item.itemName.toLowerCase().contains(_query.toLowerCase()) ||
          item.itemNotes.toLowerCase().contains(_query.toLowerCase())) {
        _filterList.add(item);
      }
    }
    return ItemCard(
      itemList: _filterList,
    );
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

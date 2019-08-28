import 'package:flutter/material.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:my_barcode_scanner/components/item_card.dart';
import 'package:my_barcode_scanner/models/item_model.dart';
import 'package:my_barcode_scanner/resources/database_helper.dart';

class SearchPage extends StatefulWidget {
  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  TextEditingController _searchController = TextEditingController();

  DatabaseHelper dbHelper = DatabaseHelper();

  String _query = '';
  String _scanResult = '';

  List<ItemModel> _itemsList;
  List<ItemModel> _filterList;

  bool _firstSearch = true;

  _SearchPageState() {
    //   _searchController.addListener(() {
    //     setState(() {
    //       _query = _searchController.text;
    //     });
    //   });
    // }
    _searchController.addListener(() {
      if (_searchController.text.isEmpty) {
        setState(() {
          _firstSearch = true;
          _query = '';
        });
      } else if (_searchController.text.isNotEmpty) {
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
      appBar: AppBar(
        centerTitle: true,
        title: Text('Search Page'),
      ),
      body: Column(
        children: <Widget>[
          searchCard(),
          _firstSearch
              ? Expanded(
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Image.asset(
                        'assets/img/qr_barcode.png',
                        colorBlendMode: BlendMode.dstOut,
                        height: 120,
                      ),
                      Padding(
                        padding: EdgeInsets.all(28.0),
                        child: Material(
                          borderRadius: BorderRadius.circular(10.0),
                          color: Colors.orange,
                          elevation: 15,
                          child: MaterialButton(
                            height: 50,
                            onPressed: () {
                              _qrScanner();
                            },
                            minWidth: MediaQuery.of(context).size.width / 2,
                            child: Text(
                              'SCAN TO SEARCH',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                )
              : Expanded(child: _performSearch()),
        ],
      ),
    );
  }

  Future _qrScanner() async {
    String res;
    res = await FlutterBarcodeScanner.scanBarcode('#4caf50', null, true);

    setState(() {
      _scanResult = res;
    });
  }

  void updateListView() async {
    var dbHelperFuture = dbHelper.initDb();
    dbHelperFuture.then((database) {
      Future<List<ItemModel>> itemListFuture = dbHelper.getItemList();
      itemListFuture.then((itemList) {
        setState(() {
          this._itemsList = itemList;
          //  this.count = itemList.length;
        });
      });
    });
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
        padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 5),
        child: Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20.0),
          ),
          elevation: 5.0,
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 1, horizontal: 8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Icon(
                    Icons.search,
                    size: 25,
                  ),
                ),
                SizedBox(
                  width: 5.0,
                ),
                Expanded(
                  child: TextField(
                    controller: _searchController,
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: "Search ...",
                    ),
                  ),
                ),
                IconButton(
                  color: Colors.black,
                  icon: Icon(
                    Icons.border_horizontal,
                    color: Colors.red,
                  ),
                  iconSize: 35,
                  onPressed: () {
                    _qrScanner();
                  },
                ),
              ],
            ),
          ),
        ),
      );
}

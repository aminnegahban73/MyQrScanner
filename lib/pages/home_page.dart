import 'package:flutter/material.dart';

import 'package:sqflite/sqlite_api.dart';
import 'package:bottom_navy_bar/bottom_navy_bar.dart';

import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:my_barcode_scanner/models/item_model.dart';
import 'package:my_barcode_scanner/pages/item_info.dart';
import 'package:my_barcode_scanner/pages/qr_generator.dart';
import 'package:my_barcode_scanner/resources/database_helper.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String scanResult = '';

  DatabaseHelper dbHelper = DatabaseHelper();
  List<ItemModel> _itemsList;
  int count = 0;

  int _selectedIndex = 0;

  TextEditingController _searchController = TextEditingController();

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
      body: Container(
          child: _itemsList == null
              ? Container(
                  child: Center(
                    child: CircularProgressIndicator(),
                  ),
                )
              : ListView.builder(
                  itemCount: _itemsList.length,
                  itemBuilder: (BuildContext context, int i) {
                    return Padding(
                      padding: EdgeInsets.all(5.0),
                      child: InkWell(
                        onLongPress: () {
                          showModalBottomSheet(
                              backgroundColor: Colors.white60,
                              context: context,
                              builder: (BuildContext context) {
                                return Container(
                                  height: 250.0,
                                  width: 40,
                                  padding: EdgeInsets.all(10.0),
                                  child: ListView(
                                    children: <Widget>[
                                      Column(children: [
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceEvenly,
                                          children: <Widget>[
                                            ModalIconButton(
                                              onPressed: () {
                                                Navigator.pop(context);
                                                _navigateToInfoPage(
                                                    this._itemsList[i], 'Edit');
                                              },
                                              text: 'Edit',
                                              icon: Icon(Icons.edit),
                                            ),
                                            ModalIconButton(
                                              text: 'Quantity',
                                              icon: Icon(Icons.iso),
                                            ),
                                          ],
                                        ),
                                        SizedBox(
                                          height: 20,
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceEvenly,
                                          children: <Widget>[
                                            ModalIconButton(
                                              text: 'Copy',
                                              icon: Icon(Icons.content_copy),
                                            ),
                                            ModalIconButton(
                                              onPressed: () {
                                                Navigator.pop(context);
                                                dbHelper.deleteItem(
                                                    this._itemsList[i].itemID);
                                                setState(() {
                                                  this._itemsList.removeAt(i);
                                                });
                                              },
                                              text: 'Delete',
                                              icon: Icon(Icons.delete_outline),
                                            ),
                                          ],
                                        ),
                                      ]),
                                    ],
                                  ),
                                );
                              });
                        },
                        onTap: () =>
                            _navigateToInfoPage(this._itemsList[i], 'Edit'),
                        // Navigator.push(
                        //   context,
                        //   MaterialPageRoute(
                        //     builder: (context) =>
                        //         ItemInfo(itemModel: _itemsList[i]),
                        //   ),
                        // ),
                        child: Card(
                          child: Row(
                            children: <Widget>[
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: _itemsList[i].itemPicturePath == null
                                    ? Image.asset(
                                        'assets/img/no-image.jpg',
                                        height: 120.0,
                                        width: 120.0,
                                        fit: BoxFit.cover,
                                      )
                                    : Image.asset(
                                        _itemsList[i].itemPicturePath,
                                        height: 120.0,
                                        width: 120.0,
                                        fit: BoxFit.cover,
                                      ),
                              ),
                              Expanded(
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 8.0),
                                  child: Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceAround,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: <Widget>[
                                      Text(
                                        _itemsList[i].itemName,
                                        style: TextStyle(
                                            fontSize: 25,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      SizedBox(height: 20),
                                      Text(
                                        'Price = ${_itemsList[i].itemPrice}',
                                        style: TextStyle(
                                          color: Colors.grey,
                                          fontSize: 17,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      SizedBox(height: 5),
                                      Text(
                                        'Qty = ${_itemsList[i].itemQty}',
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
                                    onPressed: () {
                                      print('xcxx cx');
                                    },
                                    icon: Icon(Icons.more_vert),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                )

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

          ),
      floatingActionButton: FloatingActionButton.extended(
        label: Text('Scan'),
        //  onPressed: _qrScanner,
        onPressed: () => _navigateToInfoPage(
            ItemModel(
                itemName: '',
                itemNotes: '',
                itemPicturePath: '',
                itemPrice: 0,
                itemQty: 0,
                itemTag: '',
                itemTotalPrice: 0),
            'ADD'),
        icon: Icon(Icons.camera_alt),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      bottomNavigationBar: BottomNavyBar(
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
              activeColor: Colors.blueGrey ),
        ],
      ),
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

  void _navigateToInfoPage(ItemModel itemModel, String title) async {
    bool result =
        await Navigator.push(context, MaterialPageRoute(builder: (context) {
      return ItemInfo(
        appBarTitle: title,
        itemModel: itemModel,
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

  // Future<List<Map>> _getItems() async {
  //   // var items = await dbHelper.getAllItems();

  //   // for (var i = 0; i < items.length; i++) {
  //   //   _items.add(ItemModel.map(items[i]));
  //   // }

  //   // return _items;

  //   return dbHelper.queryAllRows();
  // }

}

class ModalIconButton extends StatelessWidget {
  final String text;
  final Icon icon;
  final Function onPressed;
  const ModalIconButton({
    Key key,
    this.text,
    this.icon,
    this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100,
      width: 100,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: <Widget>[
          IconButton(
            iconSize: 50,
            onPressed: this.onPressed,
            icon: this.icon,
          ),
          Text(
            this.text,
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          )
        ],
      ),
    );
  }
}

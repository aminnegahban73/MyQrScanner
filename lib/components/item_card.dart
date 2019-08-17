import 'package:flutter/material.dart';

import '../models/item_model.dart';
import '../resources/database_helper.dart';

class ItemsCard extends StatefulWidget {
  @override
  _ItemsCardState createState() => _ItemsCardState();
}

class _ItemsCardState extends State<ItemsCard> {
  DatabaseHelper db = DatabaseHelper();
  var _items;
  int count = 0;

  @override
  void initState() {
    super.initState();
    _fetchingData();
  }

  void _fetchingData() async {
    List items;
    items = await db.getAllItems();
    for (var i = 0; i < items.length; i++) {
      _items = ItemModel.map(items[i]);
       print('Saved Items ${_items.itemName} , ${_items.itemID},${_items.itemPicturePath}');
    }

    setState(() {
      _items = items;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(5.0),
      child: Card(
        child: Row(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Image.asset(
                _items.itemPicturePath,
                height: 120.0,
                width: 120.0,
                fit: BoxFit.cover,
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      _items.itemName,
                      style:
                          TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 20),
                    Text(
                      'Qty = ${_items.itemQty}',
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
  }
}

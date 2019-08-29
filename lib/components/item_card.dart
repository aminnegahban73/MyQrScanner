import 'package:flutter/material.dart';
import 'package:my_barcode_scanner/pages/home_page.dart';
import 'package:my_barcode_scanner/pages/item_details.dart';

import '../models/item_model.dart';
import '../resources/database_helper.dart';
import 'modal_icon_button.dart';

class ItemCard extends StatefulWidget {
  const ItemCard({
    Key key,
    this.itemList,
  }) : super(key: key);

  final List<ItemModel> itemList;

  @override
  _ItemCardState createState() => _ItemCardState();
}

class _ItemCardState extends State<ItemCard> {
  int count = 0;

  DatabaseHelper dbHelper = DatabaseHelper();

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: widget.itemList.length,
      itemBuilder: (BuildContext context, int i) {
        return Padding(
          padding: EdgeInsets.all(1.0),
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
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: <Widget>[
                                ModalIconButton(
                                  onPressed: () {
                                    Navigator.pop(context);
                                    navigateToInfoPage(
                                        this.widget.itemList[i], 'Edit');
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
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: <Widget>[
                                ModalIconButton(
                                  text: 'Copy',
                                  icon: Icon(Icons.content_copy),
                                ),
                                ModalIconButton(
                                  onPressed: () {
                                    Navigator.pop(context);
                                    dbHelper.deleteItem(
                                        this.widget.itemList[i].itemID);
                                    setState(() {
                                      this.widget.itemList.removeAt(i);
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
            onTap: () => navigateToInfoPage(this.widget.itemList[i], 'Edit'),
            // Navigator.push(
            //   context,
            //   MaterialPageRoute(
            //     builder: (context) =>
            //         ItemInfo(itemModel: itemList[i]),
            //   ),
            // ),
            child: Card(
              child: Row(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: widget.itemList[i].itemPicturePath == null
                        ? Image.asset(
                            'assets/img/no-image.jpg',
                            height: 120.0,
                            width: 120.0,
                            fit: BoxFit.cover,
                          )
                        : Image.asset(
                            widget.itemList[i].itemPicturePath,
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
                            widget.itemList[i].itemName,
                            style: TextStyle(
                                fontSize: 25, fontWeight: FontWeight.bold),
                          ),
                          SizedBox(height: 20),
                          Text(
                            'Price = ${widget.itemList[i].itemPrice}',
                            style: TextStyle(
                              color: Colors.grey,
                              fontSize: 17,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(height: 5),
                          Text(
                            'Qty = ${widget.itemList[i].itemQty}',
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
    );
  }

  void navigateToInfoPage(ItemModel itemModel, String title) async {
    await Navigator.push(context, MaterialPageRoute(builder: (context) {
      return ItemDetails(
        itemModel: itemModel,
        appBarTitle: title,
      );
    }));
  }
}

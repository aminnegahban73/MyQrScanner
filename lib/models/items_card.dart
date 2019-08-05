import 'package:flutter/material.dart';

class ItemsCard extends StatelessWidget {
  final String itemID;
  final String itemPicturePath;
  final String itemName;
  final int itemQty;
  final double itemPrice;
  final double itemTotalPrice;
  final String itemTag;
  final String itemNotes;

  ItemsCard({
    this.itemID,
    this.itemName,
    this.itemQty,
    this.itemPrice,
    this.itemTotalPrice,
    this.itemTag,
    this.itemNotes,
    this.itemPicturePath,
  });

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
                itemPicturePath,
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
                      itemName,
                      style:
                          TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 20),
                    Text(
                      'Qty = $itemQty',
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

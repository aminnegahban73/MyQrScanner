class ItemModel {
  int itemID;
  String itemPicturePath;
  String itemName;
  int itemQty;
  double itemPrice;
  double itemTotalPrice;
  String itemTag;
  String itemNotes;

  ItemModel(
   { this.itemID,
    this.itemName,
    this.itemQty,
    this.itemPrice,
    this.itemTotalPrice,
    this.itemTag,
    this.itemNotes,
    this.itemPicturePath,}
  );

  // int get itemID => _itemID;
  // String get itemPicturePath => _itemPicturePath;
  // String get itemName => _itemName;
  // int get itemQty => _itemQty;
  // double get itemPrice => _itemPrice;
  // double get itemTotalPrice => _itemTotalPrice;
  // String get itemTag => _itemTag;
  // String get itemNotes => _itemNotes;

  ItemModel.map(dynamic obj) {
    this.itemID = obj['itemID'];
    this.itemPicturePath = obj['itemPicturePath'];
    this.itemName = obj['itemName'];
    this.itemQty = obj['itemQty'];
    this.itemPrice = obj['itemPrice'];
    this.itemTotalPrice = obj['itemTotalPrice'];
    this.itemTag = obj['itemTag'];
    this.itemNotes = obj['itemNotes'];
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'itemID': itemID,
      'itemPicturePath': itemPicturePath,
      'itemName': itemName,
      'itemQty': itemQty,
      'itemPrice': itemPrice,
      'itemTotalPrice': itemTotalPrice,
      'itemTag': itemTag,
      'itemNotes': itemNotes,
    };
  }

  ItemModel.fromMap(Map<String, dynamic> parseMap)
      : this.itemID = parseMap['itemID'],
        this.itemPicturePath = parseMap['itemPicturePath'],
        this.itemName = parseMap['itemName'],
        this.itemQty = parseMap['itemQty'],
        this.itemPrice = parseMap['itemPrice'],
        this.itemTotalPrice = parseMap['itemTotalPrice'],
        this.itemTag = parseMap['itemTag'],
        this.itemNotes = parseMap['itemNotes'];
}

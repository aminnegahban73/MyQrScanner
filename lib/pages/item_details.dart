import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:my_barcode_scanner/models/item_model.dart';
import 'package:my_barcode_scanner/models/placeholder.dart';
import 'package:my_barcode_scanner/pages/home_page.dart';
import 'package:my_barcode_scanner/resources/database_helper.dart';

import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ItemDetails extends StatefulWidget {
  final Widget qrLabel;
  final ItemModel itemModel;
  final String appBarTitle;

  const ItemDetails({this.itemModel, this.appBarTitle, this.qrLabel});
  @override
  _ItemDetailsState createState() =>
      _ItemDetailsState(this.qrLabel, this.itemModel, this.appBarTitle);
}

class _ItemDetailsState extends State<ItemDetails> {
  ItemModel itemModel;
  Widget qrLabel;
  String appBarTitle;

  _ItemDetailsState(this.qrLabel, this.itemModel, this.appBarTitle);

  DatabaseHelper db = DatabaseHelper();

  File imageFile;

  final _formKey = GlobalKey<FormState>();

  String _itemPicturePath = '';
  String _itemName = "";
  String _itemQty = "";
  String _itemPrice = "";
  String _itemTag = "";
  String _itemNotes = "";
  String _totalPrice = "Total Price";

  TextEditingController _itemPicturePathController =
      new TextEditingController();
  TextEditingController _itemNameController = new TextEditingController();
  TextEditingController _itemQtyController = new TextEditingController();
  TextEditingController _itemPriceController = new TextEditingController();
  TextEditingController _itemTagController = new TextEditingController();
  TextEditingController _itemNotesController = new TextEditingController();

  List<String> theme;

  @override
  void initState() {
    if (itemModel.itemID == null)
      itemModel.itemPicturePath = 'assets/img/no-image.jpg';
    _itemNameController.text = itemModel.itemName;
    _itemQtyController.text =
        itemModel.itemQty == null ? '' : itemModel.itemQty.toString();
    _itemPriceController.text =
        itemModel.itemPrice == null ? '' : itemModel.itemPrice.toString();
    _itemTagController.text = itemModel.itemTag;
    _itemNotesController.text = itemModel.itemNotes;
    super.initState();
    theme = PlaceHolder.theme ?? PlaceHolder.theme1;
    // fontfamily = PlaceHolder.fontfamily ?? PlaceHolder.fontFamilyRoboto;
    onchange().then((_) {
      setState(() {
        theme = PlaceHolder.theme ?? PlaceHolder.theme1;
        // fontfamily = PlaceHolder.fontfamily ?? PlaceHolder.fontFamilyRoboto;
      });
    });
    if (itemModel.itemID != null &&
        _itemQtyController.text.isNotEmpty &&
        _itemPriceController.text.isNotEmpty) {
      double totalPrice = double.parse(_itemPriceController.text) *
          int.parse(_itemQtyController.text);
      _totalPrice = totalPrice.toString();
    }
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
    if (fontsize != null && theme != null) {
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

  @override
  Widget build(BuildContext context) {
    // _itemNameController.text = itemModel.itemName;
    // _itemQtyController.text = itemModel.itemQty.toString();
    // _itemPriceController.text = itemModel.itemPrice.toString();
    // _itemTagController.text = itemModel.itemTag;
    // _itemNotesController.text = itemModel.itemNotes;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(PlaceHolder.hexToInt(theme[0])),
        title: Text(appBarTitle),
        centerTitle: true,
      ),
      body: ListView(
        children: <Widget>[
          Center(
            child: Form(
              key: _formKey,
              child: Column(
                children: <Widget>[
                  //------------------Add Photo-------------------------
                  Container(
                    color: Colors.black12,
                    height: 300,
                    width: MediaQuery.of(context).size.width,
                    child: imageFile == null
                        ? imagePlaceHolder(context)
                        : Image.file(
                            imageFile,
                            fit: BoxFit.cover,
                            height: 300,
                            width: MediaQuery.of(context).size.width,
                          ),
                  ),
                  //------------------Item Name-------------------------
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 18.0),
                    child: Column(
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.only(
                              right: 25, left: 25, top: 20),
                          child: Material(
                            borderRadius: BorderRadius.circular(20.0),
                            color: Colors.blueAccent.withOpacity(0.3),
                            child: Padding(
                              padding: const EdgeInsets.only(left: 15.0),
                              child: ListTile(
                                title: TextField(
                                  controller: _itemNameController,
                                  onChanged: (String val) => updateItemName(),
                                  decoration: InputDecoration(
                                    border: InputBorder.none,
                                    labelText: 'Name',
                                    labelStyle: TextStyle(fontSize: 20),
                                  ),
                                  // keyboardType: TextInputType.emailAddress,
                                ),
                              ),
                            ),
                          ),
                        ),
                        //------------------Qty-------------------------
                        Padding(
                          padding: const EdgeInsets.only(
                              right: 25, left: 25, top: 20),
                          child: Material(
                            borderRadius: BorderRadius.circular(20.0),
                            color: Colors.blueAccent.withOpacity(0.3),
                            child: Padding(
                              padding: const EdgeInsets.only(left: 15.0),
                              child: ListTile(
                                title: TextField(
                                  controller: _itemQtyController,
                                  onChanged: (String val) => updateItemQty(),
                                  decoration: InputDecoration(
                                    border: InputBorder.none,
                                    labelText: 'Quantity',
                                    labelStyle: TextStyle(fontSize: 20),
                                  ),
                                  keyboardType: TextInputType.number,
                                ),
                                trailing: IconButton(
                                  onPressed: () {
                                    Alert(
                                      context: context,
                                      title: "Change Quantity",
                                      content: Padding(
                                        padding:
                                            const EdgeInsets.only(top: 20.0),
                                        child: Column(
                                          children: <Widget>[
                                            Row(
                                              mainAxisSize: MainAxisSize.max,
                                              mainAxisAlignment:
                                                  MainAxisAlignment.spaceEvenly,
                                              children: <Widget>[
                                                Stack(
                                                  alignment:
                                                      AlignmentDirectional
                                                          .center,
                                                  children: <Widget>[
                                                    Container(
                                                      child: Container(),
                                                    ),
                                                    Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .center,
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .center,
                                                      children: <Widget>[
                                                        Icon(
                                                          Icons.arrow_upward,
                                                          color: Colors.green,
                                                        ),
                                                        Text('Increase'),
                                                      ],
                                                    ),
                                                  ],
                                                ),
                                                Stack(
                                                  alignment:
                                                      AlignmentDirectional
                                                          .center,
                                                  children: <Widget>[
                                                    Container(
                                                      child: Container(),
                                                    ),
                                                    Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .center,
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .center,
                                                      children: <Widget>[
                                                        Icon(
                                                          Icons.arrow_downward,
                                                          color: Colors.red,
                                                        ),
                                                        Text('Decrease'),
                                                      ],
                                                    ),
                                                  ],
                                                ),
                                              ],
                                            ),
                                            TextField(
                                              decoration: InputDecoration(
                                                icon: Icon(Icons.add),
                                                labelText: 'Amount',
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      buttons: [
                                        DialogButton(
                                          color: Colors.grey,
                                          onPressed: () =>
                                              Navigator.pop(context),
                                          child: Text(
                                            "Cancel",
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 20),
                                          ),
                                        ),
                                        DialogButton(
                                          color: Colors.green,
                                          onPressed: () =>
                                              Navigator.pop(context),
                                          child: Text(
                                            "Update",
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 20),
                                          ),
                                        ),
                                      ],
                                    ).show();
                                    // Alert(context: context, title: "RFLUTTER", desc: "Flutter is awesome.").show();
                                  },
                                  icon: Icon(
                                    Icons.iso,
                                    size: 30,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                        //------------------Price and Total-------------------------
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: <Widget>[
                            Container(
                              width: 200,
                              child: Padding(
                                padding: const EdgeInsets.only(
                                    right: 25, left: 25, top: 20),
                                child: Material(
                                  borderRadius: BorderRadius.circular(20.0),
                                  color: Colors.blueAccent.withOpacity(0.3),
                                  child: Padding(
                                    padding: const EdgeInsets.only(left: 15.0),
                                    child: TextField(
                                      controller: _itemPriceController,
                                      onChanged: (String val) =>
                                          updateItemPrice(),
                                      decoration: InputDecoration(
                                        border: InputBorder.none,
                                        labelText: 'Price',
                                        labelStyle: TextStyle(fontSize: 20),
                                        icon: Icon(Icons.money_off),
                                      ),
                                      keyboardType: TextInputType.number,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(
                                  right: 25, left: 25, top: 20),
                              child: Text(
                               ' $_totalPrice  Toman',
                                style: TextStyle(
                                    fontSize: 20, color: Colors.black54),
                              ),
                            ),
                          ],
                        ),
                        //------------------Tags-------------------------
                        Padding(
                          padding: const EdgeInsets.only(
                              right: 25, left: 25, top: 20),
                          child: Material(
                            borderRadius: BorderRadius.circular(20.0),
                            color: Colors.blueAccent.withOpacity(0.3),
                            child: Padding(
                              padding: const EdgeInsets.only(left: 15.0),
                              child: ListTile(
                                title: TextField(
                                  controller: _itemTagController,
                                  onChanged: (String val) => updateItemTag(),
                                  decoration: InputDecoration(
                                    border: InputBorder.none,
                                    labelText: 'Tags',
                                    labelStyle: TextStyle(fontSize: 20),
                                  ),
                                  // keyboardType: TextInputType.emailAddress,
                                ),
                                trailing: IconButton(
                                  onPressed: () {},
                                  icon: Icon(
                                    Icons.add_circle_outline,
                                    size: 30,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                        //------------------Notes-------------------------
                        Padding(
                          padding: const EdgeInsets.only(
                              right: 25, left: 25, top: 20),
                          child: Material(
                            borderRadius: BorderRadius.circular(20.0),
                            color: Colors.blueAccent.withOpacity(0.3),
                            child: Padding(
                              padding: const EdgeInsets.only(left: 15.0),
                              child: ListTile(
                                title: TextField(
                                  controller: _itemNotesController,
                                  onChanged: (String val) => updateItemNotes(),
                                  decoration: InputDecoration(
                                    border: InputBorder.none,
                                    labelText: 'Notes',
                                    labelStyle: TextStyle(fontSize: 20),
                                  ),
                                  // keyboardType: TextInputType.emailAddress,
                                ),
                              ),
                            ),
                          ),
                        ),
                        //------------------QR Label-------------------------
                        Padding(
                          padding: EdgeInsets.all(10),
                          child: qrLabel,
                        ),
                        //------------------Save Button-------------------------
                        Padding(
                          padding: EdgeInsets.all(28.0),
                          child: Material(
                            borderRadius: BorderRadius.circular(20.0),
                            color: Colors.green,
                            child: MaterialButton(
                              height: 70,
                              onPressed: () {
                                //  _validateInputsAndSubmit();
                                _save();
                              },
                              minWidth: MediaQuery.of(context).size.width,
                              child: Text(
                                'SAVE',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 30,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  void _save() {
    _formKey.currentState.save();
    _saveItem();
    moveToHomeScreen();

    // setState(() {
    //   _totalPrice = (int.parse(_itemQty) * int.parse(_itemPrice)).toString();
    // });
    // print(_totalPrice);
  }

  Future<int> _saveItem() async {
    // int result;

    if (itemModel.itemID != null) {
      return await db.updateItem(itemModel);
    } else {
      return await db.addItem(itemModel
          // ItemModel(
          //   itemName: _itemName,
          //   itemQty: int.parse(_itemQty),
          //   itemPrice: double.parse(_itemPrice),
          //   itemTag: _itemTag,
          //   itemNotes: _itemNotes,
          // ),
          );
      // return result;
    }
    // if (result != 0) {
    //   // Success
    //   _showAlertDialog('Status', 'Note Saved Successfully');
    // } else {
    //   // Failure
    //   _showAlertDialog('Status', 'Problem Saving Note');
    // }
  }

  void moveToHomeScreen() {
    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (context) => HomePage()));
  }

  void _showAlertDialog(String title, String message) {
    AlertDialog alertDialog = AlertDialog(
      title: Text(title),
      content: Text(message),
    );
    showDialog(context: context, builder: (_) => alertDialog);
  }

  void _getImage(BuildContext context, ImageSource source) {
    ImagePicker.pickImage(source: source, maxWidth: 400.0).then((File image) {
      setState(() {
        imageFile = image;
      });
      Navigator.pop(context);
    });
  }

  void _openImagePicker(BuildContext context) {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext context) {
          return Container(
            height: 150.0,
            padding: EdgeInsets.all(10.0),
            child: Column(children: [
              Text(
                'Pick an Image',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: 10.0,
              ),
              FlatButton(
                textColor: Theme.of(context).primaryColor,
                child: Text('Use Camera'),
                onPressed: () {
                  _getImage(context, ImageSource.camera);
                },
              ),
              FlatButton(
                textColor: Theme.of(context).primaryColor,
                child: Text('Use Gallery'),
                onPressed: () {
                  _getImage(context, ImageSource.gallery);
                },
              )
            ]),
          );
        });
  }

  Widget imagePlaceHolder(BuildContext context) {
    return InkWell(
      onTap: () => _openImagePicker(context),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Container(
            margin: EdgeInsets.all(20),
            padding: EdgeInsets.all(20),
            decoration: BoxDecoration(
                border: Border.all(color: Colors.black),
                borderRadius: BorderRadius.all(Radius.circular(10))),
            child: Icon(Icons.camera_alt, size: 40, color: Colors.black54),
          ),
          Text(
            'ADD PHOTOS',
            style: TextStyle(fontSize: 20),
          )
        ],
      ),
    );
  }

  updateItemName() {
    itemModel.itemName = _itemNameController.text;
  }

  updateItemQty() {
    itemModel.itemQty = int.parse(_itemQtyController.text);
  }

  updateItemPrice() {
    itemModel.itemPrice = double.parse(_itemPriceController.text);
  }

  updateItemTag() {
    itemModel.itemTag = _itemTagController.text;
  }

  updateItemNotes() {
    itemModel.itemNotes = _itemNotesController.text;
  }
}

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import 'package:rflutter_alert/rflutter_alert.dart';

class ItemInfo extends StatefulWidget {
  final Widget qrLabel;

  const ItemInfo({Key key, this.qrLabel}) : super(key: key);
  @override
  _ItemInfoState createState() => _ItemInfoState();
}

class _ItemInfoState extends State<ItemInfo> {  
  bool qtyButtonState = true;
  File imageFile;

  void _buttonChange() {
    setState(() {
      qtyButtonState = !qtyButtonState;
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Item'),
        centerTitle: true,
      ),
      body: ListView(
        children: <Widget>[
          Center(
            child: Form(
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
                                title: TextFormField(
                                  decoration: InputDecoration(
                                    border: InputBorder.none,
                                    labelText: 'Item Name',
                                    labelStyle: TextStyle(fontSize: 20),
                                  ),
                                  keyboardType: TextInputType.emailAddress,
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
                                title: TextFormField(
                                  decoration: InputDecoration(
                                    border: InputBorder.none,
                                    labelText: 'Quantity',
                                    labelStyle: TextStyle(fontSize: 20),
                                  ),
                                  keyboardType: TextInputType.emailAddress,
                                ),
                                trailing: IconButton(
                                  onPressed: () {
                                    Alert(
                                      context: context,
                                      title: "Change Quantity",
                                      content: Column(
                                        children: <Widget>[
                                          Row(
                                            children: <Widget>[
                                              Center(
                                                child: Wrap(
                                                  children: <Widget>[
                                                    MaterialButton(
                                                      onPressed: qtyButtonState
                                                          ? _buttonChange
                                                          : null,
                                                      child: Text("button1"),
                                                      color: Colors.greenAccent,
                                                    ),
                                                    MaterialButton(
                                                      onPressed: qtyButtonState
                                                          ? null
                                                          : _buttonChange,
                                                      child: Text("button2"),
                                                      color: Colors.greenAccent,
                                                    ),
                                                  ],
                                                ),
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
                                    child: TextFormField(
                                      decoration: InputDecoration(
                                        border: InputBorder.none,
                                        labelText: 'Price',
                                        labelStyle: TextStyle(fontSize: 20),
                                        icon: Icon(Icons.money_off),
                                      ),
                                      keyboardType: TextInputType.emailAddress,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(
                                  right: 25, left: 25, top: 20),
                              child: Text(
                                'Total Value',
                                style: TextStyle(
                                    fontSize: 20, color: Colors.black54),
                              ),
                            ),
                          ],
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                              right: 25, left: 25, top: 20),
                          child: Material(
                            borderRadius: BorderRadius.circular(20.0),
                            color: Colors.blueAccent.withOpacity(0.3),
                            child: Padding(
                              padding: const EdgeInsets.only(left: 15.0),
                              child: ListTile(
                                title: TextFormField(
                                  decoration: InputDecoration(
                                    border: InputBorder.none,
                                    labelText: 'Tags',
                                    labelStyle: TextStyle(fontSize: 20),
                                  ),
                                  keyboardType: TextInputType.emailAddress,
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
                                title: TextFormField(
                                  decoration: InputDecoration(
                                    border: InputBorder.none,
                                    labelText: 'Notes',
                                    labelStyle: TextStyle(fontSize: 20),
                                  ),
                                  keyboardType: TextInputType.emailAddress,
                                ),
                              ),
                            ),
                          ),
                        ),
                        //------------------QR Label-------------------------
                        Padding(
                          padding: EdgeInsets.all(10),
                          child: widget.qrLabel,
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
}

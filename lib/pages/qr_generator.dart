// import 'dart:io';
// import 'dart:typed_data';
// import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:my_barcode_scanner/models/item_model.dart';
import 'package:my_barcode_scanner/pages/item_details.dart';
// import 'package:flutter/rendering.dart';
// import 'package:flutter/services.dart';
import 'package:qr_flutter/qr_flutter.dart';

class QrGenerator extends StatefulWidget {
  final String _inputText;

  QrGenerator(this._inputText);

  @override
  _QrGeneratorState createState() => _QrGeneratorState();
}

class _QrGeneratorState extends State<QrGenerator> {
  String scanResult = '';

//   static const double _topSectionTopPadding = 50.0;
//   static const double _topSectionBottomPadding = 20.0;
//   static const double _topSectionHeight = 50.0;

//   GlobalKey globalKey = new GlobalKey();
//   String _dataString = "Hello from this QR";
//   final TextEditingController _textController =  TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('QR Code Generator'),
        // actions: <Widget>[
        //   IconButton(
        //     icon: Icon(Icons.share),
        //     onPressed: _captureAndSharePng,
        //   )
        // ],
      ),

      body: _contentBody(),
      // body: _contentWidget(),
    );
  }

  Widget qrImg() {
    return Column(
      children: <Widget>[
        QrImage(
          data: widget._inputText,
          size: 200.0,
          foregroundColor: Colors.indigo,
        ),
        Text(
          widget._inputText,
          style: TextStyle(fontSize: 30),
        ),
      ],
    );
  }

  Widget _contentBody() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          qrImg(),
          Column(
            children: <Widget>[
              Padding(
                padding: EdgeInsets.symmetric(vertical: 18.0, horizontal: 50),
                child: Material(
                  borderRadius: BorderRadius.circular(20.0),
                  color: Colors.green,
                  child: MaterialButton(
                    height: 70,
                    onPressed: () {
                      //  _validateInputsAndSubmit();
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ItemDetails(
                            itemModel: ItemModel(
                                itemName: '',
                                itemNotes: '',
                                itemPicturePath: '',
                                itemPrice: null,
                                itemQty: null,
                                itemTag: '',
                                itemTotalPrice: 0),
                                appBarTitle: 'ADD',
                            qrLabel: qrImg(),
                          ),
                        ),
                      );
                    },
                    minWidth: MediaQuery.of(context).size.width,
                    child: Text(
                      'LINK',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 30,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(vertical: 18.0, horizontal: 50),
                child: Material(
                  borderRadius: BorderRadius.circular(20.0),
                  color: Colors.blue,
                  child: MaterialButton(
                    height: 70,
                    onPressed:
                        //  _validateInputsAndSubmit();
                        _qrScanner,
                    minWidth: MediaQuery.of(context).size.width,
                    child: Text(
                      'ReSCAN',
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
          )
        ],
      ),
    );
  }

  Future _qrScanner() async {
    String res;
    res = await FlutterBarcodeScanner.scanBarcode('#4caf50', 'لغو', true);

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
}
//   Future<void> _captureAndSharePng() async {
//     try {
//       RenderRepaintBoundary boundary = globalKey.currentContext.findRenderObject();
//       var image = await boundary.toImage();
//       ByteData byteData = await image.toByteData(format: ImageByteFormat.png);
//       Uint8List pngBytes = byteData.buffer.asUint8List();

//       final tempDir = await getTemporaryDirectory();
//       final file = await new File('${tempDir.path}/image.png').create();
//       await file.writeAsBytes(pngBytes);

//       final channel = const MethodChannel('channel:me.alfian.share/share');
//       channel.invokeMethod('shareFile', 'image.png');

//     } catch(e) {
//       print(e.toString());
//     }
//   }

//   _contentWidget() {
//     final bodyHeight = MediaQuery.of(context).size.height - MediaQuery.of(context).viewInsets.bottom;
//     return  Container(
//       color: const Color(0xFFFFFFFF),
//       child:  Column(
//         children: <Widget>[
//           Padding(
//             padding: const EdgeInsets.only(
//               top: _topSectionTopPadding,
//               left: 20.0,
//               right: 10.0,
//               bottom: _topSectionBottomPadding,
//             ),
//             child:  Container(
//               height: _topSectionHeight,
//               child:  Row(
//                 mainAxisSize: MainAxisSize.max,
//                 crossAxisAlignment: CrossAxisAlignment.stretch,
//                 children: <Widget>[
//                   Expanded(
//                     child:  TextField(
//                       controller: _textController,
//                       decoration:  InputDecoration(
//                         hintText: "Enter a custom message",
//                         errorText: _inputErrorText,
//                       ),
//                     ),
//                   ),
//                   Padding(
//                     padding: const EdgeInsets.only(left: 10.0),
//                     child:  FlatButton(
//                       child:  Text("SUBMIT"),
//                       onPressed: () {
//                         setState((){
//                           _dataString = _textController.text;
//                           _inputErrorText = null;
//                         });
//                       },
//                     ),
//                   )
//                 ],
//               ),
//             ),
//           ),
//           Expanded(
//             child:  Center(
//               child: RepaintBoundary(
//                 key: globalKey,
//                 child: QrImage(
//                   data: _dataString,
//                   size: 0.5 * bodyHeight,
//                   onError: (ex) {
//                     print("[QR] ERROR - $ex");
//                     setState((){
//                       _inputErrorText = "Error! Maybe your input value is too long?";
//                     });
//                   },
//                 ),
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }

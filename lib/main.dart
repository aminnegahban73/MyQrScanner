import 'package:flutter/material.dart';
import 'package:my_barcode_scanner/pages/item_info.dart';
import 'package:my_barcode_scanner/service_locator.dart';

import 'pages/home_page.dart';

void main() {
  setupLocator();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Barcode Scanner',
      theme: ThemeData(
        primaryColor: Colors.red,
        accentColor: Colors.redAccent,
      ),
      home: ItemInfo(),
    );
  }
}

// import 'package:flutter/material.dart';
// import 'components/connected_btton.dart';
// import 'service_locator.dart';
// void main() {
//   setupLocator();
//   runApp(MyApp());
// }
// class MyApp extends StatelessWidget {
//   // This widget is the root of your application.
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//         title: 'Flutter Demo',
//         theme: ThemeData(
//           primarySwatch: Colors.blue,
//         ),
//         home: Scaffold(
//             backgroundColor: Colors.grey[800],
//             body: Column(
//               mainAxisSize: MainAxisSize.max,
//               mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//               children: <Widget>[
//                 ConnectedButton(id: 0),
//                 ConnectedButton(id: 1),
//                 ConnectedButton(id: 2)
//               ],
//             )));
//   }
// }


// // class Page1State extends State<Page1> {
// //   bool buttonState = true;

// //   void _buttonChange() {
// //     setState(() {
// //       buttonState = !buttonState;
// //     });
// //   }

// //   @override
// //   Widget build(BuildContext context) {
// //     return Scaffold(
// //       appBar: AppBar(
// //         title: Text('Button State'),
// //       ),
// //       body: Center(
// //         child: Wrap(
// //           children: <Widget>[
// //             MaterialButton(
// //               onPressed: buttonState ? _buttonChange : null,
// //               child: Text("button1"),
// //               color: Colors.greenAccent,
// //             ),
// //             MaterialButton(
// //               onPressed: buttonState ? null : _buttonChange,
// //               child: Text("button2"),
// //               color: Colors.greenAccent,
// //             ),
// //           ],
// //         ),
// //       ),
// //     );
// //   }
// // }
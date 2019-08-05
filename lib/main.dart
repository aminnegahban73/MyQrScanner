import 'package:flutter/material.dart';
import 'package:my_barcode_scanner/pages/item_info.dart';

import 'pages/home_page.dart';

void main() => runApp(MyApp());

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

// class Page1State extends State<Page1> {
//   bool buttonState = true;

//   void _buttonChange() {
//     setState(() {
//       buttonState = !buttonState;
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Button State'),
//       ),
//       body: Center(
//         child: Wrap(
//           children: <Widget>[
//             MaterialButton(
//               onPressed: buttonState ? _buttonChange : null,
//               child: Text("button1"),
//               color: Colors.greenAccent,
//             ),
//             MaterialButton(
//               onPressed: buttonState ? null : _buttonChange,
//               child: Text("button2"),
//               color: Colors.greenAccent,
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

import 'dart:async';
import 'package:flutter/material.dart';
import 'package:my_barcode_scanner/services/button_messagebu.dart';
import '../service_locator.dart';

class ConnectedButton extends StatefulWidget {
  final int id;
  ConnectedButton({@required this.id});
  @override
  _ConnectedButtonState createState() => _ConnectedButtonState();
}

class _ConnectedButtonState extends State<ConnectedButton> {
  bool _active = false;
  Color _color;
  String _text;
  //double _size = 100;
  ButtonMessagebus _messageBus = locator<ButtonMessagebus>();
  StreamSubscription<int> messageSubscription;
  @override
  void initState() {
    // Listen for Id received
    messageSubscription = _messageBus.idStream.listen(_idReceived);
    super.initState();
  }

  void _idReceived(int id) {
    setState(() {
      if (id == widget.id) {
        _active = true;
        _color = Colors.grey;
        // _size = 140;
      } else {
        _active = false;
        _color = Colors.white;
        //  _size = 100;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        // Broadcast Id
        _messageBus.broadcastId(widget.id);
      },
      child: _buttonUi,
    );
  }

  @override
  void dispose() {
    super.dispose();
    messageSubscription.cancel();
  }

  Widget get _buttonUi => Container(
    
        alignment: Alignment.center,
        height: 50,
        width: 110,
        decoration: BoxDecoration(border: Border.all(color: Colors.black),
            color: _color, borderRadius: BorderRadius.circular(10.0)),
      );
}

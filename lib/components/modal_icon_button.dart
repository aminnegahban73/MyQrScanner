import 'package:flutter/material.dart';

class ModalIconButton extends StatelessWidget {
  final String text;
  final Icon icon;
  final Function onPressed;
  const ModalIconButton({
    Key key,
    this.text,
    this.icon,
    this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100,
      width: 100,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: <Widget>[
          IconButton(
            iconSize: 50,
            onPressed: this.onPressed,
            icon: this.icon,
          ),
          Text(
            this.text,
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          )
        ],
      ),
    );
  }
}

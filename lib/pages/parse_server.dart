import 'package:flutter/material.dart';
import 'package:parse_server_sdk/parse_server_sdk.dart';

class ParseServer extends StatelessWidget {
  Future aaaa() async {
    await Parse().initialize("myAppId", "mongodb://localhost:27017/dev");
  }
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}

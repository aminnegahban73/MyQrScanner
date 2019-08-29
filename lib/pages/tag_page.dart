import 'package:flutter/material.dart';
import 'package:my_barcode_scanner/models/placeholder.dart';
import 'package:shared_preferences/shared_preferences.dart';

class TagPage extends StatefulWidget {
  
  @override
  _TagPageState createState() => _TagPageState();
}

class _TagPageState extends State<TagPage> {

  List<String> theme;
  @override
  void initState() {
    super.initState();
    theme = PlaceHolder.theme ?? PlaceHolder.theme1;
    // fontfamily = PlaceHolder.fontfamily ?? PlaceHolder.fontFamilyRoboto;
    onchange().then((_) {
      setState(() {
        theme = PlaceHolder.theme ?? PlaceHolder.theme1;
        // fontfamily = PlaceHolder.fontfamily ?? PlaceHolder.fontFamilyRoboto;
      });
    });
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
    if (fontsize != null && theme != null ) {
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
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(PlaceHolder.hexToInt(theme[0])),
        centerTitle: true,
        title: Text('Tag Page'),
      
      ),
      body: Container(),
    );
  }
}

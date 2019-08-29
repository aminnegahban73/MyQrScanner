import 'package:flutter/material.dart';

class PlaceHolder {
  static Function onpress;
  static BuildContext homePageContext;
  static bool isArch = false;
  static int selectedIndex = 1;

  static double fontsize;
  static List<String> theme;
  // static String fontfamily;

  static String logoGreen="Assets/logo-green.png";
  static String logoBlue="Assets/logo-blue.png";
  static String logoGrey="Assets/logo-grey.png";
  static String logo;

  static int ts=0;
  static int fs=0;
  //static int ffs=0;

  static double fontsize1=13;
  static double fontsize2=23;
  static double fontsize3=30;

  // static String fontFamilyRoboto ='Roboto';
  // static String fontFamilyPacifico ='Pacifico';
 



  static List<String> theme1 = [
    "9E9E9E",
    "ECEFF1",
    "F5F5F5",
    "EEEEEE",
    "E0E0E0",
    "BDBDBD",
    "9E9E9E",
    "757575",
    "616161",
    "424242",
    "212121"
  ];
  static List<String> theme2 = [
    "607D8B",
    "ECEFF1",
    "CFD8DC",
    "B0BEC5",
    "90A4AE",
    "78909C",
    "607D8B",
    "546E7A",
    "455A64",
    "37474F",
    "263238"
  ];
  static List<String> theme3 = [
    "2196F3",
    "E3F2FD",
    "BBDEFB",
    "90CAF9",
    "64B5F6",
    "42A5F5",
    "2196F3",
    "1E88E5",
    "1976D2",
    "1565C0",
    "0D47A1"
  ];
  static List<String> theme4 = [
    "4CAF50",
    "E8F5E9",
    "C8E6C9",
    "A5D6A7",
    "81C784",
    "66BB6A",
    "4CAF50",
    "43A047",
    "388E3C",
    "2E7D32",
    "1B5E20",
  ];

  static int hexToInt(String hex) {
    int val = 0;
    hex = 'FF' + hex;
    int len = hex.length;
    for (int i = 0; i < len; i++) {
      int hexDigit = hex.codeUnitAt(i);
      if (hexDigit >= 48 && hexDigit <= 57) {
        val += (hexDigit - 48) * (1 << (4 * (len - 1 - i)));
      } else if (hexDigit >= 65 && hexDigit <= 70) {
        // A..F
        val += (hexDigit - 55) * (1 << (4 * (len - 1 - i)));
      } else if (hexDigit >= 97 && hexDigit <= 102) {
        // a..f
        val += (hexDigit - 87) * (1 << (4 * (len - 1 - i)));
      } else {
        throw new FormatException("Invalid hexadecimal value");
      }
    }
    return val;
  }
}

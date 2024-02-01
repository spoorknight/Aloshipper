import 'package:flutter/material.dart';

class Palette {
  static const Color error = Color(0xffEE1133);
  static const Color green00D566 = Color(0xFF00D566);
  static const Color green00B256 = Color(0xFF00B256);
  static const Color white = Color(0xFFFFFFFF);
  static const Color black = Color(0xFF000000);
  static const Color black181818 = Color(0xFF181818);
  static const Color black54 = Colors.black54;
  static const Color transparent = Colors.transparent;
  static const Color background = Color(0xFFFFFFFF);
  static const Color success = Color(0xff1ed351);
  static const Color green00A64F = Color(0xff00A64F);
  static const Color green = Colors.green;
  static const Color greyE4E7EC = Color(0xffE4E7EC);
  static const Color green1d9655 = Color(0xff1d9655);
  static const Color lightGreen = Color(0xffceebd8);
  static const Color yellow = Color(0xffefb629);
  static const Color yellowFA961A = Color(0xffFA961A);
  static const Color yellowFCB72B = Color(0xffFCB72B);
  static const Color yellowCD6907 = Color(0xffCD6907);
  static const Color yellowFFF2D1 = Color(0xffFFF2D1);
  static const Color yellowF9EF5A = Color(0xffF9EF5A);
  static const Color yellowFFBA4D = Color(0xffFFBA4D);
  static const Color yellowFFE4B9 = Color(0xffFFE4B9);
  static const Color orange = Colors.orange;
  static const Color hint = Color(0xFFC4C4C4);
  static const Color icon = Color(0xff8598AD);
  static const Color blue = Color(0xff3C75D3);
  static const Color bg80opacity = Color(0xfff9f8fb);
  static const Color red = Colors.red;
  static const Color border = Color(0xFFCBD5E1);
  static const Color grey = Color(0xffa7a7a7);
  static const Color lightGrey = Color(0xffF7F6FA);
  static const Color buttonGrey = Color(0xff64748b);
  static const Color textGrey = Color(0xFF969696);
  static const Color pinkBorder = Color(0xFFFF9797);
  static const Color primary = Color(0xFFC91919);
  static const Color primary50 = Color(0xFFE23E3E);
  static const Color primary70 = Color(0xFFAF3333);
  static const Color primarySecond = Color(0xFFFF0000);
  static const Color primaryF9D8D8 = Color(0xFFF9D8D8);
  static const Color linkBlue = Color(0xFF1782E3);
  static const Color linkBlue3492E7 = Color(0xFF3492E7);
  static const Color nuatral = Color(0xFF181818);
  static const Color nuatral90 = Color(0xFF303030);
  static const Color nuatral20 = Color(0xFFD9D9D9);
  static const Color nuatral30 = Color(0xFFC1C1C1);
  static const Color nuatral50 = Color(0xFF919191);
  static const Color newLightGrey = Color(0xFFF2F3F5);
  static const Color iconMenuHomeUnSelect = Color(0xFF868686);
  static const Color whiteEEF2F3 = Color(0xFFEEF2F3);
  static const Color blue141C69 = Color(0xFF141C69);
  static const Color redD31212 = Color(0xFFD31212);
  static const Color bgColor = Color(0xFFF0F2F5);

  static final List<Color> bgColorEvent = [
    HexColor('#8409D6'),
    HexColor('#008EFF'),
    HexColor('#09C2D6'),
    HexColor('#095BD6'),
  ];
  static final List<Color> bgColorShare = [
    HexColor('#86CF3A'),
    HexColor('#27AE1D'),
  ];
  static final List<Color> btnHarvest = [
    HexColor('#F01071'),
    HexColor('#FFC606'),
  ];
}


class HexColor extends Color {
  static int _getColorFromHex(String hexColor) {
    hexColor = hexColor.toUpperCase().replaceAll("#", "");
    if (hexColor.length == 6) {
      hexColor = "FF" + hexColor;
    }
    return int.parse(hexColor, radix: 16);
  }

  HexColor(final String hexColor) : super(_getColorFromHex(hexColor));
}

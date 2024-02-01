import 'config.dart';
import 'package:flutter/material.dart';

extension ColorExtension on TextStyle {
  TextStyle get white => copyWith(color: Palette.white);
  TextStyle get red => copyWith(color: Palette.red);
  TextStyle get success => copyWith(color: Palette.success);
  TextStyle get green => copyWith(color: Palette.green);
  TextStyle get underline => copyWith(decoration: TextDecoration.underline);
  TextStyle get lineThrough => copyWith(decoration: TextDecoration.lineThrough);
  TextStyle get italic => copyWith(fontStyle: FontStyle.italic);
  TextStyle get blue => copyWith(color: Palette.blue);
  TextStyle get black => copyWith(color: Palette.black);
  TextStyle get yellow => copyWith(color: Palette.yellow);
  TextStyle get yellowFFF2D1 => copyWith(color: Palette.yellowFFF2D1);
  TextStyle get yellowCD6907 => copyWith(color: Palette.yellowCD6907);
  TextStyle get yellowFA961A => copyWith(color: Palette.yellowFA961A);
  TextStyle get yellowF9EF5A => copyWith(color: Palette.yellowF9EF5A);
  TextStyle get orange => copyWith(color: Palette.orange);
  TextStyle get error => copyWith(color: Palette.error);
  TextStyle get hint => copyWith(color: Palette.hint);
  TextStyle get nuatral50 => copyWith(color: Palette.nuatral50);
  TextStyle get nuatral90 => copyWith(color: Palette.nuatral90);
  TextStyle get primary => copyWith(color: Palette.primary);
  TextStyle get primary50 => copyWith(color: Palette.primary50);
  TextStyle get linkBlue => copyWith(color: Palette.linkBlue);
  TextStyle get linkBlue3492E7 => copyWith(color: Palette.linkBlue3492E7);
  TextStyle get nuatral => copyWith(color: Palette.nuatral);
}

extension MyFontWeight on TextStyle {
  TextStyle get w900 => copyWith(fontWeight: FontWeight.w900);
  TextStyle get w700 => copyWith(fontWeight: FontWeight.w700);
  TextStyle get w600 => copyWith(fontWeight: FontWeight.w600);
  TextStyle get w500 => copyWith(fontWeight: FontWeight.w500);
  TextStyle get w400 => copyWith(fontWeight: FontWeight.w400);
  TextStyle get w300 => copyWith(fontWeight: FontWeight.w300);
}

extension MyFontSize on TextStyle {
  TextStyle s([double size = 14]) => copyWith(fontSize: size.sp);
}

class AppFont {
  static TextStyle get t => TextStyle(
        color: Palette.black,
        fontSize: 14.sp,
        fontWeight: FontWeight.w400,
        fontFamily: FontFamily.beVN,
      );
}

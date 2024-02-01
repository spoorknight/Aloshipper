import 'package:flutter/material.dart';

import 'config.dart';

class AppTheme {
  static const EdgeInsets mainPadding = EdgeInsets.symmetric(horizontal: 16);

  static BoxDecoration boxDecoration = const BoxDecoration(
    color: Palette.white,
    boxShadow: [
      BoxShadow(
        color: Color(0x3F000000),
        blurRadius: 2,
        offset: Offset(0, 1),
        spreadRadius: 0,
      )
    ],
  );

  static InputDecorationTheme textFormFieldNonBorder([InputBorder? border]) =>
      InputDecorationTheme(
        labelStyle: AppFont.t.green,
        contentPadding:
            const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
        hintStyle: AppFont.t.hint,
        border: border,
        focusedBorder: border,
      );

  static ShapeDecoration shapeDecoration = ShapeDecoration(
    color: Colors.white,
    shape: RoundedRectangleBorder(
      side: BorderSide(
        width: 0.50,
        color: Colors.black.withOpacity(0.20000000298023224),
      ),
      borderRadius: BorderRadius.circular(10),
    ),
    shadows: const [
      BoxShadow(
        color: Color(0x19000000),
        blurRadius: 6,
        offset: Offset(0, 4),
        spreadRadius: 0,
      ),
      BoxShadow(
        color: Color(0x0F000000),
        blurRadius: 4,
        offset: Offset(0, 2),
        spreadRadius: 0,
      )
    ],
  );

  static ThemeData themeData = ThemeData(
    scaffoldBackgroundColor: Palette.white,
    fontFamily: FontFamily.beVN,
    colorScheme: ColorScheme.fromSwatch().copyWith(
      primary: Palette.green,
    ),
  );

  static InputDecorationTheme textFormField([double r = 8]) =>
      InputDecorationTheme(
        labelStyle: AppFont.t.green,
        contentPadding: const EdgeInsets.symmetric(horizontal: 12),
        hintStyle: AppFont.t.hint,
        focusColor: Palette.green,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(r),
          borderSide: const BorderSide(
            color: Palette.grey,
          ),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(r),
          borderSide: const BorderSide(
            color: Palette.green,
          ),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(r),
          borderSide: const BorderSide(
            color: Palette.red,
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(r),
          borderSide: const BorderSide(
            color: Palette.grey,
          ),
        ),
        disabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(r),
          borderSide: const BorderSide(
            color: Palette.grey,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(r),
          borderSide: const BorderSide(
            color: Palette.green,
          ),
        ),
      );
}

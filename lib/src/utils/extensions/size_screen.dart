import 'package:flutter/material.dart';

extension SizeScreen on BuildContext {

  double w() {
    return MediaQuery.of(this).size.width;
  }

  double h() {
    return MediaQuery.of(this).size.height;
  }

  double getHeightSafe() {
    return h() -
        kBottomNavigationBarHeight -
        MediaQuery.of(this).padding.top -
        MediaQuery.of(this).padding.bottom;
  }
}

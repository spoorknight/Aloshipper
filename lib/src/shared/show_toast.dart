import 'package:fluttertoast/fluttertoast.dart';

import '../configs/config.dart';

class ShowToast {
  static error(String? message) {
    if (message != null) {
      Fluttertoast.showToast(
        msg: message,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: Palette.red,
        textColor: Palette.background,
        fontSize: 14.0,
      );
    }
  }

  static success(String? message) {
    if (message != null) {
      Fluttertoast.showToast(
        msg: message,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: Palette.success,
        textColor: Palette.background,
        fontSize: 14.0,
      );
    }
  }

  static normal(String? message) {
    if (message != null) {
      Fluttertoast.showToast(
        msg: message,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: Palette.border,
        textColor: Palette.black,
        fontSize: 14.0,
      );
    }
  }
}

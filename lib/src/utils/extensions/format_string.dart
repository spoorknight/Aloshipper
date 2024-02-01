import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:tiengviet/tiengviet.dart';

extension FormatDate on String {
  String formatDate() {
    if (isNotEmpty) {
      return DateFormat('dd/MM/yyyy').format(DateTime.parse(this));
    } else {
      return '';
    }
  }
}

extension FormaterCurrency on String {

  String get toPoint {
    try {
      final money =
      NumberFormat.currency(locale: 'en', symbol: '', decimalDigits: 2)
          .format(num.parse(this))
          .replaceAll('.00', '');

      return "$money điểm";
    } catch (e) {
      return this;
    }
  }

  String get toCurrency {
    return NumberFormat.currency(locale: 'en', symbol: '', decimalDigits: 0)
        .format(double.parse(this));
  }

  String get toVnd {
    try {
      final money =
      NumberFormat.currency(locale: 'en', symbol: '', decimalDigits: 2)
          .format(num.parse(this))
          .replaceAll('.00', '');

      return "$money đ";
    } catch (e) {
      return this;
    }
  }

  String get removeTrailingZero {
    RegExp regex = RegExp(r"([.]*0+)(?!.*\d)");
    if (this != '') {
      return replaceAll(regex, '');
    }
    return this;
  }

  String get formatNumber {
    try {
      return NumberFormat.decimalPattern('en').format(double.parse(this));
    } catch (e) {
      return this;
    }
  }

  String get hide {
    try {
      return replaceAll(RegExp(r'\d(?!\d{0,2}$)'), '*');
    } catch (e) {
      return this;
    }
  }

  String get removeComma {
    return replaceAll(',', '');
  }

  bool toBool() {
    if (this == 'true') {
      return true;
    }
    if (this == 'false') {
      return false;
    }
    throw Exception();
  }

  formatTextControllerAmount() {
    return TextEditingValue(
      text: this,
      selection: TextSelection.collapsed(offset: length),
    );
  }
}

extension StringExtension on String {
  String unSign() {
    return TiengViet.parse(this);
  }

  String hidePhoneNumber() {
    if (length >= 10) {
      String maskedNumber = replaceRange(3, length - 3, '*' * (length - 6));
      return maskedNumber;
    } else {
      // Xử lý trường hợp số điện thoại ngắn hơn 10 ký tự (nếu cần)
      return this;
    }
  }
}

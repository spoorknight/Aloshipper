import 'package:flutter/material.dart';

extension ContextExtension on BuildContext {
  void get hideKeyboard => FocusScope.of(this).unfocus();

  Size get device => MediaQuery.of(this).size;
}

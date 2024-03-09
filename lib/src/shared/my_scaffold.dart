import 'package:flutter/material.dart';

import '../configs/config.dart';

class MyScaffold extends StatelessWidget {
  const MyScaffold({
    Key? key,
    required this.body,
    this.header,
    this.bottom,
    this.appBar,
    this.padding = AppTheme.mainPadding,
    this.bgColor,
    this.resizeToAvoidBottomInset,
    this.safeAreaBottom = true,
    this.onWillPop,

  }) : super(key: key);
  final Widget? header;
  final Widget body;
  final Widget? bottom;
  final PreferredSizeWidget? appBar;
  final EdgeInsets? padding;
  final bool? resizeToAvoidBottomInset;
  final Color? bgColor;
  final bool safeAreaBottom;
  final Future<bool> Function()? onWillPop;


  @override
  Widget build(BuildContext context) {
    return Container(
      color: Palette.background,
      child: SafeArea(
        bottom: safeAreaBottom,
        child: Scaffold(
          appBar: appBar,
          backgroundColor: bgColor,
          resizeToAvoidBottomInset: resizeToAvoidBottomInset,
          body: Container(
            width: double.infinity,
            padding: padding,
            child: body,
          ),
          bottomNavigationBar: bottom,
        ),
      ),
    );
  }
}

import 'dart:async';

import 'package:flutter/material.dart';
import '../configs/config.dart';

class MyScaffold extends StatefulWidget {
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
  State<MyScaffold> createState() => _MyScaffoldState();
}

class _MyScaffoldState extends State<MyScaffold> {



  @override
  Widget build(BuildContext context) {
    return Container(
      color: Palette.background,
      child: SafeArea(
        bottom: widget.safeAreaBottom,
        child: Scaffold(
          appBar: widget.appBar,
          backgroundColor: widget.bgColor,
          resizeToAvoidBottomInset: widget.resizeToAvoidBottomInset,
          body: Stack(
            children: [
              Container(
                width: double.infinity,
                padding: widget.padding,
                child: widget.body,
              ),
            ],
          ),
          bottomNavigationBar: widget.bottom,
        ),
      ),
    );
  }


}

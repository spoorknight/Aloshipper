import 'package:flutter/material.dart';

import '../configs/config.dart';

class MyAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String? title;
  final List<Widget>? actions;
  final bool automaticallyImplyLeading;
  final bool? centerTitle;
  final TextStyle? titleStyle;
  final Color? backgroundColor;
  final Widget? leading;
  final Widget? titleWidget;

  const MyAppBar({
    Key? key,
    this.title,
    this.actions,
    this.automaticallyImplyLeading = true,
    this.centerTitle,
    this.titleStyle,
    this.backgroundColor = Palette.transparent,
    this.leading,
    this.titleWidget,
  })  : preferredSize = const Size.fromHeight(kToolbarHeight),
        super(key: key);

  @override
  final Size preferredSize;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      automaticallyImplyLeading: automaticallyImplyLeading,
      shape: const Border(bottom: BorderSide(color: Palette.grey, width: 1)),
      foregroundColor: Palette.red,
      centerTitle: centerTitle == true,
      elevation: 0,
      backgroundColor: backgroundColor,
      title: titleWidget ?? Text(title ?? "", style: titleStyle ?? AppFont.t),
      leading: leading,
      actions: actions,
    );
  }
}

class MyAppBarHome extends StatelessWidget implements PreferredSizeWidget {
  final Widget? title;
  final List<Widget>? actions;
  final Widget? leading;
  final bool? centerTitle;

  const MyAppBarHome({
    Key? key,
    this.title,
    this.actions,
    this.leading,
    this.centerTitle,
  })  : preferredSize = const Size.fromHeight(kToolbarHeight),
        super(key: key);

  @override
  final Size preferredSize;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      titleSpacing: 8,
      leading: leading ??
          IconButton(
            icon: const Icon(Icons.arrow_back, color: Palette.red),
            onPressed: () => Navigator.pop(context),
          ),
      foregroundColor: Palette.background,
      centerTitle: centerTitle == true,
      elevation: 0,
      backgroundColor: Palette.transparent,
      title: title,
      actions: actions,
    );
  }
}

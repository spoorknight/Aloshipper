import 'dart:async';

import 'package:flutter/material.dart';

import '../configs/config.dart';

class BaseButtonWidget extends StatefulWidget {
  const BaseButtonWidget({
    super.key,
    required this.child,
    this.onTap,
    this.duration,
    this.decoration,
    this.icon,
    this.padding,
  });

  final Widget child;
  final Function()? onTap;
  final Duration? duration;
  final Decoration? decoration;
  final Widget? icon;
  final EdgeInsetsGeometry? padding;

  @override
  State<BaseButtonWidget> createState() => _BaseButtonWidgetState();
}

class _BaseButtonWidgetState extends State<BaseButtonWidget> {
  Timer? _debounce;

  _onSearchChanged() {
    if (_debounce?.isActive ?? false) _debounce?.cancel();
    _debounce = Timer(widget.duration ?? const Duration(milliseconds: 200), () {
      if (widget.onTap != null) widget.onTap!();
    });
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: _onSearchChanged,
      child: Container(
          padding: widget.padding,
          decoration: widget.decoration,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              if (widget.icon != null) ...[
                widget.icon!,
                BoxConst.s4,
              ],
              widget.child,
            ],
          )),
    );
  }
}

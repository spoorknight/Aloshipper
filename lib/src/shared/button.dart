import 'package:flutter/material.dart';

import '../configs/config.dart';

class MyButton extends StatelessWidget {
  const MyButton({
    Key? key,
    this.width,
    this.height,
    required this.title,
    required this.action,
    this.color,
    this.icon,
    this.subIcon,
    this.titleStyle,
    this.borderRadius,
    this.decoration,
  }) : super(key: key);
  final Widget? icon;
  final Widget? subIcon;
  final double? width;
  final double? height;
  final String title;
  final VoidCallback? action;
  final Color? color;
  final Decoration? decoration;

  final double? borderRadius;
  final TextStyle? titleStyle;

  const MyButton.green({
    Key? key,
    this.width,
    this.height,
    required this.title,
    required this.action,
    this.color = Palette.green,
    this.icon,
    this.borderRadius,
    this.titleStyle,
    this.decoration,
    this.subIcon,
  }) : super(key: key);

  const MyButton.rounded({
    Key? key,
    this.width,
    this.height,
    required this.title,
    required this.action,
    this.color = Palette.red,
    this.icon,
    this.titleStyle,
    this.borderRadius = 30,
    this.decoration,
    this.subIcon,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: action,
      child: Container(
        width: width ?? double.infinity,
        height: height ?? 40.h,
        decoration: decoration ?? BoxDecoration(
          borderRadius: BorderRadius.circular(borderRadius ?? 0),
          color: action != null ? color ?? Palette.red : color?.withOpacity(0.5) ?? Palette.red.withOpacity(0.5),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (icon != null)
              Padding(
                padding: const EdgeInsets.only(right: 4),
                child: icon!,
              ),
            Text(
              title,
              style: titleStyle ?? AppFont.t.s(16).white,
              textAlign: TextAlign.center,
            ),
            if(subIcon!=null)...[
              BoxConst.s8,
              subIcon!
            ]
          ],
        ),
      ),
    );
  }
}

class MyTextButton extends StatelessWidget {
  const MyTextButton({
    Key? key,
    required this.text,
    this.action,
    this.alignment,
    this.color,
    this.width,
    this.height,
    this.style,
  }) : super(key: key);
  final String text;
  final VoidCallback? action;
  final Alignment? alignment;
  final Color? color;
  final double? width;
  final double? height;
  final TextStyle? style;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      height: height,
      child: TextButton(
        style: ButtonStyle(
          alignment: alignment ?? Alignment.center,
          overlayColor: MaterialStateProperty.all(Colors.transparent),
        ),
        onPressed: action,
        child: Text(
          text,
          style: style ?? AppFont.t.copyWith(color: color),
        ),
      ),
    );
  }
}

class AddButton extends StatelessWidget {
  final VoidCallback? onPressed;
  final double size;
  const AddButton({Key? key, this.onPressed, this.size = 24}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: size * 1.25,
      width: size * 1.25,
      decoration: BoxDecoration(
        color: Palette.red,
        borderRadius: BorderRadius.circular(4),
      ),
      child: IconButton(
        padding: EdgeInsets.zero,
        icon: Icon(Icons.add, color: Palette.white, size: size),
        onPressed: onPressed,
      ),
    );
  }
}

class MinusButton extends StatelessWidget {
  final VoidCallback? onPressed;
  final double size;
  const MinusButton({Key? key, this.onPressed, this.size = 24}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: size * 1.25,
      width: size * 1.25,
      decoration: BoxDecoration(
        color: Palette.white,
        borderRadius: BorderRadius.circular(4),
        border: Border.all(color: Palette.red),
      ),
      child: IconButton(
        padding: EdgeInsets.zero,
        icon: Icon(Icons.remove, color: Palette.red, size: size),
        onPressed: onPressed,
      ),
    );
  }
}

class CategoryButton extends StatelessWidget {
  final String title;
  final Widget image;
  final VoidCallback? onTap;
  const CategoryButton({
    Key? key,
    required this.title,
    required this.image,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          BoxConst.s8,
          Container(
            height: 40.h,
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: Palette.grey),
            ),
            child: image,
          ),
          BoxConst.s4,
          Text(
            title,
            maxLines: 2,
            style: AppFont.t.s(12),
            textAlign: TextAlign.center,
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    );
  }
}

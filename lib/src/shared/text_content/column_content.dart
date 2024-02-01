import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../configs/config.dart';

class ColumnContent extends StatelessWidget {
  final String? title;
  final String? content;
  final String? iconContent;
  final TextStyle? styleContent;
  final bool? canCopy;

  const ColumnContent({
    Key? key,
    required this.title,
    required this.content,
    this.iconContent,
    this.styleContent,
    this.canCopy,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        BoxConst.s16,
        Text(title ?? '', style: AppFont.t),
        BoxConst.s8,
        iconContent == null
            ? Stack(
                children: [
                  Text(content ?? '', style: styleContent ?? AppFont.t.w700),
                  Visibility(
                    visible: canCopy ?? false,
                    child: Align(
                      alignment: Alignment.centerRight,
                      child: SvgPicture.asset('assets/icon/16px/copy.svg'),
                    ),
                  )
                ],
              )
            : Row(
                children: [
                  SvgPicture.asset(
                    iconContent!,
                    width: 16,
                    height: 16,
                  ),
                  BoxConst.s4,
                  Text(
                    content ?? '',
                    style: styleContent ?? AppFont.t.w700,
                  )
                ],
              ),
      ],
    );
  }
}

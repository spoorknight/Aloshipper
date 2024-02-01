import 'package:app_shipper/src/utils/extensions/extensions.dart';
import 'package:app_shipper/src/widgets/base_button_widget.dart';
import 'package:flutter/material.dart';

import '../../../configs/config.dart';
import '../../../widgets/line_painter/line_painter_widget.dart';
import '../../../widgets/measure_size_widget.dart';

class ItemExpand extends StatefulWidget {
  final String title;
  final List<String> description;
  final double price;
  final VoidCallback? onTapBuy;
  final bool? isSelected;

  const ItemExpand({
    super.key,
    required this.title,
    required this.description,
    required this.price,
    this.onTapBuy,
    this.isSelected,
  });

  @override
  State<ItemExpand> createState() => _ItemExpandState();
}

class _ItemExpandState extends State<ItemExpand> {
  bool isExpand = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: AppTheme.boxDecoration.copyWith(
        borderRadius: BorderRadius.circular(6.r),
      ),
      padding: EdgeInsets.symmetric(vertical: 10.sp, horizontal: 10.sp),
      child: Column(
        children: [
          Visibility(visible: isExpand == true, child: renderColumnInfo()),
          Visibility(visible: isExpand == false, child: renderRowInfo()),
        ],
      ),
    );
  }

  Widget renderColumnInfo() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              widget.title,
              style: AppFont.t.s(13).w700.linkBlue3492E7,
            ),
            if (widget.isSelected == true) ...[
              Assets.svgs.checkGreen.svg(width: 16.sp, height: 16.sp)
            ] else ...[
              const SizedBox.shrink(),
            ],
          ],
        ),
        BoxConst.s12,
        Text(
          widget.price.toString().toVnd,
          style: AppFont.t.s(14).w500.nuatral90,
        ),
        BoxConst.s8,
        ...widget.description
            .map(
              (item) => Container(
                padding: EdgeInsets.only(top: 10.sp),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Icon(
                      Icons.check,
                      size: 16.sp,
                      color: Palette.nuatral90,
                    ),
                    BoxConst.s8,
                    Expanded(
                      child: Text(
                        item,
                        style: AppFont.t.s(13).w400.nuatral90,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),
              ),
            )
            .toList(),
        BoxConst.s12,
        BaseButtonWidget(
          onTap: widget.onTapBuy,
          decoration: BoxDecoration(
            color: Palette.linkBlue,
            borderRadius: BorderRadius.circular(8.r),
          ),
          padding: EdgeInsets.symmetric(vertical: 10.sp, horizontal: 18.sp),
          child: Text(
            'Mua ngay',
            style: AppFont.t.s(12).w500.white,
            textAlign: TextAlign.center,
          ),
        ),
        BoxConst.s12,
        InkWell(
          onTap: () => setState(() {
            isExpand = !isExpand;
          }),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Thu gọn',
                style: AppFont.t.s(10).w500.linkBlue,
              ),
              BoxConst.s4,
              Icon(
                Icons.keyboard_arrow_up,
                size: 12.sp,
                color: Palette.linkBlue,
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget renderRowInfo() {
    double heightWidget = 80.sp;
    return StatefulBuilder(builder: (context, st) {
      return MeasureSize(
        onChange: (size) {
          st(() {
            heightWidget = size.height;
          });
        },
        child: Row(
          children: [
            Expanded(
              flex: 7,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    padding:
                        EdgeInsets.symmetric(vertical: 6.sp, horizontal: 10.sp),
                    decoration: BoxDecoration(
                      color: Palette.linkBlue.withOpacity(0.2),
                      borderRadius: BorderRadius.circular(6.r),
                    ),
                    child: Text(
                      widget.title,
                      style: AppFont.t.s(13).w700.linkBlue3492E7,
                    ),
                  ),
                  BoxConst.s8,
                  ...widget.description
                      .map(
                        (item) => Text(
                          item,
                          style: AppFont.t.s(13).w400.nuatral90,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      )
                      .toList(),
                  BoxConst.s8,
                  InkWell(
                    onTap: () => setState(() {
                      isExpand = !isExpand;
                    }),
                    child: Row(
                      children: [
                        Text(
                          'Xem chi tiết',
                          style: AppFont.t.s(10).w500.linkBlue,
                        ),
                        BoxConst.s4,
                        Icon(
                          Icons.keyboard_arrow_down,
                          size: 12.sp,
                          color: Palette.linkBlue,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: heightWidget,
              child: AdvancedLine(
                direction: Axis.vertical,
                line: DashedLine(dashSize: 2.sp, gapSize: 5.sp),
                paintDef: Paint()
                  ..strokeWidth = 1.sp
                  ..strokeCap = StrokeCap.round
                  ..color = Palette.nuatral30,
              ),
            ),
            Expanded(
              flex: 4,
              child: Stack(
                children: [
                  SizedBox(
                    height: heightWidget,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          widget.price.toString().toVnd,
                          style: AppFont.t.s(14).w500.nuatral90,
                        ),
                        BoxConst.s4,
                        BaseButtonWidget(
                          onTap: widget.onTapBuy,
                          child: Container(
                            decoration: BoxDecoration(
                              color: Palette.linkBlue,
                              borderRadius: BorderRadius.circular(8.r),
                            ),
                            padding: EdgeInsets.symmetric(
                                vertical: 10.sp, horizontal: 18.sp),
                            child: Text(
                              'Mua ngay',
                              style: AppFont.t.s(12).w500.white,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  if (widget.isSelected == true) ...[
                    Positioned(
                      top: 0,
                      right: 0,
                      child: Assets.svgs.checkGreen
                          .svg(width: 16.sp, height: 16.sp),
                    ),
                  ],
                ],
              ),
            ),
          ],
        ),
      );
    });
  }
}

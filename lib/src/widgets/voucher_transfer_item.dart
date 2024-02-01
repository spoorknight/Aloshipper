
import 'package:app_shipper/src/configs/config.dart';
import 'package:app_shipper/src/utils/extensions/extensions.dart';
import 'package:flutter/material.dart';

import 'coupon_uikit/coupon_uikit.dart';

class VoucherTransferItem extends StatelessWidget {
  final String? pointNeedToChange;
  final Function()? onTap;
  final bool isEnoughPoint;
  final String title;
  final String money;
  final String? titleBtn;

  const VoucherTransferItem({
    super.key,
    this.pointNeedToChange,
    this.titleBtn,
    this.onTap,
    this.isEnoughPoint = false,
    required this.title,
    required this.money,
  });

  @override
  Widget build(BuildContext context) {
    return CouponCard(
      height: 105.sp,
      curvePosition: 220.sp,
      curveRadius: 16.r,
      borderRadius: 8.r,
      curveAxis: Axis.vertical,
      shadow: const BoxShadow(
        color: Color(0x3F000000),
        blurRadius: 2,
        offset: Offset(0, 1),
        spreadRadius: 0,
      ),
      decoration: const BoxDecoration(
        color: Palette.white,
      ),
      firstChild: Container(
        padding: EdgeInsets.symmetric(vertical: 14.sp, horizontal: 10.sp),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              title,
              style: AppFont.t.s(15).w500.black,
            ),
            BoxConst.s8,
            Text.rich(
              TextSpan(
                text: 'Giảm: ',
                style: AppFont.t.s(13).w400.black,
                children: [
                  TextSpan(
                    text: money.toVnd,
                    style: AppFont.t.s(13).w700.black,
                  ),
                ],
              ),
            ),
            if (pointNeedToChange != null) ...[
              BoxConst.s8,
              Container(
                padding: EdgeInsets.symmetric(vertical: 4.sp, horizontal: 8.sp),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(4.r),
                  color: Palette.yellowFFF2D1,
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Assets.svgs.coin.svg(width: 16.sp, height: 16.sp),
                    BoxConst.s4,
                    Text(
                      pointNeedToChange!.formatNumber,
                      style: AppFont.t.s(13).w700.yellowCD6907,
                    ),
                  ],
                ),
              ),
            ],
          ],
        ),
      ),
      secondChild: CustomPaint(
        painter: DrawDottedVerticalLine(
          dotSpacing: 6.sp,
          color: Palette.grey,
        ),
        child: Container(
          padding: EdgeInsets.symmetric(vertical: 14.sp, horizontal: 10.sp),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Assets.svgs.giftOutline.svg(
                width: 24.sp,
                height: 24.sp,
              ),
              BoxConst.s8,
              InkWell(
                onTap: isEnoughPoint ? onTap : null,
                child: Container(
                  padding:
                      EdgeInsets.symmetric(vertical: 8.sp, horizontal: 14.sp),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(6.r),
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: isEnoughPoint
                            ? [
                                Palette.yellowFCB72B,
                                Palette.yellowFA961A,
                              ]
                            : [
                                Palette.grey,
                                Palette.buttonGrey,
                              ],
                      )),
                  child: Text(
                    titleBtn ?? 'Đổi điểm',
                    style: AppFont.t.s(12).w500.white,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

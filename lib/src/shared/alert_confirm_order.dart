import 'dart:async';

import 'package:app_shipper/src/shared/button.dart';
import 'package:flutter/material.dart';

import '../configs/config.dart';
import '../utils/constants.dart';

class AlertConfirmOrder extends StatefulWidget {
  const AlertConfirmOrder({
    super.key,
    required this.typeOrder,
    required this.action,
    required this.actionCancel,
    required this.resetTime,
  });

  final String typeOrder;
  final VoidCallback? action;
  final VoidCallback? actionCancel;
  final num resetTime;

  @override
  State<AlertConfirmOrder> createState() => _AlertConfirmOrderState();
}

class _AlertConfirmOrderState extends State<AlertConfirmOrder> {
  num _start = 0;
  final oneSec = const Duration(seconds: 1);

  @override
  void initState() {
    super.initState();
    _start = widget.resetTime;
    Timer.periodic(
      oneSec,
      (Timer timer) {
        if (_start == 0) {
          setState(() {
            timer.cancel();
          });
        } else {
          setState(() {
            _start--;
          });
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    String title =
        widget.typeOrder == Constants.TYPE_MUA_HANG ? 'AloFood' : 'AloBike';
    String mess = widget.typeOrder == Constants.TYPE_MUA_HANG
        ? 'Bạn đã nhận được đơn AloFood'
        : 'Bạn đã nhận được cuốc mới';
    String desc = widget.typeOrder == Constants.TYPE_MUA_HANG
        ? 'Đi thôi !!'
        : 'Khách hàng đang đợi bạn !!';

    Widget icon = widget.typeOrder == Constants.TYPE_MUA_HANG
        ? Assets.svgs.bikeRed.svg(
            width: 80.sp,
            height: 80.sp,
          )
        : Assets.svgs.checkRed.svg(
            width: 80.48,
            height: 80.48,
          );

    String confirmName =
        widget.typeOrder == Constants.TYPE_MUA_HANG ? 'Nhận đơn' : 'Nhận cuốc';

    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Container(
          padding: EdgeInsets.symmetric(vertical: 8.sp),
          decoration: BoxDecoration(
            color: Palette.primary50,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(8.r),
              topRight: Radius.circular(8.r),
            ),
          ),
          child: Text(
            title,
            style: AppFont.t.s(16).w400.white,
            textAlign: TextAlign.center,
          ),
        ),
        BoxConst.s12,
        Text(
          mess,
          style: AppFont.t.s(16).w400.nuatral90,
          textAlign: TextAlign.center,
        ),
        BoxConst.s12,
        icon,
        Padding(
          padding: EdgeInsets.only(top: 12.sp),
          child: Text(
            desc,
            style: AppFont.t.s(12).w400.nuatral90,
            textAlign: TextAlign.center,
          ),
        ),
        BoxConst.s16,
        Padding(
          padding:
              EdgeInsets.symmetric(horizontal: 10.sp).copyWith(bottom: 10.sp),
          child: Row(
            children: [
              Expanded(
                child: MyButton(
                  title: 'Bỏ qua',
                  borderRadius: 4.r,
                  color: Palette.white,
                  titleStyle: AppFont.t.s(12).w700,
                  action: widget.actionCancel,
                ),
              ),
              BoxConst.s12,
              Expanded(
                child: MyButton(
                  title: confirmName,
                  borderRadius: 4.r,
                  color: Palette.primary,
                  titleStyle: AppFont.t.s(12).w700.white,
                  action: widget.action,
                  subIcon: CircleAvatar(
                    radius: 14.r,
                    backgroundColor: Palette.primary50,
                    child: Text(
                      _start.toString(),
                      style: AppFont.t.s(12).w700.white,
                    ),
                  ),
                ),
              ),
            ],
          ),
        )
      ],
    );
  }
}

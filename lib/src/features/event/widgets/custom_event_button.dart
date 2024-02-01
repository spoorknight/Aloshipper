import 'package:app_shipper/src/configs/config.dart';
import 'package:flutter/material.dart';

class CustomEventButton extends StatelessWidget {
  const CustomEventButton({
    super.key,
    this.onTap,
    required this.txtButton,
    this.isDisable = false,
    this.leftWidget,
  });

  final Function()? onTap;
  final String txtButton;
  final bool isDisable;
  final Widget? leftWidget;

  @override
  Widget build(BuildContext context) {
    if (isDisable == true) {
      return Container(
        width: 90.w,
        height: 31.w,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8.r),
          border: Border.all(
            width: 2,
            strokeAlign: BorderSide.strokeAlignOutside,
            color: Palette.nuatral90,
          ),
        ),
        child: Container(
          padding: EdgeInsets.only(bottom: 4.w, left: 4.w, right: 4.w),
          decoration: BoxDecoration(
            color: const Color(0xFFA7A8A9).withOpacity(0.8),
            borderRadius: BorderRadius.circular(8.r),
          ),
          child: Container(
            padding: EdgeInsets.only(top: 4.w),
            decoration: BoxDecoration(
              color: const Color(0xFFD1D1D1),
              borderRadius: BorderRadius.circular(8.r),
            ),
            child: Container(
              decoration: BoxDecoration(
                color: const Color(0xFFC0C0C0),
                borderRadius: BorderRadius.circular(3.r),
              ),
              child: Center(
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    if (leftWidget != null) ...[
                      leftWidget!,
                      BoxConst.s4,
                    ],
                    Text(
                      txtButton,
                      style: AppFont.t.s(10).w700.white,
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      );
    }

    return InkWell(
      onTap: onTap,
      child: Container(
        width: 90.w,
        height: 31.w,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8.r),
          border: Border.all(
            width: 2,
            strokeAlign: BorderSide.strokeAlignOutside,
            color: const Color(0xFF011187),
          ),
        ),
        child: Container(
          padding: EdgeInsets.only(bottom: 4.w),
          decoration: BoxDecoration(
            color: const Color(0xFF095BD6).withOpacity(0.8),
            borderRadius: BorderRadius.circular(8.r),
          ),
          child: Container(
            padding: EdgeInsets.only(top: 4.w, left: 4.w, right: 4.w),
            decoration: BoxDecoration(
              color: const Color(0xFF51F5FF),
              borderRadius: BorderRadius.circular(8.r),
            ),
            child: Container(
              decoration: BoxDecoration(
                color: const Color(0xFF00A4FF),
                borderRadius: BorderRadius.circular(3.r),
              ),
              child: Center(
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    if (leftWidget != null) ...[
                      leftWidget!,
                      BoxConst.s4,
                    ],
                    Text(
                      txtButton,
                      style: AppFont.t.s(10).w700.white,
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

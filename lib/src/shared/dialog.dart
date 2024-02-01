import 'dart:async';

import 'package:app_shipper/src/navigator/app_navigator.dart';
import 'package:app_shipper/src/shared/alert_confirm_order.dart';
import 'package:app_shipper/src/utils/extensions/context_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../configs/config.dart';
import '../utils/extensions/extensions.dart';
import '../widgets/base_button_widget.dart';
import '../widgets/measure_size_widget.dart';
import 'button.dart';

class DialogConfirm extends StatelessWidget {
  final String mess;
  final String? title;
  final VoidCallback? action;
  final VoidCallback? actionCancel;
  final String? titleButton;
  final String? cancelButton;

  const DialogConfirm({
    Key? key,
    required this.mess,
    required this.action,
    this.titleButton,
    this.cancelButton,
    this.actionCancel,
    this.title,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(8))),
      elevation: 5,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 16),
        width: MediaQuery.of(context).size.width / 0.5,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (title != null)
              Text(
                title!,
                style: AppFont.t.s(16).w700,
                textAlign: TextAlign.center,
              ),
            Text(
              mess,
              style: AppFont.t.s(16).w400,
              textAlign: TextAlign.center,
            ),
            BoxConst.s16,
            Row(
              children: [
                Expanded(
                  child: MyTextButton(
                    alignment: Alignment.centerLeft,
                    text: cancelButton ?? 'Quay lại',
                    action: actionCancel ?? AppNavigator.pop,
                  ),
                ),
                Expanded(
                  child: MyButton.rounded(
                    title: titleButton ?? 'Đồng ý',
                    borderRadius: 8,
                    action: () {
                      AppNavigator.pop();
                      action?.call();
                    },
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}

showDialogDescription(String html) {
  showDialog(
    context: AppNavigator.navigatorKey.currentContext!,
    builder: (builder) {
      bool? isExpand;
      return Dialog(
        elevation: 5,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(10.r))),
        child: Container(
          padding: const EdgeInsets.all(16),
          constraints: BoxConstraints(
            maxHeight: builder.device.height * 0.7,
          ),
          // height: builder.device.height * 0.7,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10.r),
                        border:
                            Border.all(color: Palette.greyE4E7EC, width: 1)),
                    padding: EdgeInsets.all(10.sp),
                    child: Icon(
                      Icons.help_outline,
                      size: 24.sp,
                    ),
                  ),
                  BaseButtonWidget(
                    onTap: AppNavigator.pop,
                    child: Icon(
                      Icons.close,
                      size: 24.sp,
                      color: Palette.nuatral30,
                    ),
                  ),
                ],
              ),
              BoxConst.s8,
              StatefulBuilder(builder: (context, setState) {
                if (isExpand == true) {
                  return Expanded(
                    child: SingleChildScrollView(
                      child: Html(
                        data: html,
                        shrinkWrap: true,
                      ),
                    ),
                  );
                } else {
                  return MeasureSize(
                    onChange: (size) {
                      if (isExpand == null) {
                        setState(() {
                          isExpand = size.height >= builder.device.height * 0.8
                              ? true
                              : false;
                        });
                      }
                    },
                    child: Html(
                      data: html,
                      shrinkWrap: true,
                    ),
                  );
                }
              }),
              BoxConst.s16,
              const Divider(color: Palette.nuatral30),
              BoxConst.s8,
              const MyButton(
                title: "Đóng",
                action: AppNavigator.pop,
                borderRadius: 8,
              )
            ],
          ),
        ),
      );
    },
  );
}

class DialogConfirmTransfer extends StatelessWidget {
  final String mess;
  final String? desc;
  final VoidCallback? action;
  final String confirmName;

  const DialogConfirmTransfer({
    Key? key,
    required this.mess,
    required this.action,
    required this.confirmName,
    this.desc,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Dialog(
      elevation: 5,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(8.r))),
      child: Container(
        padding: EdgeInsets.all(14.sp),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              mess,
              style: AppFont.t.s(13).w700,
              textAlign: TextAlign.center,
            ),
            if (desc != null)
              Padding(
                padding: const EdgeInsets.only(top: 8),
                child: Text(
                  desc!,
                  style: AppFont.t,
                  textAlign: TextAlign.center,
                ),
              ),
            BoxConst.s24,
            Row(
              children: [
                Expanded(
                  child: MyTextButton(
                    text: 'Đóng',
                    action: AppNavigator.pop,
                    style: AppFont.t.s(13).w700.yellowFA961A,
                  ),
                ),
                Expanded(
                  child: MyButton(
                    title: confirmName,
                    action: action,
                    borderRadius: 8,
                    color: Palette.yellowFA961A,
                    titleStyle: AppFont.t.s(13).w700.white,
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}

class DialogConfirmQuestion extends StatelessWidget {
  final VoidCallback? action;
  final VoidCallback? actionCancel;
  final num resetTime;
  final String typeOrder;

  const DialogConfirmQuestion({
    Key? key,
    required this.typeOrder,
    required this.action,
    required this.actionCancel,
    required this.resetTime,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Dialog(
      elevation: 5,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(10.r))),
      child: AlertConfirmOrder(
        action: action,
        actionCancel: actionCancel,
        resetTime: resetTime,
        typeOrder: typeOrder,
      ),
    );
  }
}

class DialogSuccess extends StatelessWidget {
  final String mess;
  final Function action;

  const DialogSuccess({Key? key, required this.mess, required this.action})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Dialog(
      elevation: 5,
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(20))),
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            SvgPicture.asset("assets/success_drive.svg"),
            const SizedBox(
              height: 20,
            ),
            Text(
              mess,
              style: const TextStyle(fontWeight: FontWeight.w500),
              textAlign: TextAlign.center,
            ),
            const SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Expanded(
                  child: SizedBox(
                    height: 48,
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.pop(context);
                        action();
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.white,
                        side: const BorderSide(color: Palette.blue, width: 1),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15),
                        ),
                      ),
                      child: Text(
                        "Đóng",
                        style: AppFont.t.blue,
                      ),
                    ),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}

class DialogError extends StatelessWidget {
  final String mess;
  final VoidCallback? action;

  const DialogError({Key? key, required this.mess, required this.action})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Dialog(
      elevation: 5,
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(20))),
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            SvgPicture.asset("assets/canh_bao.svg"),
            const SizedBox(
              height: 20,
            ),
            Text(
              mess,
              style: const TextStyle(fontWeight: FontWeight.w500),
              textAlign: TextAlign.center,
            ),
            const SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Expanded(
                  child: SizedBox(
                    height: 48,
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.white,
                        side: const BorderSide(color: Palette.blue, width: 1),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15),
                        ),
                      ),
                      child: Text(
                        "Đóng",
                        style: AppFont.t.blue,
                      ),
                    ),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}

class DialogLogin extends StatelessWidget {
  final VoidCallback? action;
  final String mess;

  const DialogLogin({Key? key, required this.action, required this.mess})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 15),
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(10)),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          BoxConst.s8,
          Text(
            mess,
            style: const TextStyle(fontWeight: FontWeight.w500),
            textAlign: TextAlign.center,
          ),
          BoxConst.s20,
          SizedBox(
            width: context.w() / 1.5,
            height: 48,
            child: ElevatedButton(
              onPressed: action,
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.white,
                side: const BorderSide(color: Palette.blue, width: 1),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
              ),
              child: Text(
                "Đăng nhập",
                style: AppFont.t.blue,
              ),
            ),
          ),
          BoxConst.s8
        ],
      ),
    );
  }
}

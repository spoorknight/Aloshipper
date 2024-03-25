import 'package:app_shipper/src/features/detail_order/widgets/dialog_fee_service.dart';
import 'package:app_shipper/src/models/detail_order_model/detail_order_model.dart';
import 'package:app_shipper/src/utils/extensions/extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../configs/config.dart';
import '../show_toast.dart';

class RowContent extends StatelessWidget {
  const RowContent({
    Key? key,
    this.title,
    this.content,
    this.styleContent,
    this.styleTitle,
    this.order,
    this.showCopy = false,
    this.isFeeService = false,
  }) : super(key: key);

  final String? title;
  final String? content;
  final TextStyle? styleContent;
  final TextStyle? styleTitle;
  final bool showCopy;
  final bool isFeeService;
  final DetailOrderModel? order;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Expanded(
          child: Row(
            children: [
              Text(
                title ?? '',
                style: styleTitle ?? AppFont.t,
              ),
              isFeeService == false ? const SizedBox()
                  : InkWell(
                  onTap: () =>order == null ? null :
                  showDialog(context: context, builder: (context)
                  => Padding(
                      padding: AppTheme.mainPadding,
                      child: DialogServiceFee(order: order!)),),
                  child: Assets.svgs.icInfo.svg())
            ],
          ),
        ),
        Expanded(
          child: Text(
            content ?? '',
            textAlign: TextAlign.right,
            style: styleContent ?? AppFont.t.w700,
          ),
        ),
        if (showCopy)
          Padding(
            padding: const EdgeInsets.only(left: 10),
            child: InkWell(
              onTap: () async {
                await Clipboard.setData(
                  ClipboardData(text: content?.removeComma ?? ''),
                );
                ShowToast.success(
                    'Sao chép thành công\nNội dung: ${content?.removeComma}');
              },
              child: const Icon(
                Icons.copy_rounded,
                size: 20,
              ),
            ),
          )
      ],
    );
  }
}

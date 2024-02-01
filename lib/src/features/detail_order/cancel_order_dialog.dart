import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../configs/config.dart';
import '../../shared/button.dart';
import '../../shared/text_form_field.dart';
import '../../utils/helpers/logger.dart';
import 'detail_order_view_model.dart';

class CancelOrderDialog extends StatefulWidget {
  const CancelOrderDialog({
    Key? key,
    required this.viewModel,
  }) : super(key: key);

  final DetailOrderViewModel viewModel;

  @override
  State<CancelOrderDialog> createState() => _CancelOrderDialogState();
}

class _CancelOrderDialogState extends State<CancelOrderDialog> {
  TextEditingController cancelReasonCtl = TextEditingController();
  bool isValidBtnCancel = false;

  @override
  void initState() {
    super.initState();
    cancelReasonCtl.addListener(checkValidBtnCancel);
  }

  void checkValidBtnCancel() {
    if (cancelReasonCtl.text.isNotEmpty) {
      isValidBtnCancel = true;
    } else {
      isValidBtnCancel = false;
    }
    Logger.d('btn valid', isValidBtnCancel);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider.value(
      value: widget.viewModel,
      child: Dialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(4),
        ),
        insetPadding: const EdgeInsets.symmetric(horizontal: 16),
        child: SizedBox(
          width: double.infinity,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              BoxConst.s8,
              Text('Huỷ đơn', style: AppFont.t.s(18).red),
              const Divider(color: Palette.grey),
              BoxConst.s16,
              Padding(
                padding: AppTheme.mainPadding,
                child: CustomTextFormField(
                  title: 'Lý do huỷ đơn',
                  controller: cancelReasonCtl,
                ),
              ),
              BoxConst.s20,
              MyButton(
                title: 'Xác nhận',
                borderRadius: 4,
                action: isValidBtnCancel
                    ? () => widget.viewModel.cancelOrder(cancelReasonCtl.text)
                    : null,
              )
            ],
          ),
        ),
      ),
    );
  }
}

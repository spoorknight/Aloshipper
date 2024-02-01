import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../configs/config.dart';
import '../../../shared/button.dart';
import '../../../shared/text_form_field.dart';
import 'item_extend.dart';

class ModalExtend extends StatelessWidget {
  const ModalExtend({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        BoxConst.s8,
        Text('Gia hạn', style: AppFont.t.s(18).red),
        const Divider(color: Palette.grey),
        BoxConst.s16,
        Padding(
          padding: AppTheme.mainPadding,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const CustomTextFormField(
                title: 'Số tiền cần thanh toán',
                centerTitle: true,
              ),
              BoxConst.s16,
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                   Text('Chọn gói', style: AppFont.t),
                  Column(
                    children: [
                      CupertinoSwitch(value: true, onChanged: (v) {}),
                       Text(
                        'Gia hạn tự động',
                        style: AppFont.t.s(12),
                      ),
                    ],
                  )
                ],
              ),
              BoxConst.s24,
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: const [
                  ItemExtend(isSelected: true),
                  ItemExtend(),
                  ItemExtend(),
                ],
              ),
              BoxConst.s16,
              Text.rich(
                TextSpan(
                  children: [
                     TextSpan(
                      text: 'Thời gian còn lại: ',
                      style: AppFont.t,
                    ),
                    TextSpan(
                      text: '20 ngày',
                      style: AppFont.t.red,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        BoxConst.s16,
        MyButton(title: 'Xác nhận', action: () {})
      ],
    );
  }
}

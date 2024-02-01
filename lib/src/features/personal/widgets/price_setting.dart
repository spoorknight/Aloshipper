import 'package:flutter/material.dart';

import '../../../configs/config.dart';
import '../../../shared/button.dart';
import '../../../shared/text_form_field.dart';

class PriceSetting extends StatelessWidget {
  final String title;
  const PriceSetting({
    Key? key,
    required this.title,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Dialog(
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
            Text('Cài đặt phí $title', style: AppFont.t.s(18).red),
            const Divider(color: Palette.grey),
            BoxConst.s16,
            const Padding(
              padding: AppTheme.mainPadding,
              child: CustomTextFormField(
                title: 'Nhập giá cước mong muốn',
              ),
            ),
            BoxConst.s16,
            Padding(
              padding: AppTheme.mainPadding,
              child: Text.rich(
                TextSpan(
                  children: [
                    TextSpan(
                      text: 'Lưu ý: ',
                      style: AppFont.t.red,
                    ),
                    TextSpan(
                      text:
                          'Phí $title sẽ ảnh hưởng tới việc nhận đơn từ khách hàng.',
                      style: AppFont.t,
                    ),
                  ],
                ),
              ),
            ),
            BoxConst.s16,
            MyButton(
              title: 'Xác nhận',
              borderRadius: 4,
              action: () {
                Navigator.pop(context);
              },
            )
          ],
        ),
      ),
    );
  }
}

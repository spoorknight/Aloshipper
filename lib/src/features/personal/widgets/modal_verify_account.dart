import 'package:flutter/material.dart';

import '../../../configs/config.dart';
import '../../../shared/button.dart';
import '../../../shared/text_form_field.dart';
import 'modal_update_info.dart';

class ModalVerifyAccount extends StatelessWidget {
  const ModalVerifyAccount({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Palette.transparent,
      resizeToAvoidBottomInset: true,
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  BoxConst.s8,
                  Text('Xác thực tài khoản', style: AppFont.t.s(18).red),
                  const Divider(color: Palette.grey),
                  const RowContent2(
                    title: 'Họ và tên',
                    child: CustomTextFormField(
                      height: 40,
                    ),
                  ),
                  const Divider(color: Palette.grey),
                  const RowContent2(
                    title: 'Số điện thoại',
                    child: CustomTextFormField(
                      height: 40,
                    ),
                  ),
                  const Divider(color: Palette.grey),
                  const RowContent2(
                    title: 'Loại xe',
                    child: CustomTextFormField(
                      height: 40,
                    ),
                  ),
                  const Divider(color: Palette.grey),
                  const RowContent2(
                    title: 'Biển số xe',
                    child: CustomTextFormField(
                      height: 40,
                    ),
                  ),
                  const Divider(color: Palette.grey),
                  BoxConst.s8,
                  const Align(
                    alignment: Alignment.centerLeft,
                    child: Padding(
                      padding: AppTheme.mainPadding,
                      child: Text('Chụp ảnh'),
                    ),
                  ),
                  BoxConst.s8,
                  SizedBox(
                    height: 0.3.sw,
                    child: GridView(
                      padding: AppTheme.mainPadding,
                      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 5,
                        mainAxisSpacing: 5,
                        childAspectRatio: 1 / 2,
                        crossAxisSpacing: 5,
                      ),
                      children: [
                        'Mặt trước CCCD',
                        'Mặt sau CCCD',
                        'Mặt trước GPLX',
                        'Mặt sau GPLX',
                        'Chân dung',
                      ]
                          .map(
                            (e) => Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Expanded(
                                  child: InkWell(
                                    onTap: () {},
                                    child: Container(
                                      height: 50,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10),
                                        border: Border.all(color: Palette.grey),
                                      ),
                                      child: const Center(
                                        child: Icon(Icons.camera_alt, size: 24),
                                      ),
                                    ),
                                  ),
                                ),
                                Expanded(
                                  child: Text(
                                    e,
                                    style: AppFont.t.s(12),
                                    textAlign: TextAlign.center,
                                  ),
                                )
                              ],
                            ),
                          )
                          .toList(),
                    ),
                  ),
                  const Padding(
                    padding: AppTheme.mainPadding,
                    child: Text(
                      'Bạn phải cam kết tuân thủ các quy định của pháp luật và các thông tin hoàn toàn là chính xác',
                    ),
                  ),
                ],
              ),
            ),
          ),
          MyButton(title: 'Gửi duyệt', action: () {}),
        ],
      ),
    );
  }
}

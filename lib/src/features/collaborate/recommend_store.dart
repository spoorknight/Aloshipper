import 'package:flutter/material.dart';
import 'package:tuple/tuple.dart';

import '../../configs/config.dart';
import '../../shared/app_bar.dart';
import '../../shared/dropdown.dart';
import '../../shared/my_scaffold.dart';
import '../../shared/text_form_field.dart';

class RecommendStore extends StatelessWidget {
  const RecommendStore({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MyScaffold(
      padding: EdgeInsets.zero,
      appBar: const MyAppBar(title: 'Danh sách store'),
      body: Column(
        children: [
          BoxConst.s16,
          Padding(
            padding: AppTheme.mainPadding,
            child: Row(
              children: [
                Expanded(
                  child: Row(
                    children: [
                      Text('Ngày', style: AppFont.t),
                      BoxConst.s8,
                      Expanded(
                          child: CustomTextFormField(
                        height: 36,
                        width: 0.3.sw,
                      ))
                    ],
                  ),
                ),
                BoxConst.s12,
                Expanded(
                  child: Row(
                    children: [
                      Text('Trạng thái', style: AppFont.t),
                      BoxConst.s8,
                      const Expanded(
                        child: DropDownTuple2(
                          height: 36,
                          isBorder: true,
                          isExpanded: true,
                          listItem: [
                            Tuple2('Tất cả', '1'),
                          ],
                          value: '1',
                        ),
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
          const Divider(),
          Expanded(
            child: ListView.separated(
              padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
              itemCount: 8,
              separatorBuilder: (_, i) => const Divider(),
              itemBuilder: (_, i) => const _ItemStore(),
            ),
          ),
        ],
      ),
    );
  }
}

class _ItemStore extends StatelessWidget {
  const _ItemStore({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          flex: 2,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text.rich(
                TextSpan(
                  text: 'Store: ',
                  style: AppFont.t,
                  children: [
                    TextSpan(
                      text: 'Trà sữa NOW',
                      style: AppFont.t.red,
                    ),
                  ],
                ),
              ),
              Text(
                'Gia hạn lúc: 14:00 - 30/05/2022',
                style: AppFont.t.s(12).hint,
              ),
              Text(
                'Đăng ký lúc: 10:00 - 25/04/2022',
                style: AppFont.t.s(12).hint,
              ),
            ],
          ),
        ),
        Expanded(
          child: Text(
            'Hoàn thành',
            style: AppFont.t.green,
            textAlign: TextAlign.end,
          ),
        ),
        Expanded(
          child: Text(
            '+ 5,000 đ',
            style: AppFont.t.green,
            textAlign: TextAlign.end,
          ),
        ),
      ],
    );
  }
}

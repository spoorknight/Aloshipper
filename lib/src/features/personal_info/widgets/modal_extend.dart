import 'package:app_shipper/src/di/injection/injection.dart';
import 'package:app_shipper/src/features/profile/profile_view_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../configs/config.dart';
import '../../../models/profile_model.dart';
import '../../../shared/button.dart';
import '../../../shared/text_form_field.dart';
import 'item_extend.dart';

class ModalExtend extends StatelessWidget {
  const ModalExtend({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final viewModel = context.watch<ProfileViewModel>();
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
              CustomTextFormField(
                centerTitle: true,
                controller: viewModel.soTienCanThanhToanEC,
                title: "Số tiền cần thanh toán",
                textAlign: TextAlign.center,
                readOnly: true,
              ),
              BoxConst.s16,
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Chọn gói', style: AppFont.t),
                  Column(
                    children: [
                      StreamBuilder<ProfileModel?>(
                          stream: appData.profile,
                          builder: (context, profile) {
                            return CupertinoSwitch(
                              value:
                                  profile.data?.item?.user?.giaHanTuDong == '1',
                              onChanged: viewModel.autoGiaHan,
                            );
                          }),
                      Text(
                        'Gia hạn tự động',
                        style: AppFont.t.s(12),
                      ),
                    ],
                  )
                ],
              ),
              BoxConst.s12,
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Wrap(
                  children: [
                    ...viewModel.listService.map(
                      (e) => InkWell(
                        onTap: () => viewModel.onSelectPlan(e),
                        child: Padding(
                          padding: EdgeInsets.only(right: 12.w, top: 10.w),
                          child: ItemExtend(
                            service: e,
                            isSelected: e.id == viewModel.selectedPlanId,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              BoxConst.s16,
              StreamBuilder<ProfileModel?>(
                  stream: appData.profile,
                  builder: (context, profile) {
                    return Text.rich(
                      TextSpan(
                        children: [
                          TextSpan(
                            text: 'Thời gian còn lại: ',
                            style: AppFont.t,
                          ),
                          TextSpan(
                            text:
                                '${profile.data?.plan?.numberOfDays ?? 0} ngày',
                            style: AppFont.t.red,
                          ),
                        ],
                      ),
                    );
                  }),
            ],
          ),
        ),
        BoxConst.s16,
        // MyButton(
        //   title: 'Xác nhận',
        //   action: viewModel.thanhToanGoiDichVu,
        // )
      ],
    );
  }
}

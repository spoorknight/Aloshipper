import 'package:app_shipper/src/utils/extensions/extensions.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../configs/config.dart';
import '../../../di/injection/injection.dart';
import '../../../navigator/app_navigator.dart';
import '../../../shared/button.dart';
import '../../../utils/app_enum.dart';
import '../event_view_model.dart';
import 'message_success_widget.dart';

class TransferMoneyWidget extends StatefulWidget {
  const TransferMoneyWidget({super.key});

  @override
  State<TransferMoneyWidget> createState() => _TransferMoneyWidgetState();
}

class _TransferMoneyWidgetState extends State<TransferMoneyWidget> {
  int indexSelected = 0;
  ExchangeType type = ExchangeType.money;
  List<int> lstValuePrice = [1000, 10000, 100000, 500000];
  List<int> lstValueDate = [1, 7, 14, 30];

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 10.w, horizontal: 10.w),
      decoration: BoxDecoration(
        color: Palette.white,
        borderRadius: BorderRadius.circular(8.r),
      ),
      child: Consumer<EventViewModel>(builder: (context, viewModel, _) {
        ///tính số điểm cần ứng với số tiền để đổi
        double pointNeedToChange = 0;

        if (type == ExchangeType.money) {
          pointNeedToChange = (lstValuePrice[indexSelected] *
              (viewModel.customerPointInfoModel?.getRatioPointToChangeMoney ??
                  0));
        }
        if (type == ExchangeType.day) {
          pointNeedToChange = ((lstValueDate[indexSelected] * 24) *
              (viewModel.customerPointInfoModel?.getRatioPointToChangeDay ??
                  0));
        }

        ///số điểm hiện tại phải >= số đểm muốn đổi
        bool isEnoughMoney = viewModel.customerPointInfoLoading
            ? false
            : (viewModel.customerPointInfoModel?.getUserCurrentPoints ?? 0) >=
            pointNeedToChange;

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(
                  'Quy đổi',
                  style: AppFont.t.s(14).w700.black,
                ),
                Row(
                  children: [
                    Text(
                      ' = ${pointNeedToChange.toString().formatNumber}',
                      style: AppFont.t.s(14).w700.black,
                    ),
                    BoxConst.s4,
                    Assets.svgs.coin.svg(width: 16.w, height: 16.w),
                  ],
                ),
              ],
            ),
            BoxConst.s16,
            Text(
              'Tiền thưởng',
              style: AppFont.t.s(13).w500.black,
            ),
            BoxConst.s4,
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  for (var index = 0; index < lstValuePrice.length; index++)
                    renderPrice(
                      lstValuePrice[index].toString().toVnd,
                      isSelected: index == indexSelected &&
                          type == ExchangeType.money,
                      onTap: () {
                        setState(() {
                          indexSelected = index;
                          type = ExchangeType.money;
                        });
                      },
                    )
                ],
              ),
            ),
            if (appData.checkIsShipperOrStore) ...[
              BoxConst.s16,
              Text(
                'Thời gian sử dụng',
                style: AppFont.t.s(13).w500.black,
              ),
              BoxConst.s4,
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: [
                    for (var index = 0; index < lstValueDate.length; index++)
                      renderDate(
                        lstValueDate[index].toString(),
                        isSelected: index == indexSelected &&
                            type == ExchangeType.day,
                        onTap: () {
                          setState(() {
                            indexSelected = index;
                            type = ExchangeType.day;
                          });
                        },
                      )
                  ],
                ),
              ),
            ],
            BoxConst.s16,
            MyButton.rounded(
              title: 'Xác nhận',
              borderRadius: 8.r,
              color: isEnoughMoney ? Palette.primary : Palette.grey,
              titleStyle: AppFont.t.s(14).w700.white,
              action: isEnoughMoney
                  ? () async {
                // final res = await viewModel.exchangePointsToMoney(
                //     lstValuePrice[indexSelectedPrice].toString());

                final res = await viewModel.exchangePointsToMoney(
                    value: type == ExchangeType.money
                        ? lstValuePrice[indexSelected]
                        : lstValueDate[indexSelected],
                    type: type);

                if (res == true) {
                  showDialog(
                    context: AppNavigator.navigatorKey.currentContext!,
                    builder: (builder) {
                      return const MessageSuccessWidget();
                    },
                  ).then((value) => viewModel.initData());
                }
              }
                  : null,
            ),
            BoxConst.s16,
            Text(
              'Để đổi ${type == ExchangeType.money ? 'điểm' : 'ngày'}, bạn cần có tối thiểu ${pointNeedToChange.toString().toPoint}, Giới hạn đổi điểm có thể thay đổi tùy theo từng thời điểm.',
              style: AppFont.t.s(12).w400.black,
              textAlign: TextAlign.center,
            ),
          ],
        );
      }),
    );
  }

  Widget renderPrice(
    String title, {
    Function()? onTap,
    bool isSelected = false,
  }) {
    return Container(
      margin: EdgeInsets.only(right: 8.w),
      child: InkWell(
        onTap: onTap,
        child: Container(
          width: 77.w,
          padding: EdgeInsets.symmetric(vertical: 22.w),
          margin: EdgeInsets.only(top: 8.w),
          decoration: BoxDecoration(
            color:
                isSelected ? const Color(0xFFF8EDF0) : const Color(0xFFEAEAEC),
            borderRadius: BorderRadius.circular(6.r),
            border: Border.all(
              width: 1,
              color: isSelected ? Palette.error : const Color(0xFFEAEAEC),
            ),
          ),
          child: Text(
            title,
            style: AppFont.t.s(13).w500.black,
            textAlign: TextAlign.center,
          ),
        ),
      ),
    );
  }

  Widget renderDate(
    String title, {
    Function()? onTap,
    bool isSelected = false,
  }) {
    return Container(
      margin: EdgeInsets.only(right: 8.w),
      child: InkWell(
        onTap: onTap,
        child: Container(
          width: 77.w,
          padding: EdgeInsets.symmetric(vertical: 22.w),
          margin: EdgeInsets.only(top: 8.w),
          decoration: BoxDecoration(
            color:
                isSelected ? const Color(0xFFF8EDF0) : const Color(0xFFEAEAEC),
            borderRadius: BorderRadius.circular(6.r),
            border: Border.all(
              width: 1,
              color: isSelected ? Palette.error : const Color(0xFFEAEAEC),
            ),
          ),
          child: Column(
            children: [
              Text(
                '$title Ngày',
                style: AppFont.t.s(13).w500.black,
                textAlign: TextAlign.center,
              ),
              BoxConst.s4,
              Text(
                'Sử dụng dịch vụ',
                style: AppFont.t.s(8).w500.black,
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

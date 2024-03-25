
import 'package:app_shipper/src/models/detail_order_model/detail_order_model.dart';
import 'package:app_shipper/src/navigator/app_navigator.dart';
import 'package:app_shipper/src/utils/extensions/context_extension.dart';
import 'package:app_shipper/src/utils/extensions/extensions.dart';
import 'package:flutter/material.dart';

import '../../../configs/config.dart';

class DialogServiceFee extends StatelessWidget {
  DetailOrderModel order;
  DialogServiceFee({super.key,required this.order});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        padding: AppTheme.mainPadding,
        decoration: AppTheme.boxDecoration.copyWith(
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(10),
                  topRight: Radius.circular(10),
                )
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            BoxConst.s8,
            Text("Phí áp dụng",style: AppFont.t.s(15).black.w600,),
            BoxConst.s8,
            _rowContent(title:"Phí giao hàng",fee: order.item?.phiship),
            Wrap(
              runSpacing: 5,
              children: order.item?.shipServiceFeeInfo?.map((e) {
                return _rowContent(title: e.title,fee: double.parse(e.fee ?? '0'),des: e.description);
              }).toList() ?? [],
            ),
            BoxConst.s8,
            InkWell(
              onTap: () => AppNavigator.pop(),
              child: Container(
                width: context.device.width/2,
                padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 5),
                decoration: BoxDecoration(
                  color: Palette.red,
                  borderRadius: BorderRadius.circular(20.r),
                ),
                child: Center(
                  child:  Text(
                    "Tôi đã hiểu",
                    style: AppFont.t.s(14).white,
                  ),
                ),
              ),
            ),
            BoxConst.s8,
          ],
        ),
      ),
    );
  }

  Widget _rowContent({String? title,double? fee,String? des}) {
    return Column(
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(title ?? "",style: AppFont.t.s(14).black.w500,),
            Text('$fee'.toVnd,style: AppFont.t.s(14).black.w500,),
          ],
        ),
        (des?.isEmpty??false) ? SizedBox() : Padding(
          padding: const EdgeInsets.only(top: 5),
          child: Text(des ?? "",style: AppFont.t.s(14).nuatral50,),
        ),
      ],
    );
  }
}

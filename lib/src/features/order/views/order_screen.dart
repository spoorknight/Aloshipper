import 'package:app_shipper/src/di/injection/injection.dart';
import 'package:app_shipper/src/features/order/views/order_view_model.dart';
import 'package:app_shipper/src/features/statistic/widgets/item_order.dart';
import 'package:app_shipper/src/models/list_order_model/order_firebase_model.dart';
import 'package:app_shipper/src/models/profile_model.dart';
import 'package:app_shipper/src/navigator/routes.dart';
import 'package:app_shipper/src/shared/my_scaffold.dart';
import 'package:app_shipper/src/utils/constants.dart';
import 'package:app_shipper/src/utils/extensions/extensions.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../configs/config.dart';
import '../../../shared/loading.dart';

class OrderScreen extends StatefulWidget {
  const OrderScreen({Key? key}) : super(key: key);

  @override
  State<OrderScreen> createState() => _OrderScreenState();
}

class _OrderScreenState extends State<OrderScreen> {
  final FirebaseDatabase database = FirebaseDatabase.instance;

  @override
  void initState() {
    super.initState();
    shipperCollection.onValue.listen((event) {
      if (event.snapshot.value != null) {
        setState(() {
          isEmpty = false;
        });
      } else {
        setState(() {
          isEmpty = true;
        });
      }
    });
    appData.updateToaDo();
  }

  @override
  void setState(VoidCallback fn) {
    if (!mounted) return;
    super.setState(fn);
  }

  bool isEmpty = true;
  final shipperCollection = FirebaseDatabase.instance
      .ref(Constants.refOrderList)
      .orderByChild("shipper_id")
      .equalTo(appData.userId);

  @override
  Widget build(BuildContext context) {
    final viewModel = context.watch<OrderViewModel>();
    return viewModel.isLoading
        ? const Loading()
        : MyScaffold(
            padding: EdgeInsets.zero,
            bgColor: Palette.newLightGrey,
            appBar: AppBar(
              automaticallyImplyLeading: false,
              backgroundColor: Palette.red,
              centerTitle: true,
              title: Text(
                'Đơn hàng',
                style: AppFont.t.white,
              ),
              elevation: 0,
            ),
            body: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                renderTimeWork(),
                BoxConst.s4,
                Expanded(
                  child: checkBodyContent(),
                ),
                BoxConst.s8,
                renderBottomButton(),
              ],
            ),
          );
  }

  Widget checkBodyContent() {
    if (appData.isBan) {
      return Padding(
        padding: AppTheme.mainPadding,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Assets.svgs.rafikiBan.svg(width: context.w()),
            BoxConst.s12,
            Center(
                child: Text(
              "Tài khoản bị đã bị khóa vui lòng liên hệ 1900 866 844 để được hỗ trợ",
              style: AppFont.t.w700.s(14).nuatral50,
              textAlign: TextAlign.center,
            )),
          ],
        ),
      );
    }
    if (appData.isExpire) {
      return Padding(
        padding: AppTheme.mainPadding,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Assets.svgs.rafiki.svg(width: context.w()),
            BoxConst.s12,
            Center(
                child: Text(
              "Tài khoản của bạn đã hết hạn!\nVui lòng gia hạn để tiếp tục sử dụng dịch vụ",
              style: AppFont.t.w700.s(14).nuatral50,
              textAlign: TextAlign.center,
            )),
          ],
        ),
      );
    }
    if (isEmpty) {
      return Padding(
        padding: AppTheme.mainPadding,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Assets.svgs.shipperChibi.svg(width: context.w() / 1.2),
            BoxConst.s12,
            Center(
                child: Text(
              "Chưa có đơn hàng nào!",
              style: AppFont.t.w700.s(14).nuatral50,
            )),
          ],
        ),
      );
    }
    return FirebaseAnimatedList(
      padding: const EdgeInsets.only(bottom: 16, left: 16, right: 16, top: 10),
      itemBuilder: (BuildContext context, DataSnapshot snapshot,
          Animation<double> animation, int i) {
        OrderFirebaseModel item =
        OrderFirebaseModel.fromJson(snapshot.value);

        return ItemOrder(
          date: item.getDateCreate,
          time: item.getTime,
          orderNumber: item.orderNumber,
          orderId: item.orderId,
          storeName: item.getStoreName,
          type: item.type,
          status: item.statusText,
          countProduct: item.countItem?.toInt(),
          totalAmount: item.total?.toDouble(),
          paymentType: item.getStrPaymentMethod,
          colorStatus: item.getColorStatus,
          iconPayment: item.getIconPaymentType,
          resetTime: item.getResetTime.toInt(),
          updateAt: item.updateAt,
        );
      },
      query: shipperCollection,
    );
  }

  Widget renderBottomButton() {
    return Padding(
      padding: AppTheme.mainPadding,
      child: StreamBuilder<ProfileModel?>(
          stream: appData.profile,
          builder: (context, profile) {
            bool userIsActive =
                profile.data?.item?.user?.shopOnline == "1" ? true : false;
            return Column(
              children: [
                InkWell(
                  onTap: () async {
                    final value = await context
                        .read<OrderViewModel>()
                        .setOnlineActive(!userIsActive);
                    profile.data?.item?.user?.shopOnline =
                        (value == true) ? "1" : "0";
                    appData.autoUpdateLocation();
                  },
                  child: Container(
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    decoration: AppTheme.boxDecoration.copyWith(
                      color: userIsActive ? Palette.green00A64F : Palette.black,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        userIsActive
                            ? Assets.svgs.linkIos.svg(width: 30, height: 30)
                            : Assets.svgs.powerIos.svg(width: 30, height: 30),
                        BoxConst.s8,
                        Text(
                          userIsActive ? 'Đã kết nối' : 'Mở kết nối',
                          style: AppFont.t.s(13).w500.white,
                        ),
                      ],
                    ),
                  ),
                ),
                BoxConst.s8,
                Container(
                  padding:
                      const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                  decoration: AppTheme.boxDecoration.copyWith(
                    color: Palette.white,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Container(
                        width: 20,
                        height: 20,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(40),
                          color: userIsActive
                              ? Palette.green00A64F
                              : Palette.nuatral20,
                        ),
                      ),
                      BoxConst.s8,
                      Text(
                        userIsActive
                            ? 'Bạn đang ở chế độ Online'
                            : 'Bạn đang ở chế độ Offline.',
                        style: AppFont.t.s(12).w500.black,
                      ),
                    ],
                  ),
                ),
                BoxConst.s8,
              ],
            );
          }),
    );
  }

  Widget renderTimeWork() {
    return InkWell(
      onTap: () {
        Navigator.of(context).pushNamed(Routes.infoUserDriveScreen);
      },
      child: Container(
        padding: AppTheme.mainPadding.copyWith(top: 16, bottom: 16),
        decoration: AppTheme.boxDecoration.copyWith(
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(10.r),
            bottomRight: Radius.circular(10.r),
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  DateTime.now().toString().formatDate(),
                  style: AppFont.t.s(13).w500.nuatral90,
                ),
                Text(
                  'Thời gian đã hoạt động',
                  style: AppFont.t.s(13).w700.nuatral90,
                ),
              ],
            ),
            Row(
              children: [
                if (appData.userInfoActiveModel?.isEnoughTime ?? false)
                  Text(
                    'Đã hoàn thành',
                    style: AppFont.t.s(14).w700.green,
                  )
                else
                  Text(
                    '${appData.userInfoActiveModel?.getTotalHoursShipper ?? 0}h',
                    style: AppFont.t.s(16).w700.red,
                  ),
                BoxConst.s8,
                const Icon(
                  Icons.arrow_forward_ios_sharp,
                  size: 18,
                  color: Palette.nuatral90,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

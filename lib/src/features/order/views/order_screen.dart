import 'dart:async';

import 'package:app_shipper/src/di/injection/injection.dart';
import 'package:app_shipper/src/features/order/views/contact_view_model.dart';
import 'package:app_shipper/src/features/order/views/order_view_model.dart';
import 'package:app_shipper/src/features/statistic/widgets/item_order.dart';
import 'package:app_shipper/src/models/list_order_model/order_firebase_model.dart';
import 'package:app_shipper/src/models/profile_model.dart';
import 'package:app_shipper/src/navigator/app_navigator.dart';
import 'package:app_shipper/src/navigator/routes.dart';
import 'package:app_shipper/src/utils/constants.dart';
import 'package:app_shipper/src/utils/extensions/context_extension.dart';
import 'package:app_shipper/src/utils/extensions/extensions.dart';
import 'package:app_shipper/src/utils/utils.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:map4d_map/map4d_map.dart';
import 'package:provider/provider.dart';

import '../../../configs/config.dart';
import '../../../data/repositories/profile_repository.dart';
import '../../../models/support_model.dart';
import '../../../shared/loading.dart';
import '../../profile/profile_view_model.dart';

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
    Future.delayed(Duration.zero,() => showDialogInfo());
  }

  showDialogInfo(){
    if(appData.isBan){
      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) {
          return Padding(
            padding: const EdgeInsets.all(15),
            child: Center(
              child: Container(
                padding: AppTheme.mainPadding,
                decoration: AppTheme.boxDecoration.copyWith(borderRadius: BorderRadius.circular(10)),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Assets.svgs.rafikiBan.svg(),
                    BoxConst.s12,
                    Center(
                        child: Text(
                          "Tài khoản bị đã bị khóa vui lòng liên hệ ${appData.hotline} để được hỗ trợ",
                          style: AppFont.t.w700.s(14).nuatral50,
                          textAlign: TextAlign.center,
                        )),
                    BoxConst.s12,
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        InkWell(
                          onTap: () async {
                            AppNavigator.pop();
                          },
                          child: Container(
                              padding: const EdgeInsets.symmetric(vertical: 10,horizontal: 10),
                              child:Text(
                                'Để sau',
                                style: AppFont.t.s(13).w500.black,
                              )
                          ),
                        ),
                        BoxConst.s12,
                        InkWell(
                          onTap: () async {
                            Utils().launchPhone(appData.hotline);
                          },
                          child: Container(
                              padding: const EdgeInsets.symmetric(vertical: 10,horizontal: 10),
                              decoration: AppTheme.boxDecoration.copyWith(
                                color:  Palette.red,
                                borderRadius: BorderRadius.circular(5),
                              ),
                              child:Text(
                                'Liên hệ Support',
                                style: AppFont.t.s(13).w500.white,
                              )
                          ),
                        )
                      ],
                    ),
                    BoxConst.s12,
                  ],
                ),
              ),
            ),
          );
        },);
    }

    if(appData.isExpire){
      showDialog(
        context: context,
        barrierDismissible: false,
        useRootNavigator: true,
        builder: (context) {
        return  Padding(
          padding: const EdgeInsets.all(15.0),
          child: Center(
            child: Container(
              padding: AppTheme.mainPadding,
              decoration: AppTheme.boxDecoration.copyWith(borderRadius: BorderRadius.circular(10)),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Assets.svgs.rafiki.svg(width: context.device.width/1.5,height: context.device.width/1.5),
                  BoxConst.s12,
                  Center(
                      child: Text(
                        "Tài khoản của bạn đã hết hạn!\nVui lòng gia hạn để tiếp tục sử dụng dịch vụ",
                        style: AppFont.t.w700.s(14).nuatral50,
                        textAlign: TextAlign.center,
                      )),
                  BoxConst.s12,
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      InkWell(
                        onTap: () async {
                          AppNavigator.pop();
                        },
                        child: Container(
                            padding: const EdgeInsets.symmetric(vertical: 10,horizontal: 10),
                            child:Text(
                              'Để sau',
                              style: AppFont.t.s(13).w500.black,
                            )
                        ),
                      ),
                      BoxConst.s12,
                      InkWell(
                        onTap: () async {
                          AppNavigator.pop();
                          AppNavigator.push(Routes.extendScreen,arguments: {
                            'profileViewModel': ProfileViewModel(profileRepo: getIt<ProfileRepository>()),
                          });
                        },
                        child: Container(
                            padding: const EdgeInsets.symmetric(vertical: 10,horizontal: 10),
                            decoration: AppTheme.boxDecoration.copyWith(
                              color:  Palette.red,
                              borderRadius: BorderRadius.circular(5),
                            ),
                            child:Text(
                              'Gia hạn tài khoản',
                              style: AppFont.t.s(13).w500.white,
                            )
                        ),
                      )
                    ],
                  ),
                  BoxConst.s12,
                ],
              ),
            ),
          ),
        );
      },);
    }
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
    final viewModelContact = context.watch<ContactViewModel>();
    return viewModel.isLoading
        ? const Loading()
        :  Stack(
      children: [
        MFMapView(
          mapType: viewModel.mapType,
          poisEnabled: false,
          initialCameraPosition: viewModel.shopNearYou.isNotEmpty
              ? MFCameraPosition(
            target: MFLatLng(
              double.parse(viewModel.shopNearYou.first.latitude ?? '0'),
              double.parse(viewModel.shopNearYou.first.longitude ?? '0'),
            ),
            zoom: 14,
          )
              : MFCameraPosition(
            target: MFLatLng(
              appData.myCurrentAddress?.latitude ?? 0,
              appData.myCurrentAddress?.longitude ?? 0,
            ),
            zoom: 14,
          ),
          onMapCreated: viewModel.onMapCreated,
          markers: Set<MFMarker>.of(viewModel.markers),
          gestureRecognizers: {
            Factory<OneSequenceGestureRecognizer>(
                    () => EagerGestureRecognizer())
          },
        ),
        Positioned(
            top: 0,
            left: 0,
            right: 0,
            bottom: 0,
            child: Center(child: checkBodyContent())),

        Positioned(
          right: 20,
          bottom: 120,
          child: supportContact(viewModelContact),),
        Positioned(
            top: 30,
            left: 10,
            child: renderTimeWork()),
        Positioned(
            left: 0,
            right: 0,
            bottom: 0,
            child: renderBottomButton(viewModel)
        )
      ],
    );
  }

  Widget checkBodyContent() {
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




  Widget supportContact (ContactViewModel viewModelContact){
    return  Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        if(viewModelContact.showButtonContact)Stack(
          children: [
            GestureDetector(
              onTap: () {
                viewModelContact.hideFloatingButtons();
              },
              child: Container(
                color: Colors.black54,
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                _renderCircle(
                    onTap: () {
                      Utils().launchMessenger(appData.messId);
                      viewModelContact.hideFloatingButtons();
                    },
                    child: Assets.svgs.support.facebook
                        .svg(width: 30, height: 30),
                    title: "Messenger"),
                BoxConst.s16,
                _renderCircle(
                    onTap: () {
                      Utils().launchPhone(appData.zaloPhone);
                      viewModelContact.hideFloatingButtons();
                    },
                    child: Assets.svgs.support.zalo
                        .svg(width: 30, height: 30),
                    title: "Zalo"),
                BoxConst.s16,
                _renderCircle(
                    onTap: () {
                      Utils().launchPhone(appData.hotline);
                      viewModelContact.hideFloatingButtons();
                    },
                    child: Assets.svgs.phone
                        .svg(width: 30, height: 30),
                    title: "Hotline"),
                // Box.s16,
                // _renderCircle(
                //     onTap: () {
                //       hideFloatingButtons();
                //       Navigator.of(context)
                //           .pushNamed(Routes.contributeScreen);
                //     },
                //     child: Assets.svgs.support.chat
                //         .svg(width: 30, height: 30),
                //     title: "Đóng góp"),
                BoxConst.s16,

              ],
            )
          ],
        ),
        _renderFloatButton(viewModelContact),
      ],
    );
  }

  Widget renderBottomButton(OrderViewModel viewModel) {
    return Padding(
      padding: AppTheme.mainPadding,
      child: StreamBuilder<ProfileModel?>(
          stream: appData.profile,
          builder: (context, profile) {
            bool userIsActive =
                profile.data?.item?.user?.shopOnline == "1" ? true : false;
            return Column(
              children: [
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
                Row(
                  children: [
                    Expanded(
                      flex: 4,
                      child: InkWell(
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
                            color: userIsActive ? Palette.green00D566 : Palette.black,
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
                    ),
                    BoxConst.s8,
                    Expanded(
                      flex: 3,
                      child: InkWell(
                        onTap: () async {
                          appData.updateToaDo();
                          viewModel.drawCurrentLocation();
                          EasyLoading.showSuccess("Cập nhập vị trí thành công");
                        },
                        child: Container(
                          padding: const EdgeInsets.symmetric(vertical: 10,horizontal: 2),
                          decoration: AppTheme.boxDecoration.copyWith(
                            color:  Palette.nuatral90,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                'Cập nhật vị trí',
                                style: AppFont.t.s(13).w500.white,
                              ),
                              BoxConst.s8,
                              Assets.svgs.icCicular.svg(width: 30, height: 30,color: Palette.green00D566),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
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
        padding: AppTheme.mainPadding.copyWith(top: 5, bottom: 5),
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
                  'Thời gian đã hoạt động',
                  style: AppFont.t.s(13).w500.nuatral90,
                ),
                BoxConst.s4,

                if (appData.userInfoActiveModel?.isEnoughTime ?? false)
                Text(
                  'Đã hoàn thành',
                  style: AppFont.t.s(14).w600.green,
                )
                else
                  Text(
                    DateTime.now().toString().formatDate(),
                    style: AppFont.t.s(13).w300.nuatral90,
                  ),
              ],
            ),
            BoxConst.s8,
            Row(
              children: [
                if (appData.userInfoActiveModel?.isEnoughTime ?? false)
                Assets.svgs.icSuccess.svg()
                else
                  Text(
                    '${appData.userInfoActiveModel?.getTotalHoursShipper ?? 0}h',
                    style: AppFont.t.s(16).w700.red,
                  ),

              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _renderFloatButton(ContactViewModel viewModel) {
    return AnimatedOpacity(
        duration: const Duration(milliseconds: 800),
        opacity: viewModel.showButtonContact ? 0.4 : 1,
        child: _renderCircle(
          onTap: () =>viewModel.showButtonContact ? viewModel.hideFloatingButtons() : viewModel.showFloatingButtons(),
          child: Assets.svgs.support.support
              .svg(width: 60, height: 60),
        )
    );
  }

  Widget _renderCircle(
      {Function()? onTap, Widget? child, String? title, double? radius}) {
    return InkWell(
      onTap: onTap,
      child: Row(
        children: [
          if (title != null) ...[
            Text(
              title,
              style: AppFont.t.s(13).black.w700,
            ),
            BoxConst.s8,
          ],
          CircleAvatar(
            backgroundColor: Palette.white,
            radius: radius ?? 25,
            child: child,
          ),
        ],
      ),
    );
  }
}

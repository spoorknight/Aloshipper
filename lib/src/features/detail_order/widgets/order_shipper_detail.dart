part of '../detail_driver_order.dart';

class OrderShipperDetail extends StatefulWidget {
  const OrderShipperDetail({super.key, this.resetTime});

  final int? resetTime;

  @override
  State<OrderShipperDetail> createState() => _OrderShipperDetailState();
}

class _OrderShipperDetailState extends State<OrderShipperDetail> {
  int _start = 0;
  final oneSec = const Duration(seconds: 1);

  final shipperCallCustomerModel = ShipperCallCustomerModel();

  @override
  void initState() {
    super.initState();
    _start = widget.resetTime ?? 0;
    Timer.periodic(
      oneSec,
      (Timer timer) {
        if (_start == 0) {
          setState(() {
            timer.cancel();
          });
        } else {
          setState(() {
            _start--;
          });
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final viewModel = context.watch<DetailOrderViewModel>();
    final order = viewModel.detailOrder?.item;
    if (order != null) {
      final checkPhoneExistCall = shipperCallCustomerModel
          .checkPhoneExist(order.shipping?.phoneNumber ?? '');
      if (checkPhoneExistCall &&
          order.getOrderStatus != OrderStatusEnum.shipper_confirm.name) {
        shipperCallCustomerModel.remove(order.id ?? '');
      }
    }
    return Column(
      children: [
        Expanded(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                BoxConst.s16,
                Padding(
                  padding: AppTheme.mainPadding,
                  child: Text(
                    'Bạn đang di chuyển đến',
                    style: AppFont.t.s(16).w700.nuatral90,
                  ),
                ),
                BoxConst.s4,
                Padding(
                  padding: AppTheme.mainPadding,
                  child: MapWidget(
                      addressFrom: order?.getShipFromStoreAddress ?? '',
                      addressTo: order?.getShipToStoreAddress ?? '',
                      handleNavigateFromAddress: () {
                        viewModel.openLinkGoogleMaps(
                          lat: '${order?.shipping?.fromLatitude ?? ''}',
                          long: '${order?.shipping?.fromLongitude ?? ''}',
                        );
                      },
                      handleNavigateToAddress: () {
                        viewModel.openLinkGoogleMaps(
                          lat: '${order?.shipping?.toLatitude ?? ''}',
                          long: '${order?.shipping?.toLongitude ?? ''}',
                        );
                      }),
                ),
                BoxConst.s16,
                BoxConst.s8,
                Padding(
                  padding: AppTheme.mainPadding,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Text(
                        'Chi tiết đơn hàng',
                        style: AppFont.t.s(16).w700.nuatral90,
                      ),
                      BoxConst.s8,
                      if (order?.shipper != null)
                        ItemDriver(
                          shipper: order!.shipper!,
                          distance: order.soKm,
                          fee: order.tongtien,
                          isCallDriver: true,
                          detailOrder: viewModel.detailOrder,
                        ),
                      if (order?.orderNote?.isNotEmpty == true) ...[
                        Container(
                          decoration: AppTheme.boxDecoration.copyWith(
                              borderRadius: BorderRadius.circular(10)),
                          margin: const EdgeInsets.only(top: 10, bottom: 10),
                          padding: const EdgeInsets.symmetric(
                              vertical: 10, horizontal: 15),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Ghi chú:',
                                style: AppFont.t.s(14).w400.black,
                              ),
                              Text(order?.orderNote ?? '', style: AppFont.t),
                            ],
                          ),
                        ),
                      ],
                      if (order?.paymentMethod != null) ...[
                        PaymentMethod(
                          order: order!,
                        ),
                      ],
                      if (order?.lydohuy?.isNotEmpty == true) ...[
                        Container(
                          decoration: AppTheme.boxDecoration.copyWith(
                              borderRadius: BorderRadius.circular(10)),
                          margin: const EdgeInsets.only(bottom: 10),
                          padding: const EdgeInsets.symmetric(
                              vertical: 10, horizontal: 15),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Lý do huỷ đơn:',
                                style: AppFont.t.s(14).w400.black,
                              ),
                              Text(order?.lydohuy ?? '', style: AppFont.t),
                            ],
                          ),
                        ),
                      ],
                    ],
                  ),
                ),
                renderCallForCustomer(
                    order?.shipping?.phoneNumber ?? '', order?.id ?? ''),
              ],
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            children: [
              Expanded(
                child: renderButton(),
              )
            ],
          ),
        ),
      ],
    );
  }

  Widget renderCallForCustomer(String phoneNumber, String orderId) {
    return Container(
      margin: AppTheme.mainPadding,
      padding: EdgeInsets.symmetric(horizontal: 10.sp, vertical: 10.sp),
      decoration: AppTheme.boxDecoration.copyWith(
        borderRadius: BorderRadius.circular(6.r),
      ),
      child: Row(
        children: [
          Expanded(
            child: InkWell(
              onTap: () async {
                await Utils().launchPhone(phoneNumber);
                shipperCallCustomerModel.saveCallInfo(
                    orderId: orderId, phoneNum: phoneNumber);
              },
              child: Row(
                children: [
                  Text.rich(
                    TextSpan(
                      text: 'Gọi khách hàng - ',
                      style: AppFont.t.s(13).w400.black,
                      children: [
                        TextSpan(
                          text: phoneNumber,
                        ),
                      ],
                    ),
                  ),
                  const Spacer(),
                  Assets.svgs.phoneGreen.svg(width: 16.sp, height: 16.sp),
                ],
              ),
            ),
          ),
          Container(
            height: 16.sp,
            margin: EdgeInsets.symmetric(horizontal: 12.sp),
            decoration: BoxDecoration(
                border: Border.all(color: Palette.nuatral50, width: 0.3.sp)),
          ),
          InkWell(
            onTap: () async {
              await Clipboard.setData(
                ClipboardData(text: phoneNumber),
              );
              ShowToast.success('Sao chép thành công');
            },
            child: Assets.svgs.copy.svg(width: 16.sp, height: 16.sp),
          ),
        ],
      ),
    );
  }

  Widget renderButton() {
    return Consumer<DetailOrderViewModel>(
      builder: (context, viewModel, _) {
        final order = viewModel.detailOrder?.item;

        if (order?.getOrderStatus == OrderStatusEnum.shipper_nhankhach.name) {
          return BaseButtonWidget(
            padding: EdgeInsets.symmetric(vertical: 12.sp),
            decoration: BoxDecoration(
              color: Palette.primary50,
              borderRadius: BorderRadius.circular(6.r),
            ),
            onTap: () {
              viewModel.updateStatus(OrderStatusEnum.shipper_dennoi.name);
              viewModel.updateLocation();
            },
            child: Text(
              'Hoàn thành',
              style: AppFont.t.s(14).w500.white,
            ),
          );
        }

        if (order?.getOrderStatus == OrderStatusEnum.shipper_confirm.name) {
          return ValueListenableBuilder<Box<ShipperCallCustomerModel>>(
              valueListenable: shipperCallCustomerAdapter.listenable(),
              builder: (context, box, _) {
                var checkIsCall = box.toMap().containsKey(order?.id);

                if (!checkIsCall) {
                  return BaseButtonWidget(
                    padding: EdgeInsets.symmetric(vertical: 12.sp),
                    decoration: BoxDecoration(
                      color: Palette.primary50,
                      borderRadius: BorderRadius.circular(6.r),
                    ),
                    onTap: () async {
                      await Utils()
                          .launchPhone(order?.shipping?.phoneNumber ?? '');
                      var data = ShipperCallCustomerModel()
                        ..orderId = order?.id
                        ..created = DateTime.now()
                        ..phoneNumber = order?.shipping?.phoneNumber ?? '';
                      box.put(order?.id, data);
                    },
                    child: Text(
                      'Gọi khách hàng',
                      style: AppFont.t.s(14).w500.white,
                    ),
                  );
                }
                return Row(
                  children: [
                    Expanded(
                      flex: 2,
                      child: BaseButtonWidget(
                        onTap: () async {
                          final res = await Navigator.of(context)
                              .pushNamed(Routes.cancelOrderScreen);
                          if (res == true) {
                            viewModel.getDetailOrder();
                          }
                        },
                        child: Text(
                          'Hủy đơn',
                          style: AppFont.t.s(14).w500.primary50,
                        ),
                      ),
                    ),
                    BoxConst.s8,
                    Expanded(
                      flex: 8,
                      child: BaseButtonWidget(
                        padding: EdgeInsets.symmetric(vertical: 12.sp),
                        decoration: BoxDecoration(
                          color: Palette.primary50,
                          borderRadius: BorderRadius.circular(6.r),
                        ),
                        onTap: () {
                          showDialog(
                            context: context,
                            builder: (context) {
                              return Dialog(
                                shape: const RoundedRectangleBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(8))),
                                elevation: 5,
                                child: Container(
                                  padding: const EdgeInsets.symmetric(
                                      vertical: 20, horizontal: 16),
                                  width:
                                      MediaQuery.of(context).size.width / 0.5,
                                  child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Text.rich(
                                        TextSpan(
                                            text:
                                                'Bạn đã đến địa chỉ đón khách hàng? ',
                                            style: AppFont.t.s(16).w700,
                                            children: [
                                              TextSpan(
                                                text:
                                                    'Chọn Xác nhận để tiếp tục chuyến đi.',
                                                style: AppFont.t.s(16).w400,
                                              ),
                                            ]),
                                      ),
                                      BoxConst.s16,
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.end,
                                        children: [
                                          MyTextButton(
                                            text: 'Đóng',
                                            action: AppNavigator.pop,
                                            style: AppFont.t.s(16).w500.primary,
                                          ),
                                          BoxConst.s8,
                                          MyTextButton(
                                            text: 'Xác nhận',
                                            style: AppFont.t.s(16).w500.primary,
                                            action: () {
                                              AppNavigator.pop();
                                              viewModel.updateStatus(
                                                  OrderStatusEnum
                                                      .shipper_nhankhach.name);
                                            },
                                          ),
                                        ],
                                      )
                                    ],
                                  ),
                                ),
                              );
                            },
                          );
                        },
                        child: Text(
                          'Đón khách',
                          style: AppFont.t.s(14).w500.white,
                        ),
                      ),
                    ),
                  ],
                );
              });
        }

        if (order?.getOrderStatus == OrderStatusEnum.wait_shipper.name) {
          return Row(
            children: [
              Expanded(
                child: BaseButtonWidget(
                  onTap: () async {
                    final res = await Navigator.of(context)
                        .pushNamed(Routes.cancelOrderScreen);
                    if (res == true) {
                      viewModel.getDetailOrder();
                    }
                  },
                  child: Text(
                    'Hủy đơn',
                    style: AppFont.t.s(14).w500.primary50,
                  ),
                ),
              ),
              BoxConst.s8,
              Expanded(
                child: BaseButtonWidget(
                  padding: EdgeInsets.symmetric(vertical: 12.sp),
                  decoration: BoxDecoration(
                    color: Palette.primary50,
                    borderRadius: BorderRadius.circular(6.r),
                  ),
                  onTap: () {
                    viewModel
                        .updateStatus(OrderStatusEnum.shipper_confirm.name);
                  },
                  child: Row(
                    children: [
                      Text(
                        'Xác nhận',
                        style: AppFont.t.s(14).w500.white,
                      ),
                      BoxConst.s8,
                      CircleAvatar(
                        radius: 14.r,
                        backgroundColor: Palette.primary70,
                        child: Text(
                          _start.toString(),
                          style: AppFont.t.s(12).w700.white,
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ],
          );
        }
        return const SizedBox();
      },
    );
  }
}

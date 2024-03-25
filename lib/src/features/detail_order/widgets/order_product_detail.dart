part of '../detail_driver_order.dart';

class OrderProductDetail extends StatefulWidget {
  const OrderProductDetail({super.key, this.resetTime});

  final int? resetTime;

  @override
  State<OrderProductDetail> createState() => _OrderProductDetailState();
}

class _OrderProductDetailState extends State<OrderProductDetail> {
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
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                BoxConst.s16,
                Padding(
                  padding: AppTheme.mainPadding,
                  child: Text(
                    'Thông tin địa chỉ giao',
                    style: AppFont.t.s(14).w700.nuatral90,
                  ),
                ),
                BoxConst.s8,
                Padding(
                  padding: AppTheme.mainPadding,
                  child: ValueListenableBuilder<Box<ShipperCallCustomerModel>>(
                      valueListenable: shipperCallCustomerAdapter.listenable(),
                      builder: (context, box, _) {
                        final isCallShop = box.toMap().containsKey(order?.id);
                        return MapWidget(
                            isShowMap: ([OrderStatusEnum.confirm.name]
                                        .contains(order?.getOrderStatus) &&
                                    isCallShop == true) ||
                                !([OrderStatusEnum.confirm.name]
                                    .contains(order?.getOrderStatus)),
                            titleFrom: 'Lấy tại: ${order?.getStoreName}',
                            titleTo: 'Giao đến',
                            addressFrom: order?.shop?.location ?? '',
                            addressTo: order?.getToStoreAddress ?? '',
                            handleNavigateFromAddress: () {
                              viewModel.openLinkGoogleMaps(
                                lat: order?.storeAddress?.storeLatitude ?? '',
                                long: order?.storeAddress?.storeLongitude ?? '',
                              );
                            },
                            handleNavigateToAddress: () {
                              viewModel.openLinkGoogleMaps(
                                lat: '${order?.shipping?.latitude ?? ''}',
                                long: '${order?.shipping?.longitude ?? ''}',
                              );
                            });
                      }),
                ),
                if (order?.getPaymentMethod == PaymentMethodEnum.cash) ...[
                  BoxConst.s8,
                  _renderDetailInCome(order),
                ],
                BoxConst.s8,
                Padding(
                  padding: AppTheme.mainPadding,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      BoxConst.s8,
                      Text(
                        'Chi tiết đơn hàng',
                        style: AppFont.t.s(14).w700.primary50.underline,
                      ),
                      BoxConst.s8,
                      Container(
                        decoration: AppTheme.boxDecoration
                            .copyWith(borderRadius: BorderRadius.circular(8)),
                        padding: const EdgeInsets.symmetric(
                            vertical: 12, horizontal: 10),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Wrap(children: [
                              for (var index = 0;
                                  index < (order?.products?.length ?? 0);
                                  index++)
                                ItemProduct(
                                  product: order!.products![index],
                                  index: index,
                                )
                            ]),
                            RowContent(
                              title: 'Tổng cộng',
                              content: '${order?.tienhang ?? 0}'.toVnd,
                              styleContent: AppFont.t.s(14).w400.black,
                              styleTitle: AppFont.t.s(14).w400.black,
                            ),
                            const Padding(
                              padding: EdgeInsets.symmetric(vertical: 10),
                              child:
                                  Divider(color: Palette.nuatral50, height: 1),
                            ),
                            RowContent(
                              title: 'Phí áp dụng',
                              isFeeService: true,
                              order: viewModel.detailOrder,
                              content: '${order?.getTotalFee(phiShip: order.phiship?? 0)}'.toVnd,
                              styleContent: AppFont.t.s(14).w400.black,
                              styleTitle: AppFont.t.s(14).w400.black,
                            ),
                            // RowContent(
                            //   title: 'Phí giao hàng',
                            //   content: '${order?.phiship ?? 0}'.toVnd,
                            //   styleContent: AppFont.t.s(14).w400.black,
                            //   styleTitle: AppFont.t.s(14).w400.black,
                            // ),
                            if (order?.getVoucherType != null) ...[
                              const Padding(
                                padding: EdgeInsets.symmetric(vertical: 10),
                                child: Divider(color: Palette.grey, height: 1),
                              ),
                              RowContent(
                                title: order?.getVoucherType ==
                                        VoucherType.freeShipping
                                    ? 'Voucher freeship'
                                    : 'Voucher giảm giá',
                                content: '${order?.giamgia ?? 0}'.toVnd,
                                styleContent: AppFont.t.s(14).w400.black,
                                styleTitle: AppFont.t.s(14).w400.black,
                              ),
                            ],
                            const Padding(
                              padding: EdgeInsets.symmetric(vertical: 10),
                              child:
                                  Divider(color: Palette.nuatral50, height: 1),
                            ),
                            RowContent(
                              title: 'Tổng thanh toán',
                              content: '${order?.tongtien ?? 0}'.toVnd,
                              styleContent: AppFont.t.s(14).w400.black,
                              styleTitle: AppFont.t.s(14).w400.black,
                            ),
                            if (order?.orderNote?.isNotEmpty == true) ...[
                              const Padding(
                                padding: EdgeInsets.symmetric(vertical: 10),
                                child: Divider(
                                    color: Palette.nuatral50, height: 1),
                              ),
                              Row(
                                children: [
                                  Text(
                                    'Ghi chú: ',
                                    style: AppFont.t.s(14).w400.black,
                                  ),
                                  Expanded(
                                    child: Text(
                                      order?.orderNote ?? '',
                                      style: AppFont.t.s(14).w400.black,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                            if (order?.lydohuy?.isNotEmpty ?? false) ...[
                              const Padding(
                                padding: EdgeInsets.symmetric(vertical: 10),
                                child: Divider(
                                    color: Palette.nuatral50, height: 1),
                              ),
                              BoxConst.s12,
                              Text(
                                'Lý do huỷ đơn:',
                                style: AppFont.t.s(14).w700.black.underline,
                              ),
                              Text(
                                order?.lydohuy ?? '',
                                style: AppFont.t.s(14).w400.black,
                              ),
                            ],
                          ],
                        ),
                      ),
                      if (order?.paymentMethod != null)
                        PaymentMethod(
                          order: order!,
                        ),
                    ],
                  ),
                ),
                Padding(
                  padding: AppTheme.mainPadding,
                  child: Row(
                    children: [
                      if (![
                        OrderStatusEnum.wait_shipper.name,
                      ].contains(order?.getOrderStatus)) ...[
                        Expanded(
                          child: Column(
                            children: [
                              MyButton(
                                color: Palette.red,
                                height: 42.h,
                                icon: const Icon(
                                  Icons.call,
                                  size: 24,
                                  color: Palette.white,
                                ),
                                title: 'Gọi cho cửa hàng',
                                titleStyle: AppFont.t.s(13).w700.white,
                                borderRadius: 8,
                                action: () async {
                                  await Utils().launchPhone(
                                      order?.storeAddress?.storePhone);
                                  shipperCallCustomerModel.saveCallInfo(
                                      orderId: order?.id ?? '',
                                      phoneNum:
                                          order?.storeAddress?.storePhone);
                                },
                              ),
                              BoxConst.s8,
                              InkWell(
                                onTap: () async {
                                  await Clipboard.setData(
                                    ClipboardData(
                                        text: order?.storeAddress?.storePhone ??
                                            ''),
                                  );
                                  ShowToast.success('Sao chép thành công');
                                },
                                child: Container(
                                  decoration: BoxDecoration(
                                    border: Border.all(
                                      width: 0.3,
                                      color: Palette.black,
                                    ),
                                    borderRadius: BorderRadius.circular(6.r),
                                  ),
                                  padding: EdgeInsets.symmetric(
                                      vertical: 4.w, horizontal: 4.w),
                                  child: Row(
                                    // mainAxisSize: MainAxisSize.min,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        order?.storeAddress?.storePhone ?? '',
                                        style: AppFont.t.s(14).w600.black,
                                      ),
                                      BoxConst.s4,
                                      const Icon(
                                        Icons.copy,
                                        size: 24,
                                        color: Palette.black,
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                      BoxConst.s12,
                      Expanded(
                        child: Column(
                          children: [
                            MyButton(
                              color: Palette.green,
                              icon: const Icon(
                                Icons.call,
                                size: 24,
                                color: Palette.white,
                              ),
                              title: 'Gọi cho khách',
                              titleStyle: AppFont.t.s(13).w700.white,
                              borderRadius: 8,
                              action: () async {
                                // viewModel.setOrderIsCalled(order?.id ?? '');
                                await Utils().launchPhone(
                                    order?.shipping?.shippingPhoneNumber);
                              },
                            ),
                            BoxConst.s8,
                            InkWell(
                              onTap: () async {
                                await Clipboard.setData(
                                  ClipboardData(
                                      text: order
                                              ?.shipping?.shippingPhoneNumber ??
                                          ''),
                                );
                                ShowToast.success('Sao chép thành công');
                              },
                              child: Container(
                                decoration: BoxDecoration(
                                  border: Border.all(
                                    width: 0.3,
                                    color: Palette.black,
                                  ),
                                  borderRadius: BorderRadius.circular(6.r),
                                ),
                                padding: EdgeInsets.symmetric(
                                    vertical: 4.w, horizontal: 4.w),
                                child: Row(
                                  // mainAxisSize: MainAxisSize.min,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      order?.shipping?.shippingPhoneNumber ??
                                          '',
                                      style: AppFont.t.s(14).w600.black,
                                    ),
                                    BoxConst.s4,
                                    const Icon(
                                      Icons.copy,
                                      size: 24,
                                      color: Palette.black,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                BoxConst.s8,
                if (![
                  OrderStatusEnum.shipper_nhanhang.name,
                  OrderStatusEnum.shipper_dennoi.name,
                  OrderStatusEnum.completed.name,
                  OrderStatusEnum.cancelled.name,
                ].contains(order?.getOrderStatus))
                  Padding(
                    padding: AppTheme.mainPadding,
                    child: Text(
                      '* Vui lòng gọi cho cửa hàng để xác nhận đơn hàng',
                      style: AppFont.t.s(11).red.w500.italic,
                    ),
                  )
              ],
            ),
          ),
        ),
        if (![
          OrderStatusEnum.shipper_dennoi.name,
          OrderStatusEnum.completed.name,
          OrderStatusEnum.cancelled.name,
        ].contains(order?.getOrderStatus))
          renderBottomButton(),
      ],
    );
  }

  Widget renderBottomButton() {
    return Container(
      color: Palette.white,
      padding: EdgeInsets.all(16.sp),
      child: Consumer<DetailOrderViewModel>(builder: (context, viewModel, _) {
        final order = viewModel.detailOrder?.item;

        /// confirm => hiện nút hủy + nhận đơn vừa ở popup vừa ở detail
        if ([
          OrderStatusEnum.confirm.name,
        ].contains(order?.getOrderStatus)) {
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
                    'Bỏ qua',
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
                    viewModel.updateStatus(
                        OrderStatusEnum.shipper_received_order.name);
                  },
                  child: Row(
                    children: [
                      Text(
                        'Nhận đơn',
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

        /// shipper_received_order => hiện gọi cửa hàng => gọi xong hiện hủy đơn + đến cửa hàng
        if ([
          OrderStatusEnum.shipper_received_order.name,
        ].contains(order?.getOrderStatus)) {
          return ValueListenableBuilder<Box<ShipperCallCustomerModel>>(
            valueListenable: shipperCallCustomerAdapter.listenable(),
            builder: (context, box, _) {
              var isCallShop = box.toMap().containsKey(order?.id);
              if (isCallShop) {
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
                          viewModel.updateStatus(
                              OrderStatusEnum.shipper_coming_to_shop.name);
                        },
                        child: Text(
                          'Đến cửa hàng',
                          style: AppFont.t.s(14).w500.white,
                        ),
                      ),
                    ),
                  ],
                );
              }
              return const SizedBox.shrink();
            },
          );
        }

        /// shipper_coming_to_shop => hiện tôi đã lấy hàng
        if ([
          OrderStatusEnum.shipper_coming_to_shop.name,
        ].contains(order?.getOrderStatus)) {
          return BaseButtonWidget(
            padding: EdgeInsets.symmetric(vertical: 12.sp),
            decoration: BoxDecoration(
              color: Palette.primary50,
              borderRadius: BorderRadius.circular(6.r),
            ),
            onTap: () {
              viewModel.updateStatus(OrderStatusEnum.shipper_nhanhang.name);
            },
            child: Text(
              'Tôi đã lấy hàng',
              style: AppFont.t.s(14).w500.white,
            ),
          );
        }

        /// shipper_nhanhang => hiện đã giao cho khách
        if ([
          OrderStatusEnum.shipper_nhanhang.name,
        ].contains(order?.getOrderStatus)) {
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
              'Đã giao cho khách',
              style: AppFont.t.s(14).w500.white,
            ),
          );
        }

        return Container();
      }),
    );
  }

  Widget _renderDetailInCome(Item? order) {
    return Container(
      decoration: AppTheme.boxDecoration
          .copyWith(borderRadius: BorderRadius.circular(8)),
      padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 10),
      margin: AppTheme.mainPadding,
      child: Column(
        children: [
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              color: Palette.red,
            ),
            padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Phải trả cửa hàng",
                  style: AppFont.t.s(13).w700.white,
                ),
                Text(
                  (order?.getTienCanTra ?? 0).toString().toVnd,
                  style: AppFont.t.s(13).w700.white,
                ),
              ],
            ),
          ),
          BoxConst.s8,
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              color: Palette.green,
            ),
            padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Phải thu khách hàng",
                  style: AppFont.t.s(13).w700.white,
                ),
                Text(
                  (order?.tongtien ?? 0).toString().toVnd,
                  style: AppFont.t.s(13).w700.white,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

import 'package:app_shipper/src/configs/config.dart';
import 'package:app_shipper/src/models/shared_models/shipper_model.dart';
import 'package:app_shipper/src/models/store_address_model.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:app_shipper/src/utils/app_enum.dart';

import '../detail_order_model/shipping.dart';
import '../shared_models/shop.dart';

class Order extends Equatable {
  final String? id;
  final String? orderNumber;
  final Shop? shop;
  final double? total;
  final String? statusText;
  final String? createdAt;
  final int? countItem;
  final ShipperModel? shipper;
  final String? type;
  final double? soKm;
  final double? pricePerKm;
  final double? priceShipping;
  final StoreAddress? storeAddress;
  final Shipping? shipping;
  final String? paymentMethod;

  const Order({
    this.id,
    this.orderNumber,
    this.shop,
    this.total,
    this.statusText,
    this.createdAt,
    this.countItem,
    this.pricePerKm,
    this.priceShipping,
    this.shipper,
    this.type,
    this.soKm,
    this.storeAddress,
    this.shipping,
    this.paymentMethod,
  });

  factory Order.fromJson(Map<String, dynamic> json) => Order(
        id: json['id'],
        orderNumber: json['order_number'],
        shop: json['shop'] == null
            ? null
            : Shop.fromJson(json['shop']! as Map<String, Object?>),
        total: double.tryParse(json['total'].toString()),
        statusText: json['status_text'],
        createdAt: json['created_at'],
        countItem: json['count_item'],
        shipper: json['shipper'] == null
            ? null
            : ShipperModel.fromJson(json['shipper']),
        pricePerKm: double.tryParse(json['price_per_km'].toString()),
        type: json['type'],
        soKm: double.tryParse(json['so_km'].toString()),
        priceShipping: double.tryParse(json['price_shipping'].toString()),
        storeAddress: json['store_address'] == null
            ? null
            : StoreAddress.fromJson(
                json['store_address']! as Map<String, Object?>),
        shipping: json['shipping'] == null
            ? null
            : Shipping.fromJson(json['shipping']! as Map<String, Object?>),
        paymentMethod: json['payment_method'],
      );

  Map<String, Object?> toJson() => {
        'id': id,
        'order_number': orderNumber,
        'shop': shop?.toJson(),
        'total': total,
        'status_text': statusText,
        'created_at': createdAt,
        'count_item': countItem,
        'payment_method': paymentMethod,
      };

  @override
  bool get stringify => true;

  @override
  List<Object?> get props {
    return [
      id,
      orderNumber,
      shop,
      total,
      statusText,
      createdAt,
      countItem,
      paymentMethod,
    ];
  }

  String get getTime {
    if (createdAt != null && createdAt != '') {
      DateTime now = DateTime.now();
      DateFormat format = DateFormat("dd-MM-yyyy / HH:mm");
      DateTime targetTime = format.parse(createdAt!);

      // Tính toán khoảng thời gian
      Duration difference = now.difference(targetTime);

      if (difference.inHours > 0 && difference.inHours <= 24) {
        return '${difference.inHours} giờ trước';
      } else if (difference.inMinutes > 0 && difference.inMinutes <= 60) {
        return '${difference.inMinutes} phút trước';
      } else if (difference.inSeconds > 0 && difference.inSeconds <= 60) {
        return 'vài phút trước';
      }
    }
    return '';
  }

  String get getDateCreate {
    if (createdAt != null && createdAt != '') {
      DateFormat resultFormat = DateFormat("dd/MM/yyyy");
      DateFormat format = DateFormat("dd-MM-yyyy / HH:mm");
      DateTime targetTime = format.parse(createdAt!);
      String resultTimeString = resultFormat.format(targetTime);
      return resultTimeString;
    }
    return '';
  }

  PaymentMethodEnum get getPaymentMethod {
    if (paymentMethod == PaymentMethodEnum.cash.method) {
      return PaymentMethodEnum.cash;
    }
    if (paymentMethod == PaymentMethodEnum.coin.method) {
      return PaymentMethodEnum.coin;
    }
    return PaymentMethodEnum.unknown;
  }

  String get getStrPaymentMethod {
    switch (getPaymentMethod) {
      case PaymentMethodEnum.cash:
        return 'Tiền mặt';
      case PaymentMethodEnum.coin:
        return 'Chuyển khoản';
      default:
        return '';
    }
  }

  Widget? get getIconPaymentType {
    switch (getPaymentMethod) {
      case PaymentMethodEnum.cash:
        return Assets.svgs.wallet.svg(
          width: 24.sp,
          height: 20.sp,
        );
      case PaymentMethodEnum.coin:
        return Assets.svgs.transferBank.svg(
          width: 17.sp,
          height: 22.sp,
        );
      default:
        return null;
    }
  }

  Color get getColorPaymentType {
    switch (getPaymentMethod) {
      case PaymentMethodEnum.cash:
        return Palette.success;
      case PaymentMethodEnum.coin:
        return Palette.linkBlue;
      default:
        return Palette.white;
    }
  }

  Color get getColorStatus {
    switch (statusText) {
      case 'Đã hoàn thành':
        return Palette.success;
      case 'Đã hủy':
        return Palette.primary;
      default:
        return Palette.linkBlue;
    }
  }

  String get getStoreName => shop?.shopName ?? '';
}

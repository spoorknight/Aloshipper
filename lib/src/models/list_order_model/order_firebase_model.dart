import 'package:app_shipper/src/configs/config.dart';
import 'package:app_shipper/src/models/shared_models/shipper_model.dart';
import 'package:app_shipper/src/utils/app_enum.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../configs/gen/assets.gen.dart';

/// count_item : 2
/// created_at : "2023-02-23 23:44:47"
/// created_at_text : "23-02-2023 / 23:44"
/// order_id : "309"
/// order_number : "10309"
/// order_status : "order_processing"
/// seller_id : "398"
/// shipper_id : "557"
/// shop_location : "Tổ 4, Ấp 5 Phường Ngọc Khánh, Quận Ba Đình, Hà Nội"
/// shop_name : "Cafe Time"
/// status_text : "Chờ Store"
/// total : 1034101.25
/// type : "MUAHANG"
/// update_at : "2023-02-23 23:44:47"
/// user_avatar : "https://alotoday.vn/uploads/profile/avatar_63e10f1e8dce56-39408322-64621055.jpg"

class OrderFirebaseModel {
  OrderFirebaseModel({
    num? countItem,
    String? createdAt,
    String? createdAtText,
    String? orderId,
    String? orderNumber,
    String? orderStatus,
    String? sellerId,
    String? shipperId,
    String? shopLocation,
    String? shopName,
    String? statusText,
    num? total,
    String? type,
    ShipperModel? shipper,
    String? updateAt,
    String? userAvatar,
    String? paymentMethod,
    num? resetTime,
  }) {
    _countItem = countItem;
    _createdAt = createdAt;
    _createdAtText = createdAtText;
    _orderId = orderId;
    _orderNumber = orderNumber;
    _orderStatus = orderStatus;
    _sellerId = sellerId;
    _shipperId = shipperId;
    _shopLocation = shopLocation;
    _shopName = shopName;
    _statusText = statusText;
    _total = total;
    _type = type;
    _updateAt = updateAt;
    _userAvatar = userAvatar;
    _shipper = shipper;
    _paymentMethod = paymentMethod;
    _resetTime = resetTime;
  }

  OrderFirebaseModel.fromJson(dynamic json) {
    _countItem = json['count_item'];
    _createdAt = json['created_at'];
    _createdAtText = json['created_at_text'];
    _orderId = json['order_id'];
    _orderNumber = json['order_number'];
    _orderStatus = json['order_status'];
    _sellerId = json['seller_id'];
    _shipperId = json['shipper_id'];
    _shopLocation = json['shop_location'];
    _shopName = json['shop_name'];
    _statusText = json['status_text'];
    _total = json['total'];
    _type = json['type'];
    _updateAt = json['update_at'];
    _userAvatar = json['user_avatar'];
    _shipper =
        json['shipper'] == null ? null : ShipperModel.fromJson(json['shipper']);
    _paymentMethod = json['payment_method'];
    _resetTime = json['reset_time'];
  }

  num? _countItem;
  String? _createdAt;
  String? _createdAtText;
  String? _orderId;
  String? _orderNumber;
  String? _orderStatus;
  String? _sellerId;
  String? _shipperId;
  String? _shopLocation;
  String? _shopName;
  String? _statusText;
  num? _total;
  String? _type;
  String? _updateAt;
  String? _userAvatar;
  ShipperModel? _shipper;
  String? _paymentMethod;
  num? _resetTime;

  OrderFirebaseModel copyWith({
    num? countItem,
    String? createdAt,
    String? createdAtText,
    String? orderId,
    String? orderNumber,
    String? orderStatus,
    String? sellerId,
    String? shipperId,
    String? shopLocation,
    String? shopName,
    String? statusText,
    num? total,
    String? type,
    String? updateAt,
    String? userAvatar,
    ShipperModel? shipperModel,
    String? paymentMethod,
    num? resetTime,
  }) =>
      OrderFirebaseModel(
        countItem: countItem ?? _countItem,
        createdAt: createdAt ?? _createdAt,
        createdAtText: createdAtText ?? _createdAtText,
        orderId: orderId ?? _orderId,
        orderNumber: orderNumber ?? _orderNumber,
        orderStatus: orderStatus ?? _orderStatus,
        sellerId: sellerId ?? _sellerId,
        shipperId: shipperId ?? _shipperId,
        shopLocation: shopLocation ?? _shopLocation,
        shopName: shopName ?? _shopName,
        statusText: statusText ?? _statusText,
        total: total ?? _total,
        type: type ?? _type,
        updateAt: updateAt ?? _updateAt,
        userAvatar: userAvatar ?? _userAvatar,
        shipper: shipperModel ?? _shipper,
        paymentMethod: paymentMethod ?? _paymentMethod,
        resetTime: resetTime ?? _resetTime,
      );

  num? get countItem => _countItem;

  String? get createdAt => _createdAt;

  String? get createdAtText => _createdAtText;

  String? get orderId => _orderId;

  String? get orderNumber => _orderNumber;

  String? get orderStatus => _orderStatus;

  String? get sellerId => _sellerId;

  String? get shipperId => _shipperId;

  String? get shopLocation => _shopLocation;

  String? get shopName => _shopName;

  String? get statusText => _statusText;

  num? get total => _total;

  String? get type => _type;

  String? get updateAt => _updateAt;

  String? get userAvatar => _userAvatar;

  ShipperModel? get shipper => _shipper;

  String? get paymentMethod => _paymentMethod;

  num get getResetTime => _resetTime ?? 60;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['count_item'] = _countItem;
    map['created_at'] = _createdAt;
    map['created_at_text'] = _createdAtText;
    map['order_id'] = _orderId;
    map['order_number'] = _orderNumber;
    map['order_status'] = _orderStatus;
    map['seller_id'] = _sellerId;
    map['shipper_id'] = _shipperId;
    map['shop_location'] = _shopLocation;
    map['shop_name'] = _shopName;
    map['status_text'] = _statusText;
    map['total'] = _total;
    map['type'] = _type;
    map['update_at'] = _updateAt;
    map['user_avatar'] = _userAvatar;
    map['shipper'] = _shipper;
    map['payment_method'] = _paymentMethod;
    return map;
  }

  String get getTime {
    if (_createdAtText != null && _createdAtText != '') {
      DateTime now = DateTime.now();
      DateFormat format = DateFormat("dd-MM-yyyy / HH:mm");
      DateTime targetTime = format.parse(_createdAtText!);

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
    if (_createdAtText != null && _createdAtText != '') {
      DateFormat resultFormat = DateFormat("dd/MM/yyyy");
      DateFormat format = DateFormat("dd-MM-yyyy / HH:mm");
      DateTime targetTime = format.parse(_createdAtText!);
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
          width: 22.sp,
          height: 16.sp,
        );
      case PaymentMethodEnum.coin:
        return Assets.svgs.transferBank.svg(
          width: 15.sp,
          height: 19.sp,
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

  String get getStoreName => shopName ?? '';
}

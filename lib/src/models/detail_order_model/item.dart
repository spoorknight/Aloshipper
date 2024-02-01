import 'package:app_shipper/src/configs/config.dart';
import 'package:app_shipper/src/utils/app_enum.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

import '../shared_models/product.dart';
import '../shared_models/shipper_model.dart';
import '../shared_models/shop.dart';
import '../store_address_model.dart';
import 'khuyenmai_hd.dart';
import 'shipping.dart';

class Item extends Equatable {
  final String? id;
  final String? orderNumber;
  final Shop? shop;
  final Shipping? shipping;
  final List<Product>? products;
  final double? cod;
  final double? tienhang;
  final double? phiship;
  final double? giamgia;
  final double? tongtien;
  final String? statusText;
  final String? orderStatus;
  final String? orderNote;
  final KhuyenmaiHd? khuyenmaiHd;
  final String? createdAt;
  final String? lydohuy;
  final String? type;
  final double? soKm;
  final double? pricePerKm;
  final ShipperModel? shipper;
  final StoreAddress? storeAddress;
  final String? paymentMethod;
  final String? voucherType;

  const Item({
    this.id,
    this.orderNumber,
    this.shop,
    this.shipping,
    this.products,
    this.cod,
    this.tienhang,
    this.phiship,
    this.giamgia,
    this.tongtien,
    this.statusText,
    this.orderStatus,
    this.orderNote,
    this.khuyenmaiHd,
    this.createdAt,
    this.lydohuy,
    this.type,
    this.pricePerKm,
    this.soKm,
    this.shipper,
    this.storeAddress,
    this.paymentMethod,
    this.voucherType,
  });

  factory Item.fromJson(Map<String, dynamic> json) => Item(
        id: json['id'],
        orderNumber: json['order_number'],
        shop: json['shop'] == null
            ? null
            : Shop.fromJson(json['shop']! as Map<String, dynamic>),
        shipping: json['shipping'] == null
            ? null
            : Shipping.fromJson(json['shipping']! as Map<String, dynamic>),
        products: (json['products'] as List<dynamic>?)
            ?.map((e) => Product.fromJson(e as Map<String, dynamic>))
            .toList(),
        cod: double.tryParse(json['cod'].toString()),
        tienhang: double.tryParse(json['tienhang'].toString()),
        phiship: double.tryParse(json['phiship'].toString()),
        giamgia: double.tryParse(json['giamgia'].toString()),
        tongtien: double.tryParse(json['tongtien'].toString()),
        statusText: json['status_text'],
        orderStatus: json['order_status'],
        orderNote: json['order_note'],
        khuyenmaiHd: json['khuyenmai_hd'] == null
            ? null
            : KhuyenmaiHd.fromJson(
                json['khuyenmai_hd']! as Map<String, dynamic>),
        createdAt: json['created_at'],
        lydohuy: json['lydohuy'],
        type: json['type'],
        soKm: double.tryParse(json['so_km'].toString()),
        pricePerKm: double.tryParse(json['price_per_km'].toString()),
        shipper: json['shipper'] == null
            ? null
            : ShipperModel.fromJson(json['shipper']! as Map<String, dynamic>),
        storeAddress: json['store_address'] == null
            ? null
            : StoreAddress.fromJson(
                json['store_address']! as Map<String, dynamic>),
        paymentMethod: json['payment_method'],
        voucherType: json['voucher_type'],
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'order_number': orderNumber,
        'shop': shop?.toJson(),
        'shipping': shipping?.toJson(),
        'products': products?.map((e) => e.toJson()).toList(),
        'cod': cod,
        'tienhang': tienhang,
        'phiship': phiship,
        'giamgia': giamgia,
        'tongtien': tongtien,
        'status_text': statusText,
        'order_status': orderStatus,
        'order_note': orderNote,
        'khuyenmai_hd': khuyenmaiHd?.toJson(),
        'created_at': createdAt,
        'lydohuy': lydohuy,
        'type': type,
        'soKm': soKm,
        'pricePerKm': pricePerKm,
        'shipper': shipper?.toJson(),
        'store_address': storeAddress?.toJson(),
        'payment_method': paymentMethod,
        'voucher_type': voucherType,
      };

  Item copyWith({
    String? id,
    String? orderNumber,
    Shop? shop,
    Shipping? shipping,
    List<Product>? products,
    double? cod,
    double? tienhang,
    double? phiship,
    double? giamgia,
    double? tongtien,
    String? statusText,
    String? orderStatus,
    String? orderNote,
    KhuyenmaiHd? khuyenmaiHd,
    String? createdAt,
    String? lydohuy,
    String? type,
    double? soKm,
    double? pricePerKm,
    ShipperModel? shipper,
    StoreAddress? storeAddress,
    String? paymentMethod,
    String? voucherType,
  }) {
    return Item(
      id: id ?? this.id,
      orderNumber: orderNumber ?? this.orderNumber,
      shop: shop ?? this.shop,
      shipping: shipping ?? this.shipping,
      products: products ?? this.products,
      cod: cod ?? this.cod,
      tienhang: tienhang ?? this.tienhang,
      phiship: phiship ?? this.phiship,
      giamgia: giamgia ?? this.giamgia,
      tongtien: tongtien ?? this.tongtien,
      statusText: statusText ?? this.statusText,
      orderStatus: orderStatus ?? this.orderStatus,
      orderNote: orderNote ?? this.orderNote,
      khuyenmaiHd: khuyenmaiHd ?? this.khuyenmaiHd,
      createdAt: createdAt ?? this.createdAt,
      lydohuy: lydohuy ?? this.lydohuy,
      type: type ?? this.type,
      soKm: soKm ?? this.soKm,
      pricePerKm: pricePerKm ?? this.pricePerKm,
      shipper: shipper ?? this.shipper,
      storeAddress: storeAddress ?? this.storeAddress,
      paymentMethod: paymentMethod ?? this.paymentMethod,
      voucherType: voucherType ?? this.voucherType,
    );
  }

  @override
  bool get stringify => true;

  @override
  List<dynamic> get props {
    return [
      id,
      orderNumber,
      shop,
      shipping,
      products,
      cod,
      tienhang,
      phiship,
      giamgia,
      tongtien,
      statusText,
      orderStatus,
      orderNote,
      khuyenmaiHd,
      createdAt,
      lydohuy,
      type,
      soKm,
      pricePerKm,
      shipper,
      storeAddress,
      paymentMethod,
    ];
  }

  double get getTienCanTra {
    double total = (tienhang ?? 0) - (giamgia ?? 0);
    return total >= 0 ? total : 0;
  }

  String get getShipFromStoreAddress => shipping?.fromAddress ?? '';

  String get getShipToStoreAddress => shipping?.toAddress ?? '';

  String get getFromStoreAddress => storeAddress?.storeAddress ?? '';

  String get getToStoreAddress => shipping?.fullAddress ?? '';

  String get getStoreName => storeAddress?.storeName ?? '';

  // String get getOrderStatus => 'shipper_received_order';
  String get getOrderStatus => orderStatus ?? '';

  Color get getColorStatus {
    switch (orderStatus) {
      case 'completed':
        return Palette.success;
      case 'cancelled':
        return Palette.primary;
      default:
        return Palette.linkBlue;
    }
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

  Widget? get getIconPaymentType {
    switch (getPaymentMethod) {
      case PaymentMethodEnum.cash:
        return Assets.svgs.wallet.svg(
          width: 26.sp,
          height: 20.sp,
        );
      case PaymentMethodEnum.coin:
        return Assets.svgs.transferBank.svg(
          width: 19.sp,
          height: 22.sp,
        );
      default:
        return null;
    }
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

  VoucherType? get getVoucherType {
    if (voucherType == VoucherType.freeShipping.getValue) {
      return VoucherType.freeShipping;
    } else if (voucherType == VoucherType.discount.getValue) {
      return VoucherType.discount;
    } else {
      return null;
    }
  }
}

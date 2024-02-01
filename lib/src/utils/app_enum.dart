import 'package:collection/collection.dart';

enum VehicleType {
  motobike('1', 'Xe máy'),
  car('2', 'Ô tô');

  final String code;
  final String name;
  const VehicleType(this.code, this.name);
}

enum VoucherType {
  freeShipping(1, 'free_shipping'),
  discount(2, 'discount'),
  transfer(3, 'transfer'),
  alotoday(4, 'alotoday');

  final int id;
  final String value;

  const VoucherType(this.id, this.value);

  String get getValue => value;
}

enum ExchangeType {
  none(value: ''),
  day(value: 'day'),
  money(value: 'money');

  final String value;

  const ExchangeType({required this.value});
}

enum MissionType {
  none(value: ''),
  adViews(value: 'AD_VIEWS'),
  share(value: 'SHARE'),
  referFriend(value: 'REFER_FRIEND'),
  checkIn(value: 'CHECK_IN');

  final String value;

  const MissionType({required this.value});
}

enum GiftType {
  day(value: 'day'),
  point(value: 'point');

  final String value;

  const GiftType({required this.value});
}

enum AdvertisingType {
  shop(value: 'shop'),
  admob(value: 'admob');

  final String value;

  const AdvertisingType({required this.value});
}

enum CustomerType {
  none(value: 'none'),
  vendor(value: 'vendor'),
  shipper(value: 'shipper'),
  member(value: 'member');

  final String value;

  const CustomerType({required this.value});
}

enum AppNameEnum {
  alotoday(value: 'alotoday'),
  aloshipper(value: 'aloshipper'),
  alostore(value: 'alostore');

  final String value;

  const AppNameEnum({required this.value});
}

enum PaymentMethodEnum {
  coin('xu'),
  cash('cod'),
  unknown('');

  final String method;
  const PaymentMethodEnum(this.method);

  factory PaymentMethodEnum.fromStr(String? str) {
    return PaymentMethodEnum.values.firstWhereOrNull((e) => e.method == str) ??
        unknown;
  }
}

enum OrderStatus { delivered, delivering, confirm, completed, cancelled }

enum Environment {dev, staging, prod}

enum PaymentDeposit {transfer, vnpay}



enum OrderStatusEnum {
  /// đơn hàng
  confirm,
  shipper_received_order,
  shipper_coming_to_shop,
  shipper_nhanhang,
  shipper_dennoi,
  completed,
  cancelled,

  ///shipper
  shipper_nhankhach,
  shipper_confirm,
  wait_shipper,
}

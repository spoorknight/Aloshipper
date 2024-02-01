
import 'package:app_shipper/src/utils/extensions/extensions.dart';

import '../../utils/app_enum.dart';

class VoucherTransfersResponse {
  bool? status;
  String? mess;
  List<VoucherTransferModel>? data;

  VoucherTransfersResponse({this.status, this.mess, this.data});

  VoucherTransfersResponse.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    mess = json['mess'];
    if (json['data'] != null) {
      data = <VoucherTransferModel>[];
      json['data'].forEach((v) {
        data!.add(VoucherTransferModel.fromJson(v));
      });
    }
  }
}

class VoucherTransferModel {
  String? id;
  String? title;
  String? value;
  String? status;
  String? isUsed;
  String? neededPoints;
  String? createdAt;
  String? updatedAt;

  VoucherTransferModel({
    this.id,
    this.title,
    this.value,
    this.status,
    this.createdAt,
    this.updatedAt,
    this.isUsed,
    this.neededPoints,
  });

  VoucherTransferModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    value = json['value'];
    status = json['status'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    isUsed = json['is_used'];
    neededPoints = json['needed_points'];
  }

  String get getTitleVoucher => title ?? '';

  String get getValueVoucher => (value ?? '0').toVnd;

  double get discountPrice => double.tryParse(value ?? '0') ?? 0;

  double get getMinimumOrderPrice => 0;

  String get getPointNeedToTransfer => (neededPoints ?? '0');

  double get getPointNeed => double.tryParse((neededPoints ?? '0').removeComma) ?? 0;

  String get getCouponCode => getTitleVoucher;

  String get getVoucherId => id ?? '';

  VoucherType get getVoucherType => VoucherType.transfer;
}

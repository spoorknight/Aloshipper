import 'package:app_shipper/src/di/injection/injection.dart';

class BankInfo {
  bool? success;
  String? message;
  Data? data;

  BankInfo({
    this.success,
    this.message,
    this.data,
  });

  factory BankInfo.fromJson(Map<String, dynamic> json) => BankInfo(
        success: json["success"],
        message: json["message"],
        data: json["data"] == null ? null : Data.fromJson(json["data"]),
      );
}

class Data {
  String? bankName;
  String? bankNum;
  String? accountOwner;
  String? contentPrefix;

  Data({
    this.bankName,
    this.bankNum,
    this.accountOwner,
    this.contentPrefix,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    bankName: json["bankName"],
    bankNum: json["bankNum"],
    accountOwner: json["accountOwner"],
    contentPrefix: json["contentPrefix"],
  );

  String get getContentPrefix =>
      '${contentPrefix ?? 'NAP'}${appData.profile.value?.item?.user?.id}';
}


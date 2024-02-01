import 'package:equatable/equatable.dart';
import 'package:package_info/package_info.dart';

class DeviceInfoModel extends Equatable {
  final String? deviceId;
  final String? name;
  final String? os;
  final String? osVersion;
  final PackageInfo? packageInfor;

  const DeviceInfoModel({
    this.deviceId,
    this.name,
    this.os,
    this.osVersion,
    this.packageInfor
  });

  factory DeviceInfoModel.fromJson(Map<String, dynamic> json) =>
      DeviceInfoModel(
        deviceId: json['deviceId'] as String?,
        name: json['name'] as String?,
        os: json['os'] as String?,
        osVersion: json['osVersion'] as String?,
        packageInfor: json['packageInfor'] as PackageInfo?,
      );

  Map<String, dynamic> toJson() => {
        "deviceId": deviceId,
        "name": name,
        "os": os,
        "osVersion": osVersion,
      };

  @override
  bool get stringify => true;

  @override
  List<Object?> get props {
    return [];
  }

  String get getPackageVersion =>
      packageInfor == null ? '1.0.0' : packageInfor!.version;

  String get getPackageBuildNumber =>
      packageInfor == null ? '1' : packageInfor!.buildNumber;
}

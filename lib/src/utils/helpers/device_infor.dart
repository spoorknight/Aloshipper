import 'dart:io';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/services.dart';
import 'package:package_info/package_info.dart';

import '../../models/device_info_model.dart';

class DeviceHelper {
  static final DeviceInfoPlugin _deviceInfoPlugin = DeviceInfoPlugin();
  static Map<String, dynamic> _deviceInfor = {};
  late PackageInfo _packageInfor ;

  Future<void> initPlatformState() async {
    try {
      _packageInfor = await PackageInfo.fromPlatform();

      if (Platform.isAndroid) {
        _deviceInfor =
            _readAndroidBuildData(await _deviceInfoPlugin.androidInfo);
        return;
      } else if (Platform.isIOS) {
        _deviceInfor = _readIosDeviceInfo(await _deviceInfoPlugin.iosInfo);
        return;
      }
    } on PlatformException {
      _deviceInfor = <String, dynamic>{
        'Error:': 'Failed to get platform version.'
      };
    }

    return;
  }

  DeviceInfoModel? getDeviceInfor() {
    Map<String, dynamic> info = {};
    try {
      if (Platform.isAndroid) {
        info = {
          "deviceId": _deviceInfor['androidId'],
          "name": _deviceInfor['brand'] + "-" + _deviceInfor['model'],
          "os": _deviceInfor['version.release'],
          "osVersion": _deviceInfor['version.previewSdkInt'].toString(),
          "packageInfor": _packageInfor,
        };
      } else if (Platform.isIOS) {
        info = {
          "deviceId": _deviceInfor['identifierForVendor'],
          "name": _deviceInfor['name'],
          "os": _deviceInfor['systemName'],
          "osVersion": _deviceInfor['systemVersion'],
          "packageInfor": _packageInfor,
        };
      }
      return DeviceInfoModel.fromJson(info);
    } catch (e) {
      return const DeviceInfoModel();
    }
  }

  Map<String, dynamic> _readAndroidBuildData(AndroidDeviceInfo build) {
    return <String, dynamic>{
      // 'version.securityPatch': build.version.securityPatch,
      // 'version.sdkInt': build.version.sdkInt,
      'version.release': build.version.release,
      'version.previewSdkInt': build.version.previewSdkInt,
      // 'version.incremental': build.version.incremental,
      // 'version.codename': build.version.codename,
      // 'version.baseOS': build.version.baseOS,
      'board': build.board,
      // 'bootloader': build.bootloader,
      'brand': build.brand,
      // 'device': build.device,
      'display': build.display,
      // 'fingerprint': build.fingerprint,
      // 'hardware': build.hardware,
      // 'host': build.host,
      // 'id': build.id,
      // 'manufacturer': build.manufacturer,
      'model': build.model,
      // 'product': build.product,
      // 'supported32BitAbis': build.supported32BitAbis,
      // 'supported64BitAbis': build.supported64BitAbis,
      // 'supportedAbis': build.supportedAbis,
      // 'tags': build.tags,
      // 'type': build.type,
      // 'isPhysicalDevice': build.isPhysicalDevice,
      'androidId': build.id,
      // 'systemFeatures': build.systemFeatures,
    };
  }

  Map<String, dynamic> _readIosDeviceInfo(IosDeviceInfo data) {
    return <String, dynamic>{
      'name': data.name,
      'systemName': data.systemName,
      'systemVersion': data.systemVersion,
      // 'model': data.model,
      // 'localizedModel': data.localizedModel,
      'identifierForVendor': data.identifierForVendor,
      // 'isPhysicalDevice': data.isPhysicalDevice,
      // 'utsname.sysname:': data.utsname.sysname,
      // 'utsname.nodename:': data.utsname.nodename,
      // 'utsname.release:': data.utsname.release,
      // 'utsname.version:': data.utsname.version,
      // 'utsname.machine:': data.utsname.machine,
    };
  }
}

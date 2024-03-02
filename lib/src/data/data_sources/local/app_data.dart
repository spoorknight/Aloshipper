import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:app_shipper/src/data/repositories/profile_repository.dart';
import 'package:app_shipper/src/di/injection/injection.dart';
import 'package:app_shipper/src/models/user_active_info_model.dart';
import 'package:app_shipper/src/utils/app_enum.dart';
import 'package:app_shipper/src/utils/extensions/extensions.dart';
import 'package:app_shipper/src/utils/helpers/logger.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:rxdart/rxdart.dart';

import '../../../models/content_share_model.dart';
import '../../../models/device_info_model.dart';
import '../../../models/profile_model.dart';
import '../../../navigator/app_navigator.dart';
import '../../../network/api_path.dart';
import '../../../shared/dialog.dart';
import '../../../utils/helpers/geolocator_helper.dart';
import '../../../utils/permission_helper/app_permission.dart';

class AppData {
  String tokenLogin = '';
  String userId = '';
  String firebaseToken = '';
  DeviceInfoModel? deviceInfo;

  // nếu expire là true > tk hết hạn
  bool isExpire = false;
  bool isBan = false;

  // ProfileModel? profile;
  MyCurrentAddress? myCurrentAddress;
  final profile = BehaviorSubject<ProfileModel?>();
  ProfileModel? get getProfile => profile.value;
  final contentShare = BehaviorSubject<ContentShareModel?>();
  final canPayment = BehaviorSubject<bool>.seeded(true);
  UserInfoActiveModel? userInfoActiveModel;

  Environment _env = Environment.staging;

  Dio? myDio;

  Timer? _timer;

  String get getUrl {
    switch (_env) {
      case Environment.dev:
      case Environment.staging:
        return ApiPath.baseUrlStaging;
      case Environment.prod:
        return ApiPath.baseUrl;
      default:
        return '';
    }
  }

  bool get checkIsShipperOrStore => true;

  void setEnvironment(Environment data) {
    _env = data;
  }

  void clear() {
    tokenLogin = '';
    deviceInfo = null;
    // profile = null;
    profile.add(null);
    myCurrentAddress = null;
    _timer?.cancel();
  }

  String? convertBase64Image(File? image) {
    String? base64Image;
    if (image != null) {
      List<int> imageBytes = image.readAsBytesSync();
      base64Image = base64Encode(imageBytes);
    }
    return base64Image;
  }

  void autoUpdateLocation() {
    Logger.d('AutoUpdateLocation', 'Execute');
    if (appData.profile.valueOrNull?.item?.user?.shopOnline == "1") {
      _timer?.cancel();
      _timer = Timer.periodic(const Duration(minutes: 1), (timer) {
        Logger.d('autoUpdateLocation', timer.tick);
        updateToaDo();
      });
    } else {
      _timer?.cancel();
    }
  }

  void updateToaDo() async {
    GrantPermissionLocationStrategy().request(
      onGranted: () async {
        final currentLocation = await geolocatorHelper.getCurrentPosition();
        myCurrentAddress = currentLocation;
        await getIt<ProfileRepository>().updateToaDo(
          tokenLogin,
          currentLocation?.latitude, //21.003648,105.8086358
          currentLocation?.longitude,
            // 21.003648,
            // 105.8086358
        );
      },
      onDenied: appData.showDialogOpenAppSettings,
      onPermanentlyDenied: appData.showDialogOpenAppSettings,
    );
  }

  checkUpdate(context) {
    fbRemoteConfig
        .versionCheck((value) => dialogUpdate(value, context))
        .then((value) => dialogUpdate(value, context));
  }

  dialogUpdate(value, context) {
    if (value != null && value['needUpdate']) {
      fbRemoteConfig.showUpdateDialog(
        context: context,
        dialogTitle: 'Thông báo',
        dialogText: 'Có bản cập nhật mới',
        updateButtonText: 'Cập nhật',
        allowDismissal: false,
      );
    } else if (value != null && value['isDialogOpen']) {
      fbRemoteConfig.closeDialog();
    }
  }

  Future<void> checkCanPayment(String userId) async {
    try {
      final res = await getIt<Dio>().get(ApiPath.getListUserCanNotViewPayment);
      if (res.data != null) {
        Logger.d('Can Payment:', '${res.data.runtimeType}: ${res.data}');
        List<String> list  = [];
        for (var res in res.data['data']) {
          list.add(res.toString());
        }
        if(list.where((element) => element == userId).toList().isNotEmpty){
          canPayment.add(false);
        }else{
          canPayment.add(true);
        }
      } else {
        canPayment.add(true);
      }
    } catch (e) {
      canPayment.add(true);
    }
  }


  Future<void> getAppSharing() async {
    try {
      final res = await getIt<Dio>().post(ApiPath.getShareSettings);
      if (res.data != null) {
        contentShare.add(ContentShareModel.fromJson(res.data));
      } else {
        contentShare.add(null);
      }
    } catch (e) {
      contentShare.add(null);
    }
  }

  void showDialogOpenAppSettings() {
    showDialog(
      context: AppNavigator.context!,
      builder: (builder) {
        return const DialogConfirm(
          mess: 'Cho phép ứng dụng truy cập vị trí của bạn để cập nhật toạ độ',
          titleButton: 'Tiếp tục',
          action: openAppSettings,
        );
      },
    );
  }
}

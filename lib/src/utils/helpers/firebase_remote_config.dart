import 'dart:io' show Platform;

import 'package:app_shipper/src/shared/dialog_update.dart';
import 'package:firebase_remote_config/firebase_remote_config.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher_string.dart';

import '../../di/injection/injection.dart';
import '../../models/device_info_model.dart';

class FBRemoteConfig {
  final String _appStoreLink = 'https://apps.apple.com/app/id6446852821';
  final String _playStoreLink =
      'market://details?id=com.aloit.shipper.app_shipper';
  final String keyForceUpdateCurrentVersion = 'force_update_current_version';
  final String keyLinkUpdateApp = 'link_update_app';
  String? linkUpdateApp;

  bool isDialogOpen = false;
  final remoteConfig = FirebaseRemoteConfig.instance;
  BuildContext? callBackContext;

  Future<Map?> versionCheck(Function? onUpdate) async {
    try {
      //Get Current installed version of app
      DeviceInfoModel? deviceInfo = deviceHelper.getDeviceInfor();
      String currentVersion = deviceInfo?.getPackageVersion ?? '1.0.0'; // 1.0.0

      // Using default duration to force fetching from remote server.
      await remoteConfig.setConfigSettings(RemoteConfigSettings(
        fetchTimeout: const Duration(seconds: 30),
        minimumFetchInterval: Duration.zero,
      ));

      await remoteConfig.fetchAndActivate();

      String newVersion = remoteConfig.getString(keyForceUpdateCurrentVersion);

      linkUpdateApp = remoteConfig.getString(keyLinkUpdateApp);

      Map<String, dynamic> value = {
        'needUpdate': _checkNeedUpdate(currentVersion, newVersion),
        'isDialogOpen': isDialogOpen,
      };

      remoteConfig.onConfigUpdated.listen((RemoteConfigUpdate event) async {
        await remoteConfig.activate();
        if (event.updatedKeys.contains(keyForceUpdateCurrentVersion)) {
          newVersion = remoteConfig.getString(keyForceUpdateCurrentVersion);
        }
        if (event.updatedKeys.contains(keyLinkUpdateApp)) {
          linkUpdateApp = remoteConfig.getString(keyLinkUpdateApp);
        }
        value = {
          'needUpdate': _checkNeedUpdate(currentVersion, newVersion),
          'isDialogOpen': isDialogOpen,
        };
        if (onUpdate != null) {
          onUpdate(value);
        }
      });

      return value;
    } catch (exception) {
      // Fetch throttled.
      debugPrint('fetch error => $exception');
      return null;
    }
  }

  void showUpdateDialog({
    required BuildContext context,
    String dialogTitle = 'Update Available',
    String? dialogText,
    String updateButtonText = 'Update',
    bool allowDismissal = true,
    String dismissButtonText = 'Maybe Later',
    VoidCallback? dismissAction,
  }) async {
    isDialogOpen = true;
    updateAction() {
      String url = linkUpdateApp ??
          (Platform.isAndroid ? _playStoreLink : _appStoreLink);
      _launchAppStore(url);
      if (allowDismissal) {
        Navigator.of(context, rootNavigator: true).pop();
      }
    }

    return showDialog(
      context: context,
      barrierDismissible: allowDismissal,
      builder: (BuildContext alertContext) {
        callBackContext = alertContext;
        return WillPopScope(
            child: DialogUpdate(onPressed: updateAction),
            onWillPop: () => Future.value(allowDismissal));
      },
    ).then((value) {
      isDialogOpen = false;
    });
  }

  closeDialog() {
    if (callBackContext != null) {
      isDialogOpen = false;
      Navigator.of(callBackContext!).pop();
    }
  }

  /// Launches the Apple App Store or Google Play Store page for the app.
  Future<void> _launchAppStore(String appStoreLink) async {
    debugPrint(appStoreLink);
    launchUrlString(appStoreLink);
  }

  bool _checkNeedUpdate(String currentVersion, String storeVersion) {
    List<int> version1Parts = currentVersion.split('.').map(int.parse).toList();
    List<int> version2Parts = storeVersion.split('.').map(int.parse).toList();

    int minLength = version1Parts.length < version2Parts.length
        ? version1Parts.length
        : version2Parts.length;

    int result = 0;

    for (int i = 0; i < minLength; i++) {
      if (version1Parts[i] < version2Parts[i]) {
        result = -1;
        break;
      } else if (version1Parts[i] > version2Parts[i]) {
        result = 1;
        break;
      }
    }

    if (result == 0 && version1Parts.length != version2Parts.length) {
      result = version1Parts.length < version2Parts.length ? -1 : 1;
    }

    if (result == -1) {
      return true;
    } else if (result == 1) {
      return false;
    } else {
      return false;
    }
  }
}

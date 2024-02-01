import 'package:flutter/foundation.dart';
import 'package:permission_handler/permission_handler.dart';

abstract class GrantPermissionStrategy {
  final Permission permission;

  GrantPermissionStrategy(this.permission);

  Future<void> request({
    final OnPermanentlyDenied? onPermanentlyDenied,
    final OnGranted? onGranted,
    final OnDenied? onDenied,
  }) async {
    PermissionStatus status = await permission.status;
    debugPrint('GrantPermissionStrategy status: $status');
    if (!status.isLimited && !status.isGranted) {
      final PermissionStatus result = await permission.request();
      if (result.isPermanentlyDenied) {
        onPermanentlyDenied?.call();
        return;
      }
      if (!result.isGranted) {
        onDenied?.call();
        return;
      }
    }
    onGranted?.call();
  }
}

typedef OnPermanentlyDenied = void Function();
typedef OnDenied = void Function();
typedef OnGranted = void Function();

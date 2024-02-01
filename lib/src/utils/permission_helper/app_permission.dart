import 'dart:io';
import 'package:permission_handler/permission_handler.dart';
import 'core_permission.dart';

class GrantPermissionCameraStrategy extends GrantPermissionStrategy {
  GrantPermissionCameraStrategy() : super(Permission.camera);
}

class GrantPermissionPhotosStrategy extends GrantPermissionStrategy {
  GrantPermissionPhotosStrategy()
      : super(Platform.isAndroid ? Permission.storage : Permission.photos);
}

class GrantPermissionLocationStrategy extends GrantPermissionStrategy {
  GrantPermissionLocationStrategy() : super(Permission.location);
}

class GrantPermissionNotificationStrategy extends GrantPermissionStrategy {
  GrantPermissionNotificationStrategy() : super(Permission.notification);
}

import '../../utils/helpers/logger.dart';
import '../injection/injection.dart';

class DeviceModules extends DIModule {
  @override
  Future<void> register() async {
    await deviceHelper.initPlatformState();
    appData.deviceInfo = deviceHelper.getDeviceInfor();
    appData.myCurrentAddress = await geolocatorHelper.getCurrentPosition();
    Logger.d('DEVICE INFO', appData.deviceInfo?.toJson());
  }
}

import 'package:shared_preferences/shared_preferences.dart';

import '../../data/data_sources/local/app_data.dart';
import '../../data/data_sources/local/data_manager.dart';
import '../../data/data_sources/local/data_manager_imlp.dart';
import '../../utils/helpers/device_infor.dart';
import '../../utils/helpers/firebase_remote_config.dart';
import '../../utils/helpers/geolocator_helper.dart';
import '../injection/injection.dart';

class ComponentModules extends DIModule {
  @override
  Future<void> register() async {
    getIt.registerSingleton<DataManager>(
      DataManagerImpl(
        sharedPreferences: await SharedPreferences.getInstance(),
      ),
    );
    getIt.registerSingleton<AppData>(AppData());
    getIt.registerSingleton<GeolocatorHelper>(GeolocatorHelper());
    getIt.registerSingleton<DeviceHelper>(DeviceHelper());
    getIt.registerSingleton<FBRemoteConfig>(FBRemoteConfig());
  }
}

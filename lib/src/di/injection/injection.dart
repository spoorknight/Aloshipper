import 'package:app_shipper/src/di/modules/component_modules.dart';
import 'package:app_shipper/src/di/modules/notification_modules.dart';
import 'package:app_shipper/src/utils/app_enum.dart';
import 'package:get_it/get_it.dart';
import 'package:hive/hive.dart';

import '../../data/data_sources/local/app_data.dart';
import '../../data/data_sources/local/data_manager.dart';
import '../../features/cancel_order/cancel_order_view_model.dart';
import '../../features/detail_order/detail_order_view_model.dart';
import '../../features/event/event_view_model.dart';
import '../../models/hive/shipper_call_customer_adapter.dart';
import '../../shared/viewModels/banner_ads_view_model.dart';
import '../../utils/helpers/device_infor.dart';
import '../../utils/helpers/firebase_remote_config.dart';
import '../../utils/helpers/geolocator_helper.dart';
import '../modules/api_modules.dart';
import '../modules/device_modules.dart';
import '../modules/hive_modules.dart';
import '../modules/provider_modules.dart';
import '../modules/repository_modules.dart';

GetIt getIt = GetIt.I;

abstract class DIModule {
  void register();
}

class Injection {
  static Future<void> inject() async {
    await ComponentModules().register();
    appData.setEnvironment(Environment.staging);
    await ApiModule().register();
    await ProviderModule().register();
    await RepositoryModules().register();
    await DeviceModules().register();
    await NotificationModules().register();
    await HiveModules().register();
  }
}

AppData get appData => getIt<AppData>();

GeolocatorHelper get geolocatorHelper => getIt<GeolocatorHelper>();

DeviceHelper get deviceHelper => getIt<DeviceHelper>();

DataManager get dataManager => getIt<DataManager>();

DetailOrderViewModel get detailOrderViewModel => getIt<DetailOrderViewModel>();

BannerAdsViewModel get bannerAdsViewModel => getIt<BannerAdsViewModel>();

CancelOrderViewModel get cancelOrderViewModel => getIt<CancelOrderViewModel>();

EventViewModel get eventViewModel => getIt<EventViewModel>();

FBRemoteConfig get fbRemoteConfig => getIt<FBRemoteConfig>();

Box<ShipperCallCustomerModel> get shipperCallCustomerAdapter => getIt<Box<ShipperCallCustomerModel>>();

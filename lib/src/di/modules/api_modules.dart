import 'package:app_shipper/src/data/data_sources/remote/order_api.dart';

import '../../data/data_sources/remote/authentication_api.dart';
import '../../data/data_sources/remote/banner_ads_api.dart';
import '../../data/data_sources/remote/collab_api.dart';
import '../../data/data_sources/remote/event_api.dart';
import '../../data/data_sources/remote/noti_api.dart';
import '../../data/data_sources/remote/profile_api.dart';
import '../../network/base_dio.dart';
import '../injection/injection.dart';

class ApiModule extends DIModule {
  @override
  Future<void> register() async {
    final dio = await BaseDio.setup();
    getIt.registerSingleton(dio);
    getIt.registerSingleton(AuthenticationApi(dio, baseUrl: appData.getUrl));
    getIt.registerSingleton(CollabApi(dio, baseUrl: appData.getUrl));
    getIt.registerSingleton(NotiApi(dio, baseUrl: appData.getUrl));
    getIt.registerSingleton(ProfileApi(dio, baseUrl: appData.getUrl));
    getIt.registerSingleton(OrderApi(dio, baseUrl: appData.getUrl));
    getIt.registerSingleton(EventApi(dio, baseUrl: appData.getUrl));
    getIt.registerSingleton(BannerAdsApi(dio, baseUrl: appData.getUrl));
  }
}

import 'package:app_shipper/src/data/data_sources/remote/order_api.dart';
import 'package:app_shipper/src/data/repositories/implements/banner_repo_impl.dart';
import 'package:app_shipper/src/data/repositories/implements/order_repo_impl.dart';
import 'package:app_shipper/src/data/repositories/order_repository.dart';

import '../../data/data_sources/remote/authentication_api.dart';
import '../../data/data_sources/remote/banner_ads_api.dart';
import '../../data/data_sources/remote/collab_api.dart';
import '../../data/data_sources/remote/noti_api.dart';
import '../../data/data_sources/remote/profile_api.dart';
import '../../data/repositories/authentication_repository.dart';
import '../../data/repositories/banner_repository.dart';
import '../../data/repositories/collaborate_repository.dart';
import '../../data/repositories/event_repository.dart';
import '../../data/repositories/implements/auth_repo_impl.dart';
import '../../data/repositories/implements/collab_repo_impl.dart';
import '../../data/repositories/implements/noti_repo_impl.dart';
import '../../data/repositories/implements/profile_repo_impl.dart';
import '../../data/repositories/notification_repository.dart';
import '../../data/repositories/profile_repository.dart';
import '../../features/event/event_view_model.dart';
import '../injection/injection.dart';

class RepositoryModules extends DIModule {
  @override
  Future<void> register() async {
    getIt.registerFactory<AuthenticationRepository>(
      () => AuthenRepoImpl(
        authenticationApi: getIt<AuthenticationApi>(),
      ),
    );
    getIt.registerFactory<BannerRepository>(
      () => BannerRepoImpl(
        bannerAdsApi: getIt<BannerAdsApi>(),
      ),
    );
    getIt.registerFactory<EventViewModel>(
          () => EventViewModel(
        eventRepository: getIt<EventRepository>(),
      ),
    );
    getIt.registerFactory<CollaborateRepository>(
      () => CollabRepoImpl(
        collabApi: getIt<CollabApi>(),
      ),
    );
    getIt.registerFactory<NotificationRepository>(
      () => NotiRepoImpl(
        notiApi: getIt<NotiApi>(),
      ),
    );
    getIt.registerFactory<ProfileRepository>(
      () => ProfileRepoImpl(
        profileApi: getIt<ProfileApi>(),
      ),
    );
    getIt.registerFactory<OrderRepository>(
      () => OrderRepoImpl(
        orderApi: getIt<OrderApi>(),
      ),
    );
  }
}

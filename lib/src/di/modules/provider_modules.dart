import 'package:app_shipper/src/base/app_view_model.dart';
import 'package:app_shipper/src/data/repositories/banner_repository.dart';
import 'package:app_shipper/src/data/repositories/implements/banner_repo_impl.dart';
import 'package:app_shipper/src/data/repositories/order_repository.dart';
import 'package:app_shipper/src/features/cancel_order/cancel_order_view_model.dart';
import 'package:app_shipper/src/features/detail_order/detail_order_view_model.dart';
import 'package:app_shipper/src/features/order/views/contact_view_model.dart';
import 'package:app_shipper/src/features/price_setting_ride_hailing/price_setting_ride_hailing_view_model.dart';
import 'package:app_shipper/src/features/statistic/statistic_view_model.dart';
import 'package:app_shipper/src/features/verify_account/verify_account_view_model.dart';
import 'package:app_shipper/src/shared/viewModels/banner_ads_view_model.dart';

import '../../data/data_sources/remote/banner_ads_api.dart';
import '../../data/data_sources/remote/event_api.dart';
import '../../data/repositories/authentication_repository.dart';
import '../../data/repositories/collaborate_repository.dart';
import '../../data/repositories/event_repository.dart';
import '../../data/repositories/implements/event_repo_impl.dart';
import '../../data/repositories/notification_repository.dart';
import '../../data/repositories/profile_repository.dart';
import '../../features/bought_customer/bought_customer_view_model.dart';
import '../../features/collaborate/collaborate_view_model.dart';
import '../../features/discount_product/discount_product_view_model.dart';
import '../../features/forget_password/forget_password_view_model.dart';
import '../../features/login/login_view_model.dart';
import '../../features/notifications/notification_view_model.dart';
import '../../features/payment/payment_view_model.dart';
import '../../features/profile/profile_view_model.dart';
import '../../features/register/register_view_model.dart';
import '../../features/store_recommend/store_recommend_view_model.dart';
import '../../features/update_info/update_info_view_model.dart';
import '../injection/injection.dart';

class ProviderModule extends DIModule {
  @override
  Future<void> register() async {
    getIt.registerFactory<AppViewModel>(
      () => AppViewModel(orderRepository: getIt<OrderRepository>()),
    );
    getIt.registerFactory<EventRepository>(
      () => EventRepoImpl(
        eventApi: getIt<EventApi>(),
      ),
    );
    getIt.registerLazySingleton<BannerAdsViewModel>(
      () => BannerAdsViewModel(
        bannerRepo: getIt<BannerRepository>(),
      ),
    );
    getIt.registerFactory<LoginViewModel>(
      () => LoginViewModel(
        authRepo: getIt<AuthenticationRepository>(),
      ),
    );
    getIt.registerFactory<RegisterViewModel>(
      () => RegisterViewModel(
        authRepo: getIt<AuthenticationRepository>(),
      ),
    );
    getIt.registerFactory<ForgetPasswordViewModel>(
      () => ForgetPasswordViewModel(
        authRepo: getIt<AuthenticationRepository>(),
      ),
    );
    getIt.registerFactory<CancelOrderViewModel>(
      () => CancelOrderViewModel(
        orderRepo: getIt<OrderRepository>(),
      ),
    );
    getIt.registerFactory<StoreRecommendViewModel>(
      () => StoreRecommendViewModel(
        collabRepo: getIt<CollaborateRepository>(),
      ),
    );
    getIt.registerFactory<DiscountProductViewModel>(
      () => DiscountProductViewModel(
        collabRepo: getIt<CollaborateRepository>(),
      ),
    );
    getIt.registerFactory<CollaborateViewModel>(
      () => CollaborateViewModel(
        collabRepo: getIt<CollaborateRepository>(),
      ),
    );
    getIt.registerFactory<BoughtCustomerViewModel>(
      () => BoughtCustomerViewModel(
        collabRepo: getIt<CollaborateRepository>(),
      ),
    );
    getIt.registerFactory<ProfileViewModel>(
      () => ProfileViewModel(
        profileRepo: getIt<ProfileRepository>(),
      ),
    );
    getIt.registerFactoryParam<PriceSettingRideHailingViewModel,ProfileRepository,
        bool>(
          (profileRepository,isGoiXe) => PriceSettingRideHailingViewModel(
            profileRepo: profileRepository,
        isGoiXe: isGoiXe,
      ),
    );
    getIt.registerFactory<NotificationViewModel>(
      () => NotificationViewModel(
        notiRepo: getIt<NotificationRepository>(),
      ),
    );
    getIt.registerFactory<UpdateInfoViewModel>(
      () => UpdateInfoViewModel(
        profileRepo: getIt<ProfileRepository>(),
      ),
    );
    getIt.registerFactory<VerifyAccountViewModel>(
      () => VerifyAccountViewModel(
        profileRepo: getIt<ProfileRepository>(),
      ),
    );
    getIt.registerFactory<PaymentViewModel>(
      () => PaymentViewModel(
        profileRepo: getIt<ProfileRepository>(),
      ),
    );
    getIt.registerLazySingleton<DetailOrderViewModel>(
      () => DetailOrderViewModel(
          orderRepo: getIt<OrderRepository>(),
          profileRepo: getIt<ProfileRepository>()),
    );
    getIt.registerFactory<StatisticViewModel>(
      () => StatisticViewModel(
        orderRepo: getIt<OrderRepository>(),
      ),
    );

    getIt.registerLazySingleton<ContactViewModel>(
          () => ContactViewModel(
            orderRepo: getIt<OrderRepository>(),
      ),
    );
  }
}

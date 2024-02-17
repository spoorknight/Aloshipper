import 'package:app_shipper/src/features/cancel_order/cancel_order_view_model.dart';
import 'package:app_shipper/src/features/cancel_order/cancel_screen.dart';
import 'package:app_shipper/src/features/info_user_drive/info_user_drive_screen.dart';
import 'package:app_shipper/src/features/statistic/statistic.dart';
import 'package:app_shipper/src/features/statistic/statistic_view_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../data/repositories/collaborate_repository.dart';
import '../data/repositories/event_repository.dart';
import '../data/repositories/order_repository.dart';
import '../data/repositories/profile_repository.dart';
import '../di/injection/injection.dart';
import '../features/bought_customer/bought_customer.dart';
import '../features/bought_customer/bought_customer_view_model.dart';
import '../features/collaborate/collaborate.dart';
import '../features/collaborate/collaborate_view_model.dart';
import '../features/deposit/deposit_screen.dart';
import '../features/deposit/payment_information.dart';
import '../features/detail_order/detail_driver_order.dart';
import '../features/discount_product/discount_product.dart';
import '../features/discount_product/discount_product_view_model.dart';
import '../features/event/event_view_model.dart';
import '../features/event/reward/histories_redeem_rewards_screen.dart';
import '../features/event/reward/invite_user_screen.dart';
import '../features/event/reward/list_store_share_screen.dart';
import '../features/event/reward/progress_of_friend.dart';
import '../features/event/reward/redeem_rewards_screen.dart';
import '../features/extend/extend_screen.dart';
import '../features/forget_password/forget_password_screen.dart';
import '../features/forget_password/forget_password_view_model.dart';
import '../features/list_user_bank_account/list_bank_screen.dart';
import '../features/list_user_bank_account/list_user_bank_account_screen.dart';
import '../features/list_user_bank_account/modify_bank_account_screen.dart';
import '../features/login/login_screen.dart';
import '../features/login/login_view_model.dart';
import '../features/main_screen/main_screen.dart';
import '../features/notifications/notification_view_model.dart';
import '../features/notifications/notifications_screen.dart';
import '../features/order/views/order_screen.dart';
import '../features/order/views/order_view_model.dart';
import '../features/payment/payment_view_model.dart';
import '../features/payment/sub_screen/qr_detail.dart';
import '../features/payment/withdraw_by_transfer_screen.dart';
import '../features/profile/profile_screen.dart';
import '../features/profile/profile_view_model.dart';
import '../features/register/register_screen.dart';
import '../features/register/register_view_model.dart';
import '../features/splash_screen/splash_screen.dart';
import '../features/store_recommend/store_recommend.dart';
import '../features/store_recommend/store_recommend_view_model.dart';
import '../features/update_info/update_info_screen.dart';
import '../features/update_info/update_info_view_model.dart';
import '../features/verify_account/verify_account_screen.dart';
import '../features/verify_account/verify_account_view_model.dart';
import 'routes.dart';

class AppNavigator {
  static final GlobalKey<NavigatorState> navigatorKey =
      GlobalKey<NavigatorState>();

  static Route? getRoute(RouteSettings settings) {
    switch (settings.name) {
      case Routes.splashScreen:
        return _buildRoute(
          settings,
          const SplashScreen(),
        );
      case Routes.loginScreen:
        return _buildRoute(
          settings,
          ChangeNotifierProvider(
            create: (context) => getIt<LoginViewModel>(),
            child: const LoginScreen(),
          ),
        );
      case Routes.registerScreen:
        return _buildRoute(
          settings,
          ChangeNotifierProvider(
            create: (context) => getIt<RegisterViewModel>(),
            child: const RegisterScreen(),
          ),
        );
      case Routes.forgetPasswordScreen:
        return _buildRoute(
          settings,
          ChangeNotifierProvider(
            create: (context) => getIt<ForgetPasswordViewModel>(),
            child: const ForgetPasswordScreen(),
          ),
        );

      case Routes.detailOrder:
        final arg = settings.arguments;
        final orderId =
            arg is Map ? (arg['orderId'] as String?) : (arg as String?);

        return _buildRoute(
          settings,
          ChangeNotifierProvider.value(
            value: detailOrderViewModel
              ..setOrderId(orderId)
              ..getDetailOrder(),
            child: DetailOrder(
                resetTime: arg is Map ? (arg['resetTime'] as int?) : null),
          ),
        );
      case Routes.cancelOrderScreen:
        return _buildRoute(
          settings,
          MultiProvider(
            providers: [
              ChangeNotifierProvider.value(
                value: detailOrderViewModel,
              ),
              ChangeNotifierProvider(
                create: (context) => getIt<CancelOrderViewModel>(),
              )
            ],
            child: const CancelOrderScreen(),
          ),
        );
      case Routes.recommendStore:
        return _buildRoute(
          settings,
          ChangeNotifierProvider(
            create: (context) => getIt<StoreRecommendViewModel>(),
            child: const StoreRecommendScreen(),
          ),
        );
      case Routes.boughtCustomer:
        return _buildRoute(
          settings,
          ChangeNotifierProvider(
            create: (context) => getIt<BoughtCustomerViewModel>(),
            child: const BoughtCustomerScreen(),
          ),
        );
      case Routes.discountProduct:
        return _buildRoute(
          settings,
          ChangeNotifierProvider(
            create: (context) => getIt<DiscountProductViewModel>(),
            child: const DiscountProductScreen(),
          ),
        );
      case Routes.mainScreen:
        return _buildRoute(
            settings,
            MultiProvider(
              providers: [
                ChangeNotifierProvider(
                  create: (context) => OrderViewModel(
                      orderRepository: getIt<OrderRepository>(),
                      profileRepository: getIt<ProfileRepository>()),
                  child: const OrderScreen(),
                ),
                ChangeNotifierProvider(
                  create: (context) => getIt<NotificationViewModel>(),
                  child: const NotificationsScreen(),
                ),
                ChangeNotifierProvider(
                  create: (context) => getIt<ProfileViewModel>(),
                  child: const ProfileScreen(),
                ),
                ChangeNotifierProvider(
                  create: (context) => CollaborateViewModel(
                      collabRepo: getIt<CollaborateRepository>()),
                  child: const CollaborateScreen(),
                ),
                ChangeNotifierProvider(
                  create: (context) =>
                      PaymentViewModel(profileRepo: getIt<ProfileRepository>()),
                  child: const CollaborateScreen(),
                ),
                ChangeNotifierProvider(
                  create: (context) => getIt<StatisticViewModel>(),
                  child: const Statistic(),
                ),
              ],
              child: const MainScreen(),
            ));
      case Routes.collaborateScreen:
        return _buildRoute(
          settings,
          ChangeNotifierProvider(
            create: (context) => CollaborateViewModel(
                collabRepo: getIt<CollaborateRepository>()),
            child: const CollaborateScreen(),
          ),
        );
      case Routes.updateProfile:
        return _buildRoute(
          settings,
          ChangeNotifierProvider(
            create: (context) => getIt<UpdateInfoViewModel>(),
            child: const UpdateInfoScreen(),
          ),
        );
      case Routes.infoUserDriveScreen:
        return _buildRoute(
          settings,
          ChangeNotifierProvider(
            create: (context) => OrderViewModel(
                orderRepository: getIt<OrderRepository>(),
                profileRepository: getIt<ProfileRepository>()),
            child: const InfoUserDriveScreen(),
          ),
        );
      case Routes.verifyAccount:
        return _buildRoute(
          settings,
          ChangeNotifierProvider(
            create: (context) => getIt<VerifyAccountViewModel>(),
            child: const VerifyAccountScreen(),
          ),
        );
      case Routes.paymentInformationScreen:
        final arg = settings.arguments as Map<String, dynamic>;
        return _buildRoute(
          settings,
          ChangeNotifierProvider(
            create: (context) =>
                PaymentViewModel(profileRepo: getIt<ProfileRepository>())
                  ..getInfoPayment(amount: arg['amount']),
            child: const PaymentInformationScreen(),
          ),
        );
      case Routes.depositScreen:
        return _buildRoute(
          settings,
          ChangeNotifierProvider(
            create: (context) =>
                PaymentViewModel(profileRepo: getIt<ProfileRepository>()),
            child: const DepositScreen(),
          ),
        );
      case Routes.withdrawByTransferScreen:
        return _buildRoute(
          settings,
          ChangeNotifierProvider(
            create: (context) =>
                PaymentViewModel(profileRepo: getIt<ProfileRepository>())
                  ..getBanks()
                  ..getUserBanksInfo(),
            child: const WithdrawByTransferScreen(),
          ),
        );
      case Routes.listUserBankAccountScreen:
        return _buildRoute(
          settings,
          ChangeNotifierProvider(
            create: (context) =>
                PaymentViewModel(profileRepo: getIt<ProfileRepository>())
                  ..getBanks()
                  ..getUserBanksInfo(),
            child: const ListUserBankAccountScreen(),
          ),
        );
      case Routes.modifyBankAccountScreen:
        final arg = settings.arguments as Map<String, dynamic>;
        PaymentViewModel viewModel = arg['viewModel'];
        return _buildRoute(
          settings,
          ChangeNotifierProvider.value(
            value: viewModel
              ..setBankNeedEdit(
                  arg.containsKey('bankAccount') ? arg['bankAccount'] : null),
            child: const ModifyBankAccountScreen(),
          ),
        );
      case Routes.listBankScreen:
        final arg = settings.arguments as Map<String, dynamic>;
        PaymentViewModel viewModel = arg['viewModel'];
        return _buildRoute(
          settings,
          ChangeNotifierProvider.value(
            value: viewModel..getBanks(),
            child: const ListBankScreen(),
          ),
        );
      case Routes.qrDetail:
        final arg = settings.arguments as String?;
        return _buildRoute(settings, QRDetail(url: arg));

      case Routes.redeemRewardsScreen:
        return _buildRoute(
          settings,
          ChangeNotifierProvider.value(
            value: eventViewModel..getPointRedemptionVouchers(),
            child: const RedeemRewardsScreen(),
          ),
        );
      case Routes.inviteUserScreen:
        final arg = settings.arguments as Map;
        return _buildRoute(
          settings,
          ChangeNotifierProvider.value(
            value: eventViewModel,
            child: InviteUserScreen(
              title: arg['title'] ?? 'Chia sẻ bạn bè',
            ),
          ),
        );
      case Routes.historiesRedeemRewardScreen:
        return _buildRoute(
          settings,
          ChangeNotifierProvider.value(
            value: eventViewModel
              ..getMissionHistories()
              ..getPointsExchangeHistories(),
            child: const HistoriesRedeemRewardScreen(),
          ),
        );
      case Routes.progressOfFriendScreen:
        return _buildRoute(
          settings,
          ChangeNotifierProvider(
            create: (context) =>
                EventViewModel(eventRepository: getIt<EventRepository>())
                  ..getProgressOfFriends(),
            child: const ProgressOfFriendScreen(),
          ),
        );
      case Routes.listStoresScreen:
        return _buildRoute(
          settings,
          ChangeNotifierProvider.value(
            value: eventViewModel..getStoresPurchasedSharePackage(),
            child: const ListStoresShareScreen(),
          ),
        );
      case Routes.extendScreen:
        final arg = settings.arguments as Map;
        final profileViewModel = arg['profileViewModel'] as ProfileViewModel;
        return _buildRoute(
          settings,
          MultiProvider(
            providers: [
              ChangeNotifierProvider.value(
                  value: profileViewModel..initGoiDichVu()),
              ChangeNotifierProvider.value(value: eventViewModel),
            ],
            child:  ExtendScreen(showAppBar: true),
          ),
        );

      default:
        return null;
    }
  }

  static MaterialPageRoute _buildRoute(
    RouteSettings routeSettings,
    Widget builder,
  ) {
    return MaterialPageRoute(
      builder: (context) => builder,
      settings: routeSettings,
    );
  }

  static Future push<T>(
    String route, {
    Object? arguments,
  }) {
    return state.pushNamed(route, arguments: arguments);
  }

  static Future pushAndRemoveUntil<T>(
    String route, {
    Object? arguments,
  }) {
    return state.pushNamedAndRemoveUntil(
      route,
      (route) => false,
      arguments: arguments,
    );
  }

  static Future replaceWith<T>(
    String route, {
    Map<String, dynamic>? arguments,
  }) {
    return state.pushReplacementNamed(route, arguments: arguments);
  }

  static void popUntil<T>(String route) {
    state.popUntil(ModalRoute.withName(route));
  }

  static Future popAndPush<T>(
    String route, {
    Map<String, dynamic>? arguments,
  }) {
    return state.popAndPushNamed(route, arguments: arguments);
  }

  static void pop([Object? arguments]) {
    if (canPop) {
      state.pop(arguments);
    }
  }

  static bool get canPop => state.canPop();

  static BuildContext? get context => navigatorKey.currentContext;

  static NavigatorState get state => navigatorKey.currentState!;
}

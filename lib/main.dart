import 'package:app_shipper/src/base/app_view_model.dart';
import 'package:app_shipper/src/di/modules/notification_modules.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:provider/provider.dart';
import 'package:sentry_flutter/sentry_flutter.dart';

import 'firebase_options.dart';
import 'src/app.dart';
import 'src/di/injection/injection.dart';
import 'src/utils/helpers/ad_helper.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    name: 'Aloshipper',
    options: DefaultFirebaseOptions.currentPlatform,
  );
  FirebaseMessaging.onBackgroundMessage(firebaseMessagingBackgroundHandler);
  customLoading();
  await Injection.inject();
  MobileAds.instance.initialize();
  MobileAds.instance.updateRequestConfiguration(
      RequestConfiguration(testDeviceIds: AdHelper.getListDeviceTest));

  await SentryFlutter.init((options) {
    options.dsn =
        'https://a6a26b0d0bc32d4099407d5f6b7ade70@o440638.ingest.sentry.io/4506133410217984';
    // Set tracesSampleRate to 1.0 to capture 100% of transactions for performance monitoring.
    // We recommend adjusting this value in production.
    options.tracesSampleRate = 1.0;
  }, appRunner: () {
    return SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp])
        .then((_) {
      runApp(
        MultiProvider(
          providers: [
            ChangeNotifierProvider(
              create: (BuildContext context) => getIt<AppViewModel>(),
            ),
          ],
          child: const MyApp(),
        ),
      );
    });
  });
}

void customLoading() {
  EasyLoading.instance
    ..displayDuration = const Duration(milliseconds: 2000)
    ..indicatorType = EasyLoadingIndicatorType.circle
    ..loadingStyle = EasyLoadingStyle.custom
    ..indicatorSize = 45.0
    ..radius = 10.0
    ..progressColor = Colors.transparent
    ..backgroundColor = Colors.transparent
    ..indicatorColor = Colors.green
    ..textColor = Colors.black
    ..userInteractions = false
    ..dismissOnTap = false
    ..maskType = EasyLoadingMaskType.black
    ..boxShadow = [const BoxShadow(color: Colors.white)];
}

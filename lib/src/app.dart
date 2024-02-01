import 'package:app_shipper/src/base/app_view_model.dart';
import 'package:app_shipper/src/di/injection/injection.dart';
import 'package:app_shipper/src/utils/app_enum.dart';
import 'package:app_shipper/src/utils/helpers/logger.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:provider/provider.dart';
import 'configs/config.dart';
import 'navigator/app_navigator.dart';
import 'navigator/routes.dart';

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> with WidgetsBindingObserver {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) async {
    switch (state) {
      case AppLifecycleState.inactive:
        Logger.d('AppLifecycleState', 'inactive');
        // appData.updateToaDo();
        break;
      case AppLifecycleState.resumed:
        Logger.d('AppLifecycleState', 'Resumed');
        appData.checkUpdate(context);
        appData.updateToaDo();
        appData.autoUpdateLocation();
        break;
      case AppLifecycleState.paused:
        Logger.d('AppLifecycleState', 'paused');
        break;
      case AppLifecycleState.detached:
        Logger.d('AppLifecycleState', 'detached');
        break;
      default:
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(360, 800),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) {
        return Consumer<AppViewModel>(builder: (context, viewModel, child) {
          return GestureDetector(
            onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
            child: MaterialApp(
              theme: AppTheme.themeData,
              builder: EasyLoading.init(),
              initialRoute: Routes.splashScreen,
              debugShowCheckedModeBanner: false,
              onGenerateRoute: AppNavigator.getRoute,
              navigatorKey: AppNavigator.navigatorKey,
            ),
          );
        });
      },
    );
  }
}

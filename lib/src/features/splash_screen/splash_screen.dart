import 'dart:io';

import 'package:app_shipper/src/di/injection/injection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';

import '../../configs/config.dart';
import '../../navigator/app_navigator.dart';
import '../../navigator/routes.dart';
import '../../utils/helpers/logger.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  SplashScreenState createState() => SplashScreenState();
}

class SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    navigator();
  }

  Future navigator() async {
    try {
      if (Platform.isIOS) await appData.checkCanPayment();
      await appData.getAppSharing();
    } catch (e) {
      Logger.d('CHECK PAYMENT >>>', e);
    }
    Future.delayed(const Duration(seconds: 1), () async {
      AppNavigator.pushAndRemoveUntil(Routes.loginScreen, arguments: 0);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Palette.red,
      body: SizedBox(
        height: 1.sh,
        child: Stack(
          children: [
            Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Spacer(),
                Center(
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(150.r),
                    child: Container(
                      padding: EdgeInsets.only(
                          left: 12.w, top: 5.h, right: 5.w, bottom: 5.h),
                      alignment: Alignment.center,
                      width: 170.h,
                      height: 170.h,
                      color: Palette.white,
                      child: Assets.images.logo.image(),
                    ),
                  ),
                ),
                const Spacer(),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 30.w),
                  child: Assets.images.anToanGt.image(width: 280.w),
                ),
                const Spacer(),
                BoxConst.h(300)
              ],
            ),
            Positioned(
              bottom: -0.5.sw,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(1000000),
                child: Container(
                  width: 1.sw,
                  height: 1.sw,
                  color: Palette.white,
                  child: Center(
                    child: Container(
                      margin: EdgeInsets.only(bottom: 200.w),
                      width: 0.4.sw,
                      child: Assets.images.icSearchLocation.image(),
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

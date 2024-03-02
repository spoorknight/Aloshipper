import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

import '../../base/base_view_model.dart';
import '../../configs/app_constants.dart';
import '../../data/repositories/authentication_repository.dart';
import '../../di/injection/injection.dart';
import '../../navigator/app_navigator.dart';
import '../../navigator/routes.dart';
import '../../shared/show_toast.dart';
import '../../utils/helpers/logger.dart';

class LoginViewModel extends BaseViewModel {
  final AuthenticationRepository authRepo;

  LoginViewModel({required this.authRepo}) : super() {
    _getRememberMe();
  }

  final TextEditingController accountController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  bool isRemember = true;

  void login() async {
    EasyLoading.show();
    try {
      appData.firebaseToken = await FirebaseMessaging.instance.getToken() ?? '';
      Logger.d('Firebase Token', appData.firebaseToken);
      final res = await authRepo.login(
        accountController.text,
        passwordController.text,
        appData.firebaseToken,
      );
      if (res.status == true) {
        appData.tokenLogin = res.tokenlogin ?? '';
        appData.userId = res.memberId ?? '';
        appData.isExpire = res.expire ?? false;
        appData.isBan = res.isAutoBanned ?? false;
        await appData.checkCanPayment(res.plan?.userId ?? "");
        _setRememberMe();

        Logger.d('TOKEN LOGIN', appData.tokenLogin);
        ShowToast.success(res.mess);
        EasyLoading.dismiss();
        appData.autoUpdateLocation();
        AppNavigator.pushAndRemoveUntil(Routes.mainScreen);
      } else {
        EasyLoading.dismiss();
        ShowToast.error(res.mess ?? res.item);
      }
    } catch (e) {
      EasyLoading.dismiss();
      Logger.d('LOGIN >>>', e);
    }
  }

  void toggleRemember() {
    isRemember = !isRemember;
    notifyListeners();
  }

  void _getRememberMe() async {
    // isRemember = dataManager.getBool(AppConstants.rememberMe);
    if (isRemember) {
      accountController.text = dataManager.getString(AppConstants.userName);
      passwordController.text = dataManager.getString(AppConstants.password);
      login();
    }
  }

  void _setRememberMe() async {
    try {
      await dataManager.setBool(AppConstants.rememberMe, isRemember);
      if (isRemember) {
        await dataManager.setString(
            AppConstants.userName, accountController.text);
        await dataManager.setString(
            AppConstants.password, passwordController.text);
      } else {
        await dataManager.removeValue(AppConstants.userName);
        await dataManager.removeValue(AppConstants.password);
      }
    } catch (e) {
      Logger.d('SET REMEMBER ME >>>', e);
    }
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

import '../../base/base_view_model.dart';
import '../../data/repositories/authentication_repository.dart';
import '../../di/injection/injection.dart';
import '../../navigator/app_navigator.dart';
import '../../navigator/routes.dart';
import '../../shared/show_toast.dart';
import '../../utils/helpers/logger.dart';

class ForgetPasswordViewModel extends BaseViewModel {
  final AuthenticationRepository authRepo;

  ForgetPasswordViewModel({required this.authRepo}) : super();
  final TextEditingController emailController = TextEditingController();

  void forgetPassword() async {
    EasyLoading.show();
    try {
      final res = await authRepo.forgetPassword(
        null,
        appData.firebaseToken,
        emailController.text,
      );
      if (res.status == true) {
        ShowToast.success(res.mess);
        EasyLoading.dismiss();
        AppNavigator.pushAndRemoveUntil(Routes.loginScreen);
      } else {
        EasyLoading.dismiss();
        ShowToast.error(res.mess ?? res.item);
      }
    } catch (e) {
      Logger.d('AUTO GIA HAN >>>', e);
      EasyLoading.dismiss();
    }
  }
}

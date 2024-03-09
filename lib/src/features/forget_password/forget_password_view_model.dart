import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:otp_text_field/otp_text_field.dart';
import '../../base/base_view_model.dart';

import '../../data/repositories/authentication_repository.dart';
import '../../navigator/routes.dart';
import '../../shared/dialog.dart';
import '../../shared/show_toast.dart';
import '../../navigator/app_navigator.dart';
import '../../utils/app_enum.dart';
import '../../utils/helpers/logger.dart';

class ForgetPasswordViewModel extends BaseViewModel {
  final AuthenticationRepository authRepo;

  ForgetPasswordViewModel({required this.authRepo}) : super();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();

  StreamController<int> countdownController = StreamController<int>();
  OtpFieldController otpController = OtpFieldController();
  String otpValue = '';
  bool isActiveButton = false;
  Timer? _timer;
  final int timeCountDown = 120;
  int _countdown = 120;
  bool _isCountingDown = false;

  String? errorOTPMess;

  final TextEditingController passController = TextEditingController();
  final TextEditingController confirmPassController = TextEditingController();

  String get getPhoneNum => phoneController.text.trim().toString();

  String get getPass => passController.text.trim().toString();

  String get getConfirmPass => confirmPassController.text.trim().toString();

  Future<void> forgetPasswordByEmail() async {
    EasyLoading.show();
    final res = await authRepo.forgetPassword(
      emailController.text,
    );
    if (res.checkStatusSuccess) {
      ShowToast.success(res.mess);
      EasyLoading.dismiss();
      AppNavigator.pop();
    } else {
      EasyLoading.dismiss();
      ShowToast.error(res.mess ?? res.item);
    }
  }

  void onCompletedOTP(String value) {
    isActiveButton = true;
    otpValue = value;
    notifyListeners();
  }

  void onChangedOTP(String? text) {
    otpValue = text ?? '';
    if (isActiveButton && (text?.length ?? 0) < 6) {
      isActiveButton = false;
      notifyListeners();
    }
  }

  void countdown() {
    if (!_isCountingDown && _countdown == timeCountDown) {
      try {
        _isCountingDown = true;
        countdownController.add(timeCountDown);

        _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
          if (_countdown > 0 && _isCountingDown) {
            _countdown--;
            countdownController.add(_countdown);
          } else {
            _timer?.cancel();
            _countdown = timeCountDown;
            _isCountingDown = false;
          }
        });
      } catch (e) {
        Logger.d('send otp error', e.toString());
        EasyLoading.showError("Có lỗi, vui lòng thử lại");
      } finally {
        EasyLoading.dismiss();
      }
    }
  }

  Future<void> reSendOTP() async {
    EasyLoading.show();
    try {
      errorOTPMess = null;
      final res = await authRepo.sendSMS(
        getPhoneNum,
        OTPType.forgot_password.name,
      );
      if (res.checkStatusSuccess) {
        ShowToast.success(res.getMess);
        countdown();
      } else {
        if (res.exceededTimes == true) {
          showDialog(
            context: AppNavigator.context!,
            builder: (context) {
              return DialogWarningExceedTime(
                desc: res.getMess,
                phoneNum: res.hotline,
              );
            },
          );
        } else {
          ShowToast.error(res.getMess);
        }
      }
    } catch (e) {
      ShowToast.error('Vui lòng thử lại');
    } finally {
      EasyLoading.dismiss();
    }
  }

  Future<void> checkValidOTP() async {
    EasyLoading.show();
    try {
      final res = await authRepo.checkValidOTP(
          getPhoneNum, otpValue, OTPType.forgot_password.name);
      if (res.checkStatusSuccess) {
        errorOTPMess = null;
        AppNavigator.push(Routes.changePassScreen, arguments: this);
      } else {
        errorOTPMess = res.getMess;
      }
    } catch (e) {
      errorOTPMess = 'Vui lòng thử lại';
    } finally {
      EasyLoading.dismiss();
      notifyListeners();
    }
  }

  Future<void> forgotPasswordWithOTP() async {
    EasyLoading.show();
    try {
      final res = await authRepo.forgotPasswordWithOTP(
        getPhoneNum,
        getPass,
        getConfirmPass,
        otpValue,
      );
      if (res.checkStatusSuccess) {
        AppNavigator.push(Routes.registerSuccess, arguments: {
          'title': 'Chúc mừng',
          'message':
              'Bạn đã cập nhật mật khẩu thành công. Vui lòng đăng nhập lại!',
        });
      } else {
        ShowToast.error(res.getMess);
      }
    } catch (e) {
      ShowToast.error('Vui lòng thử lại');
    } finally {
      EasyLoading.dismiss();
      notifyListeners();
    }
  }

  Future<void> forgetPasswordByPhoneNum() async {
    EasyLoading.show();
    try {
      errorOTPMess = null;
      isActiveButton = false;
      countdownController = StreamController<int>();

      _countdown = timeCountDown;

      final res = await authRepo.sendSMS(
        getPhoneNum,
        OTPType.forgot_password.name,
      );
      if (res.checkStatusSuccess) {
        ShowToast.success(res.getMess);
        AppNavigator.push(Routes.otpResetPassScreen, arguments: this);
        countdown();
      } else {
        if (res.exceededTimes == true) {
          showDialog(
            context: AppNavigator.context!,
            builder: (context) {
              return DialogWarningExceedTime(
                desc: res.getMess,
                phoneNum: res.hotline,
              );
            },
          );
        } else {
          ShowToast.error(res.getMess);
        }
      }
    } catch (e) {
      ShowToast.error('Vui lòng thử lại');
    } finally {
      EasyLoading.dismiss();
    }
  }
}

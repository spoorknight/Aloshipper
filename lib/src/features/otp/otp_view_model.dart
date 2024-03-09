import 'dart:async';

import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:otp_text_field/otp_text_field.dart';

import '../../base/base_view_model.dart';
import '../../data/repositories/authentication_repository.dart';
import '../../models/shared_models/base_model.dart';
import '../../navigator/app_navigator.dart';
import '../../navigator/routes.dart';
import '../../utils/app_enum.dart';
import '../../utils/helpers/logger.dart';

class OTPViewModel extends BaseViewModel {
  final AuthenticationRepository authRepo;

  OTPViewModel({required this.authRepo}) : super();

  OtpFieldController otpController = OtpFieldController();
  String otpValue = '';
  bool isActiveButton = false;

  StreamController countdownController = StreamController<int>();
  Timer? _timer;
  final int timeCountDown = 120;
  int _countdown = 120;
  bool _isCountingDown = false;

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

  Future<void> submitForm(
    String phone,
    String password,
    String passwordConfirm,
    String code,
    String fullName,
    String? codeInvite,
  ) async {
    try {
      EasyLoading.show();
      final res = await authRepo.registerWithPhoneNumber(
          phone, password, passwordConfirm, code, fullName, codeInvite);
      if (res.status == true) {
        AppNavigator.push(Routes.registerSuccess);
      } else {
        EasyLoading.showError(res.mess ?? "Có lỗi, vui lòng thử lại");
      }
    } catch (e) {
      Logger.d('submit form error', e.toString());
      EasyLoading.showError("Có lỗi, vui lòng thử lại");
    } finally {
      EasyLoading.dismiss();
    }
  }

  Future<void> sendOTP(String phoneNumber, {bool isSendOtp = false}) async {
    if (!_isCountingDown && _countdown == timeCountDown) {
      try {
        late BaseModel res;
        if (!isSendOtp) {
          EasyLoading.show();
          res = await authRepo.sendSMS(
            phoneNumber,
            OTPType.register.name,
          );
        } else {
          res = const BaseModel(status: true);
        }

        if (res.status == true) {
          _isCountingDown = true;
          countdownController.add(timeCountDown);

          _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
            if (_countdown > 0 && _isCountingDown) {
              _countdown--;
              countdownController.add(_countdown);
            } else {
              _timer?.cancel();
              _timer?.cancel();
              _countdown = timeCountDown;
              _isCountingDown = false;
            }
          });
        } else {
          EasyLoading.showError(res.mess ?? "Có lỗi, vui lòng thử lại");
        }
      } catch (e) {
        Logger.d('send otp error', e.toString());
        EasyLoading.showError("Có lỗi, vui lòng thử lại");
      } finally {
        EasyLoading.dismiss();
      }
    }
  }

  @override
  void dispose() {
    countdownController.close();
    _timer?.cancel();
    super.dispose();
  }
}

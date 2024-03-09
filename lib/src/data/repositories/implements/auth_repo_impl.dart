import '../../../models/login_model.dart';
import '../../../models/register_model.dart';
import '../../../models/shared_models/base_model.dart';
import '../../data_sources/remote/authentication_api.dart';
import '../authentication_repository.dart';

class AuthenRepoImpl implements AuthenticationRepository {
  final AuthenticationApi authenticationApi;

  const AuthenRepoImpl({required this.authenticationApi});

  @override
  Future<LoginModel> login(String email, String password, String device_token) {
    return authenticationApi.login(email, password, device_token);
  }

  @override
  Future<RegisterModel> requestOpenShipper(
      String? tokenlogin,
      String device_token,
      String fullname,
      String username,
      String password,
      String password2,
      String phoneNumber,
      String email) {
    return authenticationApi.requestOpenShipper(tokenlogin, device_token,
        fullname, username, password, password2, phoneNumber, email);
  }

  @override
  Future<BaseModel> forgetPassword(String email) {
    return authenticationApi.forgetPassword(email);
  }

  @override
  Future<BaseModel> registerWithPhoneNumber(String phoneNumber, String password,
      String confirmPassword, String code, String fullName, String? codeInvite) async {
    return authenticationApi.registerWithPhoneNumber(
        phoneNumber, password, confirmPassword, code, fullName, codeInvite);
  }

  @override
  Future<BaseModel> sendSMS(String phone, String type) async {
    return authenticationApi.sendSMS(phone, type);
  }

  @override
  Future<BaseModel> checkValidOTP(String phone, String code, String type) {
    return authenticationApi.checkValidOTP(phone, code, type);
  }

  @override
  Future<BaseModel> forgotPasswordWithOTP(String phone, String password, String confirmPassword, String code) {
    return authenticationApi.forgotPasswordWithOTP(phone, password, code, confirmPassword);
  }
}

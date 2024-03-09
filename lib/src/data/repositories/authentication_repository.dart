import '../../models/login_model.dart';
import '../../models/register_model.dart';
import '../../models/shared_models/base_model.dart';

abstract class AuthenticationRepository {
  Future<LoginModel> login(String email, String password, String device_token);

  Future<RegisterModel> requestOpenShipper(
    String? tokenlogin,
    String device_token,
    String fullname,
    String username,
    String password,
    String password2,
    String phoneNumber,
    String email,
  );

  Future<BaseModel> forgetPassword(
    String email,
  );

  Future<BaseModel> checkValidOTP(String phone, String code, String type);

  Future<BaseModel> forgotPasswordWithOTP(String phone, String password, String confirmPassword, String code);

  Future<BaseModel> sendSMS(String phone, String type);

  Future<BaseModel> registerWithPhoneNumber(String phoneNumber, String password,
      String confirmPassword, String code, String fullName, String? codeInvite);
}

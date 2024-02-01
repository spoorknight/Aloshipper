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
  Future<BaseModel> forgetPassword(
      String? tokenlogin, String device_token, String email) {
    return authenticationApi.forgetPassword(tokenlogin, device_token, email);
  }
}

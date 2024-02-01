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
    String? tokenlogin,
    String device_token,
    String email,
  );
}

import 'package:dio/dio.dart';
import 'package:retrofit/http.dart';

import '../../../models/login_model.dart';
import '../../../models/register_model.dart';
import '../../../models/shared_models/base_model.dart';
import '../../../network/api_path.dart';

part 'authentication_api.g.dart';

@RestApi()
abstract class AuthenticationApi {
  factory AuthenticationApi(Dio dio, {String baseUrl}) = _AuthenticationApi;

  @POST(ApiPath.loginMember)
  @MultiPart()
  Future<LoginModel> login(
    @Part(name: 'email') String email,
    @Part(name: 'password') String password,
    @Part(name: 'device_token') String device_token,
  );

  @POST(ApiPath.requestOpenShipper)
  @MultiPart()
  Future<RegisterModel> requestOpenShipper(
    @Part(name: 'tokenlogin') String? tokenlogin,
    @Part(name: 'device_token') String device_token,
    @Part(name: 'fullname') String fullname,
    @Part(name: 'username') String username,
    @Part(name: 'password') String password,
    @Part(name: 'password2') String password2,
    @Part(name: 'phone_number') String phone_number,
    @Part(name: 'email') String email,
  );

  @POST(ApiPath.fotgetPasswordMember)
  @MultiPart()
  Future<BaseModel> forgetPassword(
    @Part(name: 'email') String email,
  );

  @POST(ApiPath.sendSMS)
  @MultiPart()
  Future<BaseModel> sendSMS(
      @Part(name: 'phone') String phone,
      @Part(name: 'type') String type,
      );

  @POST(ApiPath.registerWithPhoneNumberv2)
  @MultiPart()
  Future<BaseModel> registerWithPhoneNumber(
      @Part(name: 'phone_number') String phoneNumber,
      @Part(name: 'password') String password,
      @Part(name: 'confirm_password') String confirmPassword,
      @Part(name: 'code') String code,
      @Part(name: 'full_name') String fullName,
      @Part(name: 'ref_id') String? codeInvite,
      );

  @POST(ApiPath.checkValidOTP)
  @MultiPart()
  Future<BaseModel> checkValidOTP(
      @Part(name: 'phone_number') String phone,
      @Part(name: 'code') String code,
      @Part(name: 'type') String type,
      );

  @POST(ApiPath.forgotPasswordWithOTP)
  @MultiPart()
  Future<BaseModel> forgotPasswordWithOTP(
      @Part(name: 'phone_number') String phone,
      @Part(name: 'password') String password,
      @Part(name: 'code') String code,
      @Part(name: 'confirm_password') String confirmPassword,
      );
}

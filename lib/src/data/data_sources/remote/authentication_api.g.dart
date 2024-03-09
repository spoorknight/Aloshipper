// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'authentication_api.dart';

// **************************************************************************
// RetrofitGenerator
// **************************************************************************

// ignore_for_file: unnecessary_brace_in_string_interps,no_leading_underscores_for_local_identifiers

class _AuthenticationApi implements AuthenticationApi {
  _AuthenticationApi(
    this._dio, {
    this.baseUrl,
  });

  final Dio _dio;

  String? baseUrl;

  @override
  Future<LoginModel> login(
    email,
    password,
    device_token,
  ) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    final _data = FormData();
    _data.fields.add(MapEntry(
      'email',
      email,
    ));
    _data.fields.add(MapEntry(
      'password',
      password,
    ));
    _data.fields.add(MapEntry(
      'device_token',
      device_token,
    ));
    final _result = await _dio
        .fetch<Map<String, dynamic>>(_setStreamType<LoginModel>(Options(
      method: 'POST',
      headers: _headers,
      extra: _extra,
      contentType: 'multipart/form-data',
    )
            .compose(
              _dio.options,
              'LoginShipper',
              queryParameters: queryParameters,
              data: _data,
            )
            .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = LoginModel.fromJson(_result.data!);
    return value;
  }

  @override
  Future<RegisterModel> requestOpenShipper(
    tokenlogin,
    device_token,
    fullname,
    username,
    password,
    password2,
    phone_number,
    email,
  ) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    queryParameters.removeWhere((k, v) => v == null);
    final _headers = <String, dynamic>{};
    final _data = FormData();
    if (tokenlogin != null) {
      _data.fields.add(MapEntry(
        'tokenlogin',
        tokenlogin,
      ));
    }
    _data.fields.add(MapEntry(
      'device_token',
      device_token,
    ));
    _data.fields.add(MapEntry(
      'fullname',
      fullname,
    ));
    _data.fields.add(MapEntry(
      'username',
      username,
    ));
    _data.fields.add(MapEntry(
      'password',
      password,
    ));
    _data.fields.add(MapEntry(
      'password2',
      password2,
    ));
    _data.fields.add(MapEntry(
      'phone_number',
      phone_number,
    ));
    _data.fields.add(MapEntry(
      'email',
      email,
    ));
    final _result = await _dio
        .fetch<Map<String, dynamic>>(_setStreamType<RegisterModel>(Options(
      method: 'POST',
      headers: _headers,
      extra: _extra,
      contentType: 'multipart/form-data',
    )
            .compose(
              _dio.options,
              'RequestOpenShipper',
              queryParameters: queryParameters,
              data: _data,
            )
            .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = RegisterModel.fromJson(_result.data!);
    return value;
  }

  @override
  Future<BaseModel> forgetPassword(email) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    final _data = FormData();
    _data.fields.add(MapEntry(
      'email',
      email,
    ));
    final _result = await _dio
        .fetch<Map<String, dynamic>>(_setStreamType<BaseModel>(Options(
      method: 'POST',
      headers: _headers,
      extra: _extra,
      contentType: 'multipart/form-data',
    )
            .compose(
              _dio.options,
              'fotgetPasswordMember',
              queryParameters: queryParameters,
              data: _data,
            )
            .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = BaseModel.fromJson(_result.data!);
    return value;
  }

  @override
  Future<BaseModel> sendSMS(
    phone,
    type,
  ) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    final _data = FormData();
    _data.fields.add(MapEntry(
      'phone',
      phone,
    ));
    _data.fields.add(MapEntry(
      'type',
      type,
    ));
    final _result = await _dio
        .fetch<Map<String, dynamic>>(_setStreamType<BaseModel>(Options(
      method: 'POST',
      headers: _headers,
      extra: _extra,
      contentType: 'multipart/form-data',
    )
            .compose(
              _dio.options,
              'sendSMS',
              queryParameters: queryParameters,
              data: _data,
            )
            .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = BaseModel.fromJson(_result.data!);
    return value;
  }

  @override
  Future<BaseModel> registerWithPhoneNumber(
    phoneNumber,
    password,
    confirmPassword,
    code,
    fullName,
    codeInvite,
  ) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    queryParameters.removeWhere((k, v) => v == null);
    final _headers = <String, dynamic>{};
    final _data = FormData();
    _data.fields.add(MapEntry(
      'phone_number',
      phoneNumber,
    ));
    _data.fields.add(MapEntry(
      'password',
      password,
    ));
    _data.fields.add(MapEntry(
      'confirm_password',
      confirmPassword,
    ));
    _data.fields.add(MapEntry(
      'code',
      code,
    ));
    _data.fields.add(MapEntry(
      'full_name',
      fullName,
    ));
    if (codeInvite != null) {
      _data.fields.add(MapEntry(
        'ref_id',
        codeInvite,
      ));
    }
    final _result = await _dio
        .fetch<Map<String, dynamic>>(_setStreamType<BaseModel>(Options(
      method: 'POST',
      headers: _headers,
      extra: _extra,
      contentType: 'multipart/form-data',
    )
            .compose(
              _dio.options,
              'registerWithPhoneNumberv2',
              queryParameters: queryParameters,
              data: _data,
            )
            .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = BaseModel.fromJson(_result.data!);
    return value;
  }

  @override
  Future<BaseModel> checkValidOTP(
    phone,
    code,
    type,
  ) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    final _data = FormData();
    _data.fields.add(MapEntry(
      'phone_number',
      phone,
    ));
    _data.fields.add(MapEntry(
      'code',
      code,
    ));
    _data.fields.add(MapEntry(
      'type',
      type,
    ));
    final _result = await _dio
        .fetch<Map<String, dynamic>>(_setStreamType<BaseModel>(Options(
      method: 'POST',
      headers: _headers,
      extra: _extra,
      contentType: 'multipart/form-data',
    )
            .compose(
              _dio.options,
              'checkValidOTP',
              queryParameters: queryParameters,
              data: _data,
            )
            .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = BaseModel.fromJson(_result.data!);
    return value;
  }

  @override
  Future<BaseModel> forgotPasswordWithOTP(
    phone,
    password,
    code,
    confirmPassword,
  ) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    final _data = FormData();
    _data.fields.add(MapEntry(
      'phone_number',
      phone,
    ));
    _data.fields.add(MapEntry(
      'password',
      password,
    ));
    _data.fields.add(MapEntry(
      'code',
      code,
    ));
    _data.fields.add(MapEntry(
      'confirm_password',
      confirmPassword,
    ));
    final _result = await _dio
        .fetch<Map<String, dynamic>>(_setStreamType<BaseModel>(Options(
      method: 'POST',
      headers: _headers,
      extra: _extra,
      contentType: 'multipart/form-data',
    )
            .compose(
              _dio.options,
              'forgotPasswordWithOTP',
              queryParameters: queryParameters,
              data: _data,
            )
            .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = BaseModel.fromJson(_result.data!);
    return value;
  }

  RequestOptions _setStreamType<T>(RequestOptions requestOptions) {
    if (T != dynamic &&
        !(requestOptions.responseType == ResponseType.bytes ||
            requestOptions.responseType == ResponseType.stream)) {
      if (T == String) {
        requestOptions.responseType = ResponseType.plain;
      } else {
        requestOptions.responseType = ResponseType.json;
      }
    }
    return requestOptions;
  }
}

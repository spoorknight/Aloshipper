// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'noti_api.dart';

// **************************************************************************
// RetrofitGenerator
// **************************************************************************

// ignore_for_file: unnecessary_brace_in_string_interps,no_leading_underscores_for_local_identifiers

class _NotiApi implements NotiApi {
  _NotiApi(
    this._dio, {
    this.baseUrl,
  });

  final Dio _dio;

  String? baseUrl;

  @override
  Future<ListNotificationModel> getListNotification(
    tokenlogin,
    device_token,
    page,
    per_page,
  ) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    final _data = FormData();
    _data.fields.add(MapEntry(
      'tokenlogin',
      tokenlogin,
    ));
    _data.fields.add(MapEntry(
      'device_token',
      device_token,
    ));
    _data.fields.add(MapEntry(
      'page',
      page.toString(),
    ));
    _data.fields.add(MapEntry(
      'per_page',
      per_page.toString(),
    ));
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<ListNotificationModel>(Options(
      method: 'POST',
      headers: _headers,
      extra: _extra,
      contentType: 'multipart/form-data',
    )
            .compose(
              _dio.options,
              'getListThongBaoV2',
              queryParameters: queryParameters,
              data: _data,
            )
            .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = ListNotificationModel.fromJson(_result.data!);
    return value;
  }

  @override
  Future<ListNewModel> getListNew(
    tokenlogin,
    page,
    per_page,
    read_type,
  ) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    final _data = FormData();
    _data.fields.add(MapEntry(
      'token',
      tokenlogin,
    ));
    _data.fields.add(MapEntry(
      'page',
      page.toString(),
    ));
    _data.fields.add(MapEntry(
      'per_page',
      per_page.toString(),
    ));
    _data.fields.add(MapEntry(
      'read_type',
      read_type,
    ));
    final _result = await _dio
        .fetch<Map<String, dynamic>>(_setStreamType<ListNewModel>(Options(
      method: 'POST',
      headers: _headers,
      extra: _extra,
      contentType: 'multipart/form-data',
    )
            .compose(
              _dio.options,
              'getNews',
              queryParameters: queryParameters,
              data: _data,
            )
            .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = ListNewModel.fromJson(_result.data!);
    return value;
  }

  @override
  Future<CountUnreadNewModel> countUnReadNew(tokenlogin) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    final _data = FormData();
    _data.fields.add(MapEntry(
      'token',
      tokenlogin,
    ));
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<CountUnreadNewModel>(Options(
      method: 'POST',
      headers: _headers,
      extra: _extra,
      contentType: 'multipart/form-data',
    )
            .compose(
              _dio.options,
              'countUnreadNotification',
              queryParameters: queryParameters,
              data: _data,
            )
            .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = CountUnreadNewModel.fromJson(_result.data!);
    return value;
  }

  @override
  Future<dynamic> readNew(
    tokenlogin,
    noti_id,
  ) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    final _data = FormData();
    _data.fields.add(MapEntry(
      'token',
      tokenlogin,
    ));
    _data.fields.add(MapEntry(
      'noti_id',
      noti_id,
    ));
    final _result = await _dio.fetch(_setStreamType<dynamic>(Options(
      method: 'POST',
      headers: _headers,
      extra: _extra,
      contentType: 'multipart/form-data',
    )
        .compose(
          _dio.options,
          'readNotification',
          queryParameters: queryParameters,
          data: _data,
        )
        .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = _result.data;
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

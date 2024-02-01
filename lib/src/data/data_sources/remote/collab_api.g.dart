// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'collab_api.dart';

// **************************************************************************
// RetrofitGenerator
// **************************************************************************

// ignore_for_file: unnecessary_brace_in_string_interps,no_leading_underscores_for_local_identifiers

class _CollabApi implements CollabApi {
  _CollabApi(
    this._dio, {
    this.baseUrl,
  });

  final Dio _dio;

  String? baseUrl;

  @override
  Future<CollaborateInfoModel> getCollbabInfo(
    tokenlogin,
    device_token,
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
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<CollaborateInfoModel>(Options(
      method: 'POST',
      headers: _headers,
      extra: _extra,
      contentType: 'multipart/form-data',
    )
            .compose(
              _dio.options,
              'getInfoTaiKhoanHopTac',
              queryParameters: queryParameters,
              data: _data,
            )
            .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = CollaborateInfoModel.fromJson(_result.data!);
    return value;
  }

  @override
  Future<ListBoughtCustomerModel> getBoughtCustomer(
    tokenlogin,
    device_token,
    page,
    per_page,
    date,
    status,
  ) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    queryParameters.removeWhere((k, v) => v == null);
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
    if (date != null) {
      _data.fields.add(MapEntry(
        'date',
        date,
      ));
    }
    if (status != null) {
      _data.fields.add(MapEntry(
        'status',
        status,
      ));
    }
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<ListBoughtCustomerModel>(Options(
      method: 'POST',
      headers: _headers,
      extra: _extra,
      contentType: 'multipart/form-data',
    )
            .compose(
              _dio.options,
              'getListHoaHongSanPham',
              queryParameters: queryParameters,
              data: _data,
            )
            .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = ListBoughtCustomerModel.fromJson(_result.data!);
    return value;
  }

  @override
  Future<ListDiscountProductModel> getListDiscountProduct(
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
        _setStreamType<ListDiscountProductModel>(Options(
      method: 'POST',
      headers: _headers,
      extra: _extra,
      contentType: 'multipart/form-data',
    )
            .compose(
              _dio.options,
              'getListSanPhamDangChiecKhau',
              queryParameters: queryParameters,
              data: _data,
            )
            .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = ListDiscountProductModel.fromJson(_result.data!);
    return value;
  }

  @override
  Future<ListStoreRecommendModel> getListStoreRecommend(
    tokenlogin,
    device_token,
    page,
    per_page,
    date,
    status,
  ) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    queryParameters.removeWhere((k, v) => v == null);
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
    if (date != null) {
      _data.fields.add(MapEntry(
        'date',
        date,
      ));
    }
    if (status != null) {
      _data.fields.add(MapEntry(
        'status',
        status,
      ));
    }
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<ListStoreRecommendModel>(Options(
      method: 'POST',
      headers: _headers,
      extra: _extra,
      contentType: 'multipart/form-data',
    )
            .compose(
              _dio.options,
              'getListHoaHongMoShopApi',
              queryParameters: queryParameters,
              data: _data,
            )
            .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = ListStoreRecommendModel.fromJson(_result.data!);
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

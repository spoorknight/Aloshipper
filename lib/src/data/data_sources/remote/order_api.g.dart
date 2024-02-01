// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'order_api.dart';

// **************************************************************************
// RetrofitGenerator
// **************************************************************************

// ignore_for_file: unnecessary_brace_in_string_interps,no_leading_underscores_for_local_identifiers

class _OrderApi implements OrderApi {
  _OrderApi(
    this._dio, {
    this.baseUrl,
  });

  final Dio _dio;

  String? baseUrl;

  @override
  Future<DetailOrderModel> getDetailOrderShipperById(
    tokenlogin,
    device_token,
    order_id,
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
      'order_id',
      order_id.toString(),
    ));
    final _result = await _dio
        .fetch<Map<String, dynamic>>(_setStreamType<DetailOrderModel>(Options(
      method: 'POST',
      headers: _headers,
      extra: _extra,
      contentType: 'multipart/form-data',
    )
            .compose(
              _dio.options,
              'getDetailOrderById',
              queryParameters: queryParameters,
              data: _data,
            )
            .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = DetailOrderModel.fromJson(_result.data!);
    return value;
  }

  @override
  Future<ResponseCancelOrderModel> getCancelReasons() async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    final Map<String, dynamic>? _data = null;
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<ResponseCancelOrderModel>(Options(
      method: 'GET',
      headers: _headers,
      extra: _extra,
    )
            .compose(
              _dio.options,
              'getCancelReasons',
              queryParameters: queryParameters,
              data: _data,
            )
            .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = ResponseCancelOrderModel.fromJson(_result.data!);
    return value;
  }

  @override
  Future<BaseModel> updateStatusOrderByShipper(
    tokenlogin,
    device_token,
    order_id,
    order_status,
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
      'order_id',
      order_id.toString(),
    ));
    _data.fields.add(MapEntry(
      'order_status',
      order_status,
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
              'UpdateStatusOrderByShipperNew',
              queryParameters: queryParameters,
              data: _data,
            )
            .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = BaseModel.fromJson(_result.data!);
    return value;
  }

  @override
  Future<BaseModel> setOnlineActive(
    tokenlogin,
    device_token,
    active,
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
      'active',
      active.toString(),
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
              'ShopOnlineActive',
              queryParameters: queryParameters,
              data: _data,
            )
            .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = BaseModel.fromJson(_result.data!);
    return value;
  }

  @override
  Future<ListOrderModel> getListCompletedOrdersShipper(
    tokenlogin,
    device_token,
    date,
    date_to,
    page,
    per_page,
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
    if (date != null) {
      _data.fields.add(MapEntry(
        'date',
        date,
      ));
    }
    if (date_to != null) {
      _data.fields.add(MapEntry(
        'date_to',
        date_to,
      ));
    }
    _data.fields.add(MapEntry(
      'page',
      page.toString(),
    ));
    _data.fields.add(MapEntry(
      'per_page',
      per_page.toString(),
    ));
    final _result = await _dio
        .fetch<Map<String, dynamic>>(_setStreamType<ListOrderModel>(Options(
      method: 'POST',
      headers: _headers,
      extra: _extra,
      contentType: 'multipart/form-data',
    )
            .compose(
              _dio.options,
              'getListCompletedOrdersShipper',
              queryParameters: queryParameters,
              data: _data,
            )
            .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = ListOrderModel.fromJson(_result.data!);
    return value;
  }

  @override
  Future<BaseModel> cancelOrder(
    tokenlogin,
    device_token,
    order_id,
    reason,
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
      'order_id',
      order_id.toString(),
    ));
    _data.fields.add(MapEntry(
      'lydohuy',
      reason,
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
              'ShipperHuyDonHangNew',
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

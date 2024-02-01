// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'event_api.dart';

// **************************************************************************
// RetrofitGenerator
// **************************************************************************

// ignore_for_file: unnecessary_brace_in_string_interps,no_leading_underscores_for_local_identifiers

class _EventApi implements EventApi {
  _EventApi(
    this._dio, {
    this.baseUrl,
  });

  final Dio _dio;

  String? baseUrl;

  @override
  Future<ReferFriendResponse> getReferFriends(tokenlogin) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    final _data = FormData();
    _data.fields.add(MapEntry(
      'tokenlogin',
      tokenlogin,
    ));
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<ReferFriendResponse>(Options(
      method: 'POST',
      headers: _headers,
      extra: _extra,
      contentType: 'multipart/form-data',
    )
            .compose(
              _dio.options,
              'getReferFriends',
              queryParameters: queryParameters,
              data: _data,
            )
            .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = ReferFriendResponse.fromJson(_result.data!);
    return value;
  }

  @override
  Future<StoreForShareResponse> getStoresPurchasedSharePackage(
    tokenlogin,
    page,
    myLatitude,
    myLongtitude,
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
      'page',
      page.toString(),
    ));
    _data.fields.add(MapEntry(
      'my_latitude',
      myLatitude.toString(),
    ));
    _data.fields.add(MapEntry(
      'my_longtitude',
      myLongtitude.toString(),
    ));
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<StoreForShareResponse>(Options(
      method: 'POST',
      headers: _headers,
      extra: _extra,
      contentType: 'multipart/form-data',
    )
            .compose(
              _dio.options,
              'getStoresPurchasedSharePackage',
              queryParameters: queryParameters,
              data: _data,
            )
            .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = StoreForShareResponse.fromJson(_result.data!);
    return value;
  }

  @override
  Future<BaseModel> addGiftForReferFriendMission(tokenlogin) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    final _data = FormData();
    _data.fields.add(MapEntry(
      'tokenlogin',
      tokenlogin,
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
              'gift/addGiftForReferFriendMission',
              queryParameters: queryParameters,
              data: _data,
            )
            .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = BaseModel.fromJson(_result.data!);
    return value;
  }

  @override
  Future<BaseModel> checkValidAdViews(tokenlogin) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    final _data = FormData();
    _data.fields.add(MapEntry(
      'tokenlogin',
      tokenlogin,
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
              'checkValidAdViews',
              queryParameters: queryParameters,
              data: _data,
            )
            .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = BaseModel.fromJson(_result.data!);
    return value;
  }

  @override
  Future<BaseModel> exchangePointsToGift(
    tokenlogin,
    valueTransfer,
    type,
    voucherId,
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
      'value',
      valueTransfer,
    ));
    _data.fields.add(MapEntry(
      'type',
      type,
    ));
    _data.fields.add(MapEntry(
      'voucher_id',
      voucherId,
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
              'exchangePointsToGift',
              queryParameters: queryParameters,
              data: _data,
            )
            .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = BaseModel.fromJson(_result.data!);
    return value;
  }

  @override
  Future<VoucherTransfersResponse> getPointRedemptionVouchers(
      tokenlogin) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    final _data = FormData();
    _data.fields.add(MapEntry(
      'tokenlogin',
      tokenlogin,
    ));
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<VoucherTransfersResponse>(Options(
      method: 'POST',
      headers: _headers,
      extra: _extra,
      contentType: 'multipart/form-data',
    )
            .compose(
              _dio.options,
              'getAlotodayVouchers',
              queryParameters: queryParameters,
              data: _data,
            )
            .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = VoucherTransfersResponse.fromJson(_result.data!);
    return value;
  }

  @override
  Future<ExchangePointResponse> getPointsExchangeHistories(
    tokenlogin,
    page,
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
      'page',
      page.toString(),
    ));
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<ExchangePointResponse>(Options(
      method: 'POST',
      headers: _headers,
      extra: _extra,
      contentType: 'multipart/form-data',
    )
            .compose(
              _dio.options,
              'gift/getPointsExchangeHistories',
              queryParameters: queryParameters,
              data: _data,
            )
            .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = ExchangePointResponse.fromJson(_result.data!);
    return value;
  }

  @override
  Future<BaseModel> giftExchangePointsToMoney(
    tokenlogin,
    valueExchange,
    type,
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
      'value',
      valueExchange.toString(),
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
              'exchangePointsToMoneyOrDay',
              queryParameters: queryParameters,
              data: _data,
            )
            .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = BaseModel.fromJson(_result.data!);
    return value;
  }

  @override
  Future<MissionResponse> giftGetDailyMissions(
    tokenlogin,
    appName,
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
      'app_name',
      appName,
    ));
    final _result = await _dio
        .fetch<Map<String, dynamic>>(_setStreamType<MissionResponse>(Options(
      method: 'POST',
      headers: _headers,
      extra: _extra,
      contentType: 'multipart/form-data',
    )
            .compose(
              _dio.options,
              'getDailyMissions',
              queryParameters: queryParameters,
              data: _data,
            )
            .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = MissionResponse.fromJson(_result.data!);
    return value;
  }

  @override
  Future<HistoryMissionResponse> giftGetMissionHistories(
    tokenlogin,
    page,
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
      'page',
      page.toString(),
    ));
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<HistoryMissionResponse>(Options(
      method: 'POST',
      headers: _headers,
      extra: _extra,
      contentType: 'multipart/form-data',
    )
            .compose(
              _dio.options,
              'getMissionHistories',
              queryParameters: queryParameters,
              data: _data,
            )
            .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = HistoryMissionResponse.fromJson(_result.data!);
    return value;
  }

  @override
  Future<CustomerPointInfoResponse> giftPointsInfo(tokenlogin) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    final _data = FormData();
    _data.fields.add(MapEntry(
      'tokenlogin',
      tokenlogin,
    ));
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<CustomerPointInfoResponse>(Options(
      method: 'POST',
      headers: _headers,
      extra: _extra,
      contentType: 'multipart/form-data',
    )
            .compose(
              _dio.options,
              'gift/pointsInfo',
              queryParameters: queryParameters,
              data: _data,
            )
            .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = CustomerPointInfoResponse.fromJson(_result.data!);
    return value;
  }

  @override
  Future<BaseModel> createCheckIn(
    tokenlogin,
    rewardRecipientId,
    missionId,
    giftType,
    adsUserId,
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
      'reward_recipient_id',
      rewardRecipientId,
    ));
    _data.fields.add(MapEntry(
      'mission_id',
      missionId,
    ));
    _data.fields.add(MapEntry(
      'gift_type',
      giftType,
    ));
    if (adsUserId != null) {
      _data.fields.add(MapEntry(
        'ads_user_id',
        adsUserId,
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
              'gift/create',
              queryParameters: queryParameters,
              data: _data,
            )
            .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = BaseModel.fromJson(_result.data!);
    return value;
  }

  @override
  Future<BaseModel> doneAdvertising(
    tokenlogin,
    adId,
    adType,
    giftType,
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
      'ad_id',
      adId,
    ));
    _data.fields.add(MapEntry(
      'ad_type',
      adType,
    ));
    _data.fields.add(MapEntry(
      'gift_type',
      giftType,
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
              'ad/create',
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

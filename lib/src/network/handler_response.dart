import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

class ResponseInterceptor extends Interceptor {
  @override
  void onError(DioError err, ErrorInterceptorHandler handler) async {
    super.onError(err, handler);
    if (err.type == DioErrorType.connectionTimeout) {
      EasyLoading.showError(
          "Không thể kết nối tới máy chủ,\n vui lòng thử lại");
    } else if (err.type == DioErrorType.receiveTimeout) {
      EasyLoading.showError("Kết nối mạng kém,\n vui lòng thử lại");
    } else if (err.type == DioErrorType.badResponse) {
      if (err.response?.statusCode == 406) {
        EasyLoading.showError(
            "Phiên đăng nhập hết hạn, vui lòng đăng nhập lại");
      }
    } else if (err.type == DioErrorType.unknown) {
      if (err.message?.contains('Failed host lookup') ?? false) {
        EasyLoading.showError("Không tìm thấy máy chủ, vui lòng đăng nhập lại");
      } else {
        EasyLoading.showError("Có lỗi, vui lòng thử lại");
      }
    }
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) async {
    if (response.statusCode == 406 || response.statusCode == 401) {
      // if (AppProvider.instance.limitAgain <= 3) {
      //   AppProvider.instance.limitAgain ++;
      //   await checkLogin(response, handler);
      // }
    } else {
      handler.next(response);
    }
  }

  @override
  void onRequest(
      RequestOptions options, RequestInterceptorHandler handler) async {
    // if (appData.tokenLogin != null) {
    //   options.headers['Authorization'] =
    //       'Bearer ${appData.tokenLogin}';
    // } else {
    options.headers["Authorization"] =
        "Basic ${base64Encode(utf8.encode('CIwiFtn8QMfIq2MNJqU8Q2lBOhKzpTTIdBBABC:7e81d3234f34dd11f98087d1e8ba103f'))}";
    // }
    return handler.next(options);
  }
}

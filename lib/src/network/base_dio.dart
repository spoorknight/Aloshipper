import 'dart:async';

import 'package:app_shipper/src/di/injection/injection.dart';
import 'package:dio/dio.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

import '../utils/helpers/logger.dart';
import 'handler_response.dart';

class BaseDio {
  static FutureOr<Dio> setup() async {
    final options = BaseOptions(
      receiveDataWhenStatusError: true,
      responseType: ResponseType.json,
      baseUrl: appData.getUrl,
      receiveTimeout: const Duration(seconds: 30),
      connectTimeout: const Duration(seconds: 30),
      validateStatus: (status) {
        return true;
      },
    );
    final dio = Dio(options);

    dio.interceptors.add(
      PrettyDioLogger(
        requestHeader: false,
        requestBody: true,
        responseBody: true,
        responseHeader: false,
        error: true,
        compact: true,
        maxWidth: 100,
        logPrint: Logger.devLog,
      ),
    );
    dio.interceptors.add(ResponseInterceptor());

    return dio;
  }
}

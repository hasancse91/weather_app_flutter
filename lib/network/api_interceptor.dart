import 'package:dio/dio.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';
import 'package:weather_app_flutter/config/build_config.dart';

List<Interceptor> getInterceptors() {
  return [_getPrettyLoggerInterceptor(), _getAppIdQueryParameterInterceptor()];
}

PrettyDioLogger _getPrettyLoggerInterceptor() {
  return PrettyDioLogger(requestHeader: true, responseHeader: true);
}

_getAppIdQueryParameterInterceptor() {
  var interceptor = InterceptorsWrapper(onRequest: (options, handler) {
    options.queryParameters.addAll(
      {'appid': BuildConfig.instance.config.appId},
    );

    return handler.next(options);
  });

  return interceptor;
}
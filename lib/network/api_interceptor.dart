import 'package:dio/dio.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

List<Interceptor> getInterceptors() {
  return [_getPrettyLoggerInterceptor(), _getAppIdQueryParameterInterceptor()];
}

PrettyDioLogger _getPrettyLoggerInterceptor() {
  return PrettyDioLogger(requestHeader: true, responseHeader: true);
}

_getAppIdQueryParameterInterceptor() {
  var interceptor = InterceptorsWrapper(onRequest: (options, handler) {
    options.queryParameters
        .addAll({'appid': 'd450a4a574372bd12f2fa308bf3cf15a'});

    return handler.next(options);
  });

  return interceptor;
}

import 'package:dio/dio.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

List<Interceptor> getInterceptors() {
  return [
    _getPrettyLoggerInterceptor(),
  ];
}

PrettyDioLogger _getPrettyLoggerInterceptor() {
  return PrettyDioLogger(requestHeader: true, responseHeader: true);
}

import 'package:dio/dio.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

List<Interceptor> getInterceptors() {
  List<Interceptor> interceptors = List.empty();

  interceptors.add(_getPrettyLoggerInterceptor());

  return interceptors;
}

PrettyDioLogger _getPrettyLoggerInterceptor() {
  return PrettyDioLogger(requestHeader: true, responseHeader: true);
}

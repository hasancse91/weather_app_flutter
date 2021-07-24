import 'package:dio/dio.dart';
import 'package:weather_app_flutter/network/api_interceptor.dart';

class DioClient {
  static final DioClient _dioClient = DioClient._internal();
  late Dio _dio;

  factory DioClient() {
    return _dioClient;
  }

  Dio get client => _dio;

  DioClient._internal() {
    var options = BaseOptions(
      baseUrl: 'http://api.openweathermap.org/data/2.5',
      connectTimeout: 5000,
      receiveTimeout: 3000,
    );

    _dio = Dio(options);
    _dio.interceptors.addAll(getInterceptors());
  }
}

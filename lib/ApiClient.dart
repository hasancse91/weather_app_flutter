import "package:dio/dio.dart";

import 'ApiInterceptors.dart';

class ApiClient {
  Dio init() {
    Dio _dio = new Dio();
    _dio.interceptors.add(new ApiInterceptors());
    // _dio.options.baseUrl = "http://api.openweathermap.org/data/2.5";
    _dio.options.baseUrl = "https://www.google.com.bd/";
    return _dio;
  }
}

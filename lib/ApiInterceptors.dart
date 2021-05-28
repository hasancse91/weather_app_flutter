import 'package:dio/dio.dart';

class ApiInterceptors extends Interceptor {
  @override
  Future<dynamic> onRequest(
      RequestOptions options, RequestInterceptorHandler handler) async {
    const appId = 'd450a4a574372bd12f2fa308bf3cf15a';
    options.queryParameters = {'appid': appId};
    return options;
  }

  @override
  Future<dynamic> onError(DioError err, ErrorInterceptorHandler handler) async {
    print("Error interceptor: ${err.message}");
  }

  @override
  Future<dynamic> onResponse(
      Response response, ResponseInterceptorHandler handler) async {
    print("Response interceptor: ${response.data}");
  }
}

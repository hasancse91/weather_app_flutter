import 'package:dio/dio.dart';

class ApiBaseHelper {
  static final String url = 'http://google.com/';
  static BaseOptions opts = BaseOptions(
    baseUrl: url,
    responseType: ResponseType.json,
    connectTimeout: 30000,
    receiveTimeout: 30000,
  );

  static Dio createDio() {
    return Dio(opts);
  }

  // static Dio addInterceptors(Dio dio) {
  //   return dio
  //     ..interceptors.add(
  //       InterceptorsWrapper(
  //           onRequest: (RequestOptions options) => requestInterceptor(options),
  //           onError: (DioError e) async {
  //             return e.response.data;
  //           }),
  //     );
  // }
  static Dio addInterceptors(Dio dio) {
    return dio
      ..interceptors.add(
        InterceptorsWrapper(
            onRequest: (options, handler) => requestInterceptor(options)),
      );
  }

  static dynamic requestInterceptor(RequestOptions options) async {
    const appId = 'd450a4a574372bd12f2fa308bf3cf15a';
    options.headers.addAll({"appid": "$appId"});
    return options;
  }

  static final dio = createDio();
  static final baseAPI = addInterceptors(dio);

  Future<Response> getWeatherInfo(int cityId) async {
    String urlPath = "weather";
    print("City ID: $cityId");
    try {
      Response response =
          await baseAPI.get(urlPath, queryParameters: {'id': cityId});
      print("Response: $response");
      return response;
    } on DioError catch (e) {
      // Handle error
      print("Error: ${e.message}");
    }
  }

  Future<Response> getHTTP(String url) async {
    try {
      Response response = await baseAPI.get(url);
      return response;
    } on DioError catch (e) {
      // Handle error
    }
  }

  Future<Response> postHTTP(String url, dynamic data) async {
    try {
      Response response = await baseAPI.post(url, data: data);
      return response;
    } on DioError catch (e) {
      // Handle error
    }
  }

  Future<Response> putHTTP(String url, dynamic data) async {
    try {
      Response response = await baseAPI.put(url, data: data);
      return response;
    } on DioError catch (e) {
      // Handle error
    }
  }

  Future<Response> deleteHTTP(String url) async {
    try {
      Response response = await baseAPI.delete(url);
      return response;
    } on DioError catch (e) {
      // Handle error
    }
  }
}

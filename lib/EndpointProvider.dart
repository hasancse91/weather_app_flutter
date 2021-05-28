import 'dart:convert';

import 'package:dio/dio.dart';

class EndpointProvider {
  Dio _client;

  EndpointProvider(this._client);

  Future<String> getWeatherInfo(int cityId) async {
    try {
      print("TRY block");
      final response =
          await _client.get('/weather', queryParameters: {'id': cityId});
      print(response);
      // It's better to return a Model class instead but this is
      // only for example purposes only
      return json.decode(response.data).toString();
    } on DioError catch (ex) {
      // Assuming there will be an errorMessage property in the JSON object
      String errorMessage = json.decode(ex.response.toString())["errorMessage"];
      print("DioError: $errorMessage");
      throw new Exception(errorMessage);
    }
  }
}

import 'package:dio/dio.dart';
import 'package:logger/logger.dart';
import 'package:weather_app_flutter/network/WeatherApi.dart';
import 'package:weather_app_flutter/network/api_interceptor.dart';
import 'package:weather_app_flutter/ui/home/model/weather_data.dart';
import 'package:weather_app_flutter/ui/home/model/weather_response.dart';

class WeatherApiImpl implements WeatherApi {
  var logger = Logger();

  @override
  Future<WeatherData>? getWeatherInfo(int? cityId) {
    return _getWeather(cityId);
  }

  Future<WeatherData> _getWeather(int? cityId) async {
    try {
      var dio = Dio();
      dio.interceptors.addAll(getInterceptors());

      var response = await dio.get(
        'http://api.openweathermap.org/data/2.5/weather',
        queryParameters: {
          'id': cityId,
          'appid': 'd450a4a574372bd12f2fa308bf3cf15a'
        },
      );

      logger.i("Response body JSON:\n$response");

      WeatherResponse weatherResponse = WeatherResponse.fromJson(response.data);
      WeatherData weatherData = weatherResponse.toWeatherData();

      return Future.value(weatherData);
    } catch (e) {
      throw e;
    }
  }
}
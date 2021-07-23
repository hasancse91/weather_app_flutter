import 'package:dio/dio.dart';
import 'package:logger/logger.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';
import 'package:weather_app_flutter/network/WeatherApi.dart';
import 'package:weather_app_flutter/ui/home/model/weather_data.dart';
import 'package:weather_app_flutter/ui/home/model/weather_response.dart';

class WeatherApiImpl implements WeatherApi {
  var logger = Logger();

  @override
  Future<WeatherData>? getWeatherInfo(int? cityId) {
    logger.d("Method called");

    return getWeather(cityId);
  }

  Future<WeatherData> getWeather(int? cityId) async {
    try {
      var dio = Dio();
      dio.interceptors
          .add(PrettyDioLogger(requestHeader: true, responseHeader: true));
      var response = await dio.get(
        'http://api.openweathermap.org/data/2.5/weather',
        queryParameters: {
          'id': cityId,
          'appid': 'd450a4a574372bd12f2fa308bf3cf15a'
        },
      );

      logger.d(response);

      return Future.value(
          WeatherResponse.fromJson(response.data).toWeatherData());
    } catch (e) {
      logger.e(e);
      throw e;
    }
  }
}
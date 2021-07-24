import 'package:logger/logger.dart';
import 'package:weather_app_flutter/network/WeatherApi.dart';
import 'package:weather_app_flutter/network/dio_client.dart';
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
      var dioClient = DioClient().client;
      var response = await dioClient.get(
        '/weather',
        queryParameters: {'id': cityId},
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

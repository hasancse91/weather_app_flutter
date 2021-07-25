import 'package:weather_app_flutter/config/build_config.dart';
import 'package:weather_app_flutter/network/WeatherApi.dart';
import 'package:weather_app_flutter/network/dio_client.dart';
import 'package:weather_app_flutter/ui/home/model/weather_data.dart';
import 'package:weather_app_flutter/ui/home/model/weather_response.dart';

class WeatherApiImpl extends WeatherApi {
  var logger = BuildConfig.instance.config.logger;

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
      return weatherData;
    } catch (e) {
      throw e;
    }
  }
}

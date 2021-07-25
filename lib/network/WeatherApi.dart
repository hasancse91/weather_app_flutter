import 'package:weather_app_flutter/ui/home/model/weather_data.dart';

abstract class WeatherApi {
  Future<WeatherData>? getWeatherInfo(int? cityId);
}

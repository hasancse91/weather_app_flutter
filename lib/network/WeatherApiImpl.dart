import 'package:dio/dio.dart';
import 'package:logger/logger.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';
import 'package:weather_app_flutter/network/WeatherApi.dart';
import 'package:weather_app_flutter/ui/home/weather.dart';

class WeatherApiImpl implements WeatherApi {
  var logger = Logger();

  @override
  Weather? getWeatherInfo(int? cityId) {
    logger.d("Method called");

    getWeather(cityId);

    return Weather(
        weatherLastUpdatedTime: "07 July, 2021 - 10:00 AM",
        temperature: "30",
        weatherDescription: "Haze",
        weatherDescriptionIcon:
            "https://static.thenounproject.com/png/778835-200.png",
        location: "Dhaka, BD",
        humidity: "75%",
        pressure: "65bLD",
        visibility: "120 M",
        sunriseTime: "05:16 AM",
        sunsetTime: "06:50 PM");
  }

  void getWeather(int? cityId) async {
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
    } catch (e) {
      print("Error: $e}");
    }
  }
}

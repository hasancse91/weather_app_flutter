import 'package:flutter/material.dart';
import 'package:weather_app_flutter/ui/home/widget/item_weather_property.dart';

class WeatherProperty extends StatelessWidget {
  final String humidity;
  final String pressure;
  final String visibility;

  const WeatherProperty({
    Key? key,
    required this.humidity,
    required this.pressure,
    required this.visibility,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ItemWeatherProperty(label: "Humidity", value: humidity),
        ItemWeatherProperty(label: "Pressure", value: pressure),
        ItemWeatherProperty(label: "Visibility", value: visibility)
      ],
    );
  }
}
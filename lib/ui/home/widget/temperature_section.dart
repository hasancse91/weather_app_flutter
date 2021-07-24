import 'package:flutter/material.dart';
import 'package:weather_app_flutter/core/text_style.dart';

class TemperatureSection extends StatelessWidget {
  final String dateTime;
  final String temperature;
  final String iconUrl;
  final String description;
  final String cityAndCountry;

  const TemperatureSection({
    Key? key,
    required this.dateTime,
    required this.temperature,
    required this.iconUrl,
    required this.description,
    required this.cityAndCountry,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(dateTime, style: valueTextStyle),
        _getTemperatureRow(),
        Text(cityAndCountry, style: titleTextStyle)
      ],
    );
  }

  _getTemperatureRow() {
    return Row(
      children: <Widget>[
        Text(temperature, style: extraLargeTitleTextStyle),
        Text('°C', style: TextStyle(fontSize: 35, color: Colors.teal)),
        Spacer(),
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.network(iconUrl, width: 60, height: 60),
            Text(description),
          ],
        )
      ],
    );
  }
}

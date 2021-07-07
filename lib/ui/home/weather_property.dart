import 'package:flutter/material.dart';
import 'package:weather_app_flutter/core/text_style.dart';

class WeatherProperty extends StatelessWidget {
  final String label;
  final String value;

  const WeatherProperty({
    Key? key,
    required this.label,
    required this.value,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 4, bottom: 4),
      child: Row(children: [
        Text(label, style: labelTextStyle),
        SizedBox(width: 24),
        Text(value, style: valueTextStyle),
      ]),
    );
  }
}

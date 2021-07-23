import 'package:flutter/material.dart';
import 'package:weather_app_flutter/ui/home/widget/Item_sun_time.dart';

class SunTime extends StatelessWidget {
  final String sunrise;
  final String sunset;

  const SunTime({
    Key? key,
    required this.sunrise,
    required this.sunset,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        ItemSunTime(
          label: "Sunrise",
          value: sunrise,
          imagePath: 'images/sunrise.png',
        ),
        ItemSunTime(
          label: "Sunset",
          value: sunset,
          imagePath: 'images/sunset.png',
        ),
      ],
    );
  }
}

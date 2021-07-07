import 'package:flutter/material.dart';
import 'package:weather_app_flutter/core/text_style.dart';

class SunTimeTable extends StatelessWidget {
  final String label;
  final String value;
  final String imagePath;

  const SunTimeTable({
    Key? key,
    required this.label,
    required this.value,
    required this.imagePath,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(label, style: labelTextStyle),
        Container(
          child: Image.asset(
            imagePath,
            width: 100,
            height: 100,
          ),
          margin: EdgeInsets.only(top: 12.0, bottom: 12.0),
        ),
        Text(value, style: valueTextStyle),
      ],
    );
  }
}

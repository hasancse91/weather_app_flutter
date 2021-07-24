import 'package:flutter/material.dart';
import 'package:weather_app_flutter/config/build_config.dart';
import 'package:weather_app_flutter/config/env_config.dart';
import 'package:weather_app_flutter/config/environment.dart';

import 'ui/home/view/HomePage.dart';

void main() {
  EnvConfig prodConfig = EnvConfig(
    appName: 'Weather Forecast - Flutter',
    baseUrl: 'http://api.openweathermap.org/data/2.5',
    appId: 'd450a4a574372bd12f2fa308bf3cf15a',
  );
  BuildConfig.instantiate(
    envType: Environment.DEVELOPMENT,
    envConfig: prodConfig,
  );
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: BuildConfig.instance.config.appName,
      theme: ThemeData(primarySwatch: Colors.teal),
      home: HomePage(title: BuildConfig.instance.config.appName),
    );
  }
}

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:logger/logger.dart';
import 'package:weather_app_flutter/config/build_config.dart';
import 'package:weather_app_flutter/config/env_config.dart';

import 'ui/home/view/HomePage.dart';

Future<void> main() async {
  var logger = Logger();
  WidgetsFlutterBinding.ensureInitialized();
  try {
    EnvConfig config = await getConfig();
    BuildConfig.instantiate(envConfig: config);
    runApp(MyApp());
  } catch (e) {
    logger.e(e);
  }
}

class MyApp extends StatelessWidget {
  final String appTitle = 'Weather App - Flutter';

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: appTitle,
      theme: ThemeData(primarySwatch: Colors.teal),
      home: HomePage(title: appTitle),
    );
  }
}

Future<EnvConfig> getConfig() async {
  try {
    String configString = await rootBundle.loadString('assets/config.json');
    final configJson = await json.decode(configString) as Map<String, dynamic>;

    return EnvConfig(
      baseUrl: configJson['baseUrl'],
      appId: configJson['appId'],
    );
  } catch (e) {
    throw Exception('$e\nLocal configuration fetch failed. To create '
        '`config.json` properly, please flow the instruction from README.md: '
        'https://github.com/hasancse91/weather_app_flutter');
  }
}
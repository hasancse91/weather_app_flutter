import 'package:weather_app_flutter/config/env_config.dart';

class BuildConfig {
  late final EnvConfig config;
  bool _lock = false;

  static final BuildConfig instance = BuildConfig._internal();

  BuildConfig._internal();

  factory BuildConfig.instantiate({
    required EnvConfig envConfig,
  }) {
    if (instance._lock) return instance;

    instance.config = envConfig;
    instance._lock = true;

    return instance;
  }
}

class Weather {
  String weatherLastUpdatedTime;
  String temperature;
  String weatherDescription;
  String weatherDescriptionIcon;
  String location;
  String humidity;
  String pressure;
  String visibility;
  String sunriseTime;
  String sunsetTime;

  Weather({
    required this.weatherLastUpdatedTime,
    required this.temperature,
    required this.weatherDescription,
    required this.weatherDescriptionIcon,
    required this.location,
    required this.humidity,
    required this.pressure,
    required this.visibility,
    required this.sunriseTime,
    required this.sunsetTime,
  });
}

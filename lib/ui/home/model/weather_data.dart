class WeatherData {
  String dateTime;
  String temperature;
  String cityAndCountry;
  String weatherConditionIconUrl;
  String weatherConditionIconDescription;
  String humidity;
  String pressure;
  String visibility;
  String sunrise;
  String sunset;

  WeatherData({
    required this.dateTime,
    required this.temperature,
    required this.cityAndCountry,
    required this.weatherConditionIconUrl,
    required this.weatherConditionIconDescription,
    required this.humidity,
    required this.pressure,
    required this.visibility,
    required this.sunrise,
    required this.sunset,
  });
}

import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';
import 'package:weather_app_flutter/core/text_style.dart';
import 'package:weather_app_flutter/ui/home/City.dart';
import 'package:weather_app_flutter/ui/home/sun_time_table.dart';
import 'package:weather_app_flutter/ui/home/weather.dart';
import 'package:weather_app_flutter/ui/home/weather_property.dart';

class HomePage extends StatefulWidget {
  final String title;

  HomePage({Key? key, required this.title}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<City> cityList = [];
  City? selectedCity;

  bool isWeatherDataLoaded = false;

  late Weather weather;

  @override
  void initState() {
    super.initState();
    readCityList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Container(
        margin: EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            _getInputSection(),
            _getBodyContent(),
          ],
        ),
      ),
    );
  }

  void readCityList() async {
    String response = await rootBundle.loadString('assets/city_list.json');
    final data = await json.decode(response) as List<dynamic>;
    setState(() {
      cityList = data.map((city) => City.fromJson(city)).toList();
      selectedCity = cityList[0];
    });
  }

  void getDummyUserFromRealApiCall(int? cityId) async {
    try {
      // var response = await Dio().get('https://randomuser.me/api/');
      var dio = Dio();
      dio.interceptors
          .add(PrettyDioLogger(requestHeader: true, responseHeader: true));
      var response = await dio.get(
        'http://api.openweathermap.org/data/2.5/weather',
        queryParameters: {
          'id': cityId,
          'appid': 'd450a4a574372bd12f2fa308bf3cf15a'
        },
      );
      setState(() {
        isWeatherDataLoaded = true;
        weather = Weather(
            weatherLastUpdatedTime: 'dflk', temperature, weatherDescription,
            weatherDescriptionIcon, location, humidity, pressure, visibility,
            sunriseTime, sunsetTime)
        weather.humidity = '67%';
      });
    } catch (e) {
      print("Error: $e}");
    }
  }

  _getInputSection() {
    return Container(
        margin: EdgeInsets.only(bottom: 16.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            if (selectedCity != null)
              DropdownButton<City>(
                value: selectedCity,
                onChanged: (City? newCity) {
                  setState(() {
                    if (newCity != null) selectedCity = newCity;
                  });
                },
                items: cityList.map((City city) {
                  return DropdownMenuItem<City>(
                    value: city,
                    child: Text(city.name),
                  );
                }).toList(),
              )
            else
              Container(),
            ElevatedButton(
              onPressed: () {
                // fetchWeatherInfo(selectedCity);
                getDummyUserFromRealApiCall(selectedCity?.id);
              },
              child: Text('VIEW WEATHER'),
            ),
          ],
        ));
  }

  _getBodyContent() {
    return Visibility(
        visible: isWeatherDataLoaded,
        child: Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(weather.weatherLastUpdatedTime, style: valueTextStyle),
              _getTemperatureRelatedRow(),
              Text(weather.location,
                  style: TextStyle(color: Colors.teal, fontSize: 20)),
              SizedBox(height: 16),
              WeatherProperty(label: "Humidity", value: weather.humidity),
              WeatherProperty(label: "Pressure", value: weather.pressure),
              WeatherProperty(label: "Visibility", value: weather.visibility),
              Spacer(),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  SunTimeTable(
                    label: "Sunrise",
                    value: weather.sunriseTime,
                    imagePath: 'images/sunrise.png',
                  ),
                  SunTimeTable(
                    label: "Sunset",
                    value: weather.sunsetTime,
                    imagePath: 'images/sunset.png',
                  ),
                ],
              ),
              SizedBox(
                height: 10,
              )
            ],
          ),
        ));
  }

  _getTemperatureRelatedRow() {
    return Container(
      child: Row(
        children: <Widget>[
          Container(
            child: Text(
              weather.temperature,
              style: TextStyle(fontSize: 80, color: Colors.teal),
            ),
            margin: EdgeInsets.only(top: 10),
          ),
          Text(
            '°C',
            style: TextStyle(fontSize: 35, color: Colors.teal),
          ),
          Spacer(),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Image.network(
                  weather.weatherDescriptionIcon, width: 60, height: 60),
              Text(weather.weatherDescription),
            ],
          )
        ],
      ),
    );
  }
}

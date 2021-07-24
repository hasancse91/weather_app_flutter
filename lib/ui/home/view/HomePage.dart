import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:weather_app_flutter/core/text_style.dart';
import 'package:weather_app_flutter/network/WeatherApi.dart';
import 'package:weather_app_flutter/network/WeatherApiImpl.dart';
import 'package:weather_app_flutter/ui/home/model/City.dart';
import 'package:weather_app_flutter/ui/home/model/weather_data.dart';
import 'package:weather_app_flutter/ui/home/widget/sun_time.dart';
import 'package:weather_app_flutter/ui/home/widget/weather_property.dart';

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

  WeatherData? weather;
  late WeatherApi weatherApi;

  @override
  void initState() {
    super.initState();
    readCityList();
    weatherApi = WeatherApiImpl();
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
            if (weather != null) _getBodyContent(),
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

  _getInputSection() {
    return Container(
        margin: EdgeInsets.only(bottom: 16.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            _getCityDropdown(),
            ElevatedButton(
              onPressed: () async {
                var weatherTemp =
                    await weatherApi.getWeatherInfo(selectedCity?.id);
                setState(() {
                  weather = weatherTemp;
                  // Logger().d(weather);
                  isWeatherDataLoaded = true;
                });
              },
              child: Text('VIEW WEATHER'),
            ),
          ],
        ));
  }

  DropdownButton<City> _getCityDropdown() {
    return DropdownButton<City>(
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
    );
  }

  _getBodyContent() {
    return Visibility(
        visible: isWeatherDataLoaded,
        child: Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(weather!.dateTime, style: valueTextStyle),
              _getTemperatureRow(),
              Text(weather!.cityAndCountry,
                  style: TextStyle(color: Colors.teal, fontSize: 20)),
              SizedBox(height: 16),
              WeatherProperty(
                humidity: weather!.humidity,
                pressure: weather!.pressure,
                visibility: weather!.visibility,
              ),
              Spacer(),
              SunTime(
                sunrise: weather!.sunrise,
                sunset: weather!.sunset,
              ),
              SizedBox(height: 10)
            ],
          ),
        ));
  }

  _getTemperatureRow() {
    return Row(
      children: <Widget>[
        Container(
          child: Text(
            weather!.temperature,
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
            Image.network(weather!.weatherConditionIconUrl,
                width: 60, height: 60),
            Text(weather!.weatherConditionIconDescription),
          ],
        )
      ],
    );
  }
}

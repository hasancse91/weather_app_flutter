import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:logger/logger.dart';
import 'package:weather_app_flutter/core/app_utils.dart';
import 'package:weather_app_flutter/network/WeatherApi.dart';
import 'package:weather_app_flutter/network/WeatherApiImpl.dart';
import 'package:weather_app_flutter/ui/home/model/City.dart';
import 'package:weather_app_flutter/ui/home/model/weather_data.dart';
import 'package:weather_app_flutter/ui/home/widget/weather_data_output.dart';

class HomePage extends StatefulWidget {
  final String title;

  HomePage({Key? key, required this.title}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final logger = Logger();
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
            if (isWeatherDataLoaded) WeatherDataOutput(weather: weather!),
          ],
        ),
      ),
    );
  }

  _getInputSection() {
    return Container(
        margin: EdgeInsets.only(bottom: 16.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            _getCityDropdown(),
            ElevatedButton(onPressed: showWeather, child: Text('VIEW WEATHER')),
          ],
        ));
  }

  DropdownButton<City> _getCityDropdown() {
    return DropdownButton<City>(
      value: selectedCity,
      onChanged: (City? newCity) {
        setState(() {
          if (newCity != null) selectedCity = newCity;
          isWeatherDataLoaded = false;
        });
      },
      items: cityList.map((City city) {
        return DropdownMenuItem<City>(value: city, child: Text(city.name));
      }).toList(),
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

  showWeather() async {
    try {
      var weatherTemp = await weatherApi.getWeatherInfo(selectedCity?.id);
      setState(() {
        weather = weatherTemp;
        isWeatherDataLoaded = true;
      });
    } catch (e) {
      showSnackBar(context, e.toString(), type: SnackBarType.ERROR);
      logger.e(e);
    }
  }
}

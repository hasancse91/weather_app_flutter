import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';
import 'package:weather_app_flutter/core/text_style.dart';
import 'package:weather_app_flutter/ui/home/City.dart';
import 'package:weather_app_flutter/ui/home/sun_time_table.dart';
import 'package:weather_app_flutter/ui/home/weather_property.dart';

class HomePage extends StatefulWidget {
  final String title;

  HomePage({Key? key, required this.title}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<City> cityList = [];
  late City selectedCity;

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
            Text('21 May, 2021 - 09:58 PM', style: valueTextStyle),
            _getTemperatureRelatedRow(),
            Text('Dhaka, BD',
                style: TextStyle(color: Colors.teal, fontSize: 20)),
            SizedBox(
              height: 16,
            ),
            WeatherProperty(label: "Humidity", value: "73%"),
            WeatherProperty(label: "Pressure", value: "999.0 mBar"),
            WeatherProperty(label: "Visibility", value: "4.0 KM"),
            Spacer(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                SunTimeTable(
                  label: "Sunrise",
                  value: '05:14 AM',
                  imagePath: 'images/sunrise.png',
                ),
                SunTimeTable(
                  label: "Sunset",
                  value: '06:49 PM',
                  imagePath: 'images/sunset.png',
                ),
              ],
            ),
            SizedBox(
              height: 10,
            )
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

  void getDummyUserFromRealApiCall(int cityId) async {
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
            ),
            ElevatedButton(
              onPressed: () {
                // fetchWeatherInfo(selectedCity);
                getDummyUserFromRealApiCall(selectedCity.id);
                // ApiClient client = ApiClient();
                // var endpointProvider = EndpointProvider(client.init());
                // var response = endpointProvider.getWeatherInfo(selectedCity.id);
                // print("RESPONSE: ${await endpointProvider.getWeatherInfo(selectedCity.id)}");
              },
              child: Text('VIEW WEATHER'),
            ),
          ],
        ));
  }

  _getTemperatureRelatedRow() {
    return Container(
      child: Row(
        children: <Widget>[
          Container(
            child: Text(
              '30',
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
                'https://static.thenounproject.com/png/967229-200.png',
                width: 60,
                height: 60,
              ),
              Text('Haze'),
            ],
          )
        ],
      ),
    );
  }

  TableRow getWeatherInfoPropertyWidget(String label, String value) {
    var margin = 4.0;
    return TableRow(children: [
      Padding(
        padding: EdgeInsets.only(top: margin, bottom: margin),
        child: Text(
          label,
          style: labelTextStyle,
        ),
      ),
      Padding(
        padding: EdgeInsets.symmetric(vertical: margin),
        child: Text(
          value,
          style: valueTextStyle,
        ),
      ),
    ]);
  }
}

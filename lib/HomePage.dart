import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:weather_app_flutter/City.dart';
import 'package:weather_app_flutter/TextLabelStyle.dart';

import 'TextValueStyle.dart';

class HomePage extends StatefulWidget {
  HomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<City> cityList = [];
  City selectedCity;

  void readCityList() async {
    String response = await rootBundle.loadString('assets/city_list.json');
    final data = await json.decode(response) as List<dynamic>;
    setState(() {
      cityList = data.map((city) => City.fromJson(city)).toList();
      selectedCity = cityList[0];
    });
  }

  void fetchWeatherInfo(City city) async {
    try {
      var dio = Dio();
      dio.options.headers = {'appid': 'd450a4a574372bd12f2fa308bf3cf15a'};
      var response = dio.get(
        'http://api.openweathermap.org/data/2.5/weather',
        queryParameters: {'id': city.id},
      );
      print("Response: ${response}");
    } catch (e) {
      print("Error: $e");
    }
  }

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
            Container(
                margin: EdgeInsets.only(bottom: 20.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    DropdownButton<City>(
                      value: selectedCity,
                      onChanged: (City newCity) {
                        setState(() {
                          selectedCity = newCity;
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
                        fetchWeatherInfo(selectedCity);
                      },
                      child: Text('VIEW WEATHER'),
                    ),
                  ],
                )),
            Text(
              '21 May, 2021 - 09:58 PM',
              style: TextStyle(color: Colors.black, fontSize: 20),
            ),
            Container(
              child: Row(
                children: <Widget>[
                  Container(
                    child: Text(
                      '30',
                      style: TextStyle(fontSize: 100, color: Colors.teal),
                    ),
                    margin: EdgeInsets.only(top: 20),
                  ),
                  Text(
                    '°C',
                    style: TextStyle(fontSize: 50, color: Colors.teal),
                  ),
                  Spacer(),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Image.network(
                        'https://static.thenounproject.com/png/967229-200.png',
                        width: 80,
                        height: 80,
                      ),
                      Text('Haze'),
                    ],
                  )
                ],
              ),
            ),
            Align(
              alignment: Alignment.topLeft,
              child: Text(
                'Dhaka, BD',
                style: TextStyle(color: Colors.teal, fontSize: 25),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Table(
              columnWidths: {
                0: FlexColumnWidth(3),
                1: FlexColumnWidth(6),
              },
              children: [
                getWeatherInfoPropertyWidget("Humidity", "73%"),
                getWeatherInfoPropertyWidget("Pressure", "999.0 mBar"),
                getWeatherInfoPropertyWidget("Visibility", "4.0 KM"),
              ],
            ),
            Spacer(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Column(
                  children: [
                    Text(
                      'Sunrise',
                      style: TextLabelStyle(),
                    ),
                    Container(
                      child: Image.asset(
                        'images/sunrise.png',
                        width: 100,
                        height: 100,
                      ),
                      margin: EdgeInsets.only(top: 12.0, bottom: 12.0),
                    ),
                    Text(
                      '05:14 AM',
                      style: TextValueStyle(),
                    ),
                  ],
                ),
                Column(
                  children: [
                    Text(
                      'Sunset',
                      style: TextLabelStyle(),
                    ),
                    Container(
                      child: Image.asset(
                        'images/sunset.png',
                        width: 100,
                        height: 100,
                      ),
                      margin: EdgeInsets.only(top: 12.0, bottom: 12.0),
                    ),
                    Text(
                      '06:49 PM',
                      style: TextValueStyle(),
                    ),
                  ],
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

  TableRow getWeatherInfoPropertyWidget(String label, String value) {
    return TableRow(children: [
      Padding(
        padding: EdgeInsets.only(top: 8, bottom: 8),
        child: Text(
          label,
          style: TextLabelStyle(),
        ),
      ),
      Padding(
        padding: EdgeInsets.only(top: 8, bottom: 8),
        child: Text(
          value,
          style: TextValueStyle(),
        ),
      ),
    ]);
  }
}

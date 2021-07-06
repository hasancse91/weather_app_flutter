import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';
import 'package:weather_app_flutter/ui/home/City.dart';
import 'package:weather_app_flutter/core/text_style.dart';

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
                margin: EdgeInsets.only(bottom: 16.0),
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
                )),
            Text(
              '21 May, 2021 - 09:58 PM',
              style: valueTextStyle,
            ),
            Container(
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
            ),
            Align(
              alignment: Alignment.topLeft,
              child: Text(
                'Dhaka, BD',
                style: TextStyle(color: Colors.teal, fontSize: 20),
              ),
            ),
            SizedBox(
              height: 16,
            ),
            Table(
              columnWidths: {
                0: FlexColumnWidth(2),
                1: FlexColumnWidth(5),
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
                      style: labelTextStyle,
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
                      style: valueTextStyle,
                    ),
                  ],
                ),
                Column(
                  children: [
                    Text(
                      'Sunset',
                      style: labelTextStyle,
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
                      style: valueTextStyle,
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

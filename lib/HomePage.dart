import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:weather_app_flutter/TextLabelStyle.dart';

import 'TextValueStyle.dart';

class HomePage extends StatefulWidget {
  HomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String dropdownButtonValue = 'Dhaka';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Container(
        margin: EdgeInsets.all(20.0),
        child: Column(
          children: <Widget>[
            Container(
                margin: EdgeInsets.only(bottom: 20.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    DropdownButton<String>(
                      value: dropdownButtonValue,
                      onChanged: (String newDropdownValue) {
                        setState(() {
                          dropdownButtonValue = newDropdownValue;
                        });
                      },
                      items: <String>['Dhaka', 'Tokyo', 'New York', 'Tehran']
                          .map<DropdownMenuItem<String>>((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                        );
                      }).toList(),
                    ),
                    ElevatedButton(
                      onPressed: () {},
                      child: Text('VIEW WEATHER'),
                    ),
                  ],
                )),
            Align(
              alignment: Alignment.topLeft,
              child: Text(
                '21 May, 2021 - 09:58 PM',
                style: TextStyle(color: Colors.black, fontSize: 20),
              ),
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
                TableRow(children: [
                  Padding(
                    padding: EdgeInsets.only(top: 8, bottom: 8),
                    child: Text(
                      'Humidity',
                      style: TextLabelStyle(),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 8, bottom: 8),
                    child: Text(
                      '73%',
                      style: TextValueStyle(),
                    ),
                  ),
                ]),
                TableRow(children: [
                  Padding(
                    padding: EdgeInsets.only(top: 8, bottom: 8),
                    child: Text(
                      'Pressure',
                      style: TextLabelStyle(),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 8, bottom: 8),
                    child: Text(
                      '999.0 mBar',
                      style: TextValueStyle(),
                    ),
                  ),
                ]),
                TableRow(children: [
                  Padding(
                    padding: EdgeInsets.only(top: 8, bottom: 8),
                    child: Text(
                      'Visibility',
                      style: TextLabelStyle(),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 8, bottom: 8),
                    child: Text(
                      '4.0 KM',
                      style: TextValueStyle(),
                    ),
                  ),
                ]),
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
                        'assets/sunrise.png',
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
                        'assets/sunset.png',
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
            )
          ],
        ),
      ),
    );
  }
}

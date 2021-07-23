import 'package:flutter/material.dart';
import 'package:weather_app_flutter/ui/home/model/City.dart';

class InputSection extends StatefulWidget {
  final List<City> cityList;
  final Function(int) onTap;

  const InputSection({Key? key, required this.cityList, required this.onTap})
      : super(key: key);

  @override
  _InputSectionState createState() =>
      _InputSectionState(cityList: cityList, onTap: onTap);
}

class _InputSectionState extends State<InputSection> {
  final List<City> cityList;
  final Function(int) onTap;
  City? selectedCity;

  _InputSectionState({required this.cityList, required this.onTap});

  @override
  Widget build(BuildContext context) {
    if (cityList.isNotEmpty) selectedCity = cityList[0];

    return Container(
        margin: EdgeInsets.only(bottom: 16.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            _getCityDropdown(),
            ElevatedButton(
              onPressed: onTap(selectedCity!.id),
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
}

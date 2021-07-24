import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

String unixTimestampToDateTimeString(int? timestamp) {
  if (timestamp == null) return '--/--';
  var date = DateTime.fromMillisecondsSinceEpoch(timestamp * 1000);
  var formattedDate = DateFormat('dd MMM, yyyy - hh:mm a').format(date);
  return formattedDate;
}

String unixTimestampToTimeString(int? timestamp) {
  if (timestamp == null) return '--/--';
  var date = DateTime.fromMillisecondsSinceEpoch(timestamp * 1000);
  var formattedDate = DateFormat('hh:mm a').format(date);
  return formattedDate;
}

int kelvinToCelsius(double? temperature) {
  if (temperature == null) return 0;

  return (temperature - 273.15).toInt();
}

enum SnackBarType { MESSAGE, ERROR }

showSnackBar(BuildContext context, String message,
    {SnackBarType type = SnackBarType.MESSAGE}) {
  Color backgroundColor =
      type == SnackBarType.MESSAGE ? Colors.black87 : Colors.red;

  final snackBar = SnackBar(
    backgroundColor: backgroundColor,
    content: Text(message),
    action: SnackBarAction(
      label: 'OK',
      onPressed: () {
        // Some code to undo the change.
      },
    ),
  );

  // Find the ScaffoldMessenger in the widget tree
  // and use it to show a SnackBar.
  ScaffoldMessenger.of(context).showSnackBar(snackBar);
}

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

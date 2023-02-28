import 'package:intl/intl.dart';
import 'package:date_format/date_format.dart';

formatDayMonth(value) {
  final df = DateFormat('dd MMM, yyyy');
  return df.format(value);
}

formatDayShortMonthName(value) {
  final df = DateFormat('dd MMM, yyyy');
  var d = df.format(value).split(',');
  var y = d[0].split(' ');
  var z = y[1].length <= 4 ? y[1] : y[1].substring(0, 4);
  return '${y[0]}-$z-${d[1]}';
}

formatShorthenMonthPlusformatTime(value) {
  return formatDayShortMonthName(value) + ', ' + formatTime(value);
}

formatDateShortenDayWithTime(value) {
  final df = DateFormat('EEEE, dd MMM yyyy - hh:mm');
  var d = df.format(value).split(',');
  var f = d[0].substring(0, 3);
  return '$f, ${d[1]}';
}

formatDayDateMonth(value) {
  final df = DateFormat('EEEE, dd MMM yyyy');
  return df.format(value);
}

formatMonthDayYear(value) {
  final df = DateFormat('MMM, dd yyyy');
  return df.format(value);
}

formatDay(value) {
  final df = DateFormat('EEEE');
  return df.format(value);
}

formatHyphenDate(value) {
  final df = DateFormat('dd-MM-yyyy');
  return df.format(value);
}

formatSlashDate(value) {
  final df = DateFormat('dd/MM/yyyy');
  return df.format(value);
}

formatTime(value) {
  return formatDate(DateTime(2019, 08, 1, value.hour, value.minute),
      [hh, ':', nn, " ", am]).toString();
}

formatTimeToAmPmIn24Hrs(value) {
  var t = DateTime(2019, 08, 1, value.hour, value.minute);
  var x = t.hour.toString();
  var y = t.minute.toString();
  var hh = x.length < 2 ? "0$x" : x;
  var mm = y.length < 2 ? "0$y" : y;
  var am = t.hour < 12 ? 'am' : 'pm';
  return '$hh:$mm $am';
}

formatT(value) {
  return formatDate(DateTime(2019, 08, 1, value.hour, value.minute), [
    hh,
    ':',
    nn,
  ]).toString();
}

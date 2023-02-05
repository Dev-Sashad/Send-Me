import 'package:intl/intl.dart';

String? isEmpty(value) {
  if (value.isEmpty) {
    return 'Field cannot be empty';
  }
  return null;
}

String capitalize(val) {
  return "${val[0].toUpperCase()}${val.substring(1)}";
}

numberFormat(String amount) {
  return NumberFormat.decimalPattern()
      .format(double.parse(amount.replaceAll(",", "")));
}

formatDate(value) {
  final df = DateFormat('dd-MM-yyyy');
  return df.format(DateTime.parse(value));
}

formatDateTime(value) {
  final df = DateFormat('d MMMM, y hh:mm a');
  return df.format(DateTime.parse(value));
}

currencyFormater(String value, {String symbol = "NGN "}) {
  return NumberFormat.currency(name: symbol)
      .format(double.parse(value.toString().replaceAll(",", "")));
}

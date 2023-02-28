import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

customYMargin(double value) {
  return SizedBox(height: value);
}

customXMargin(double value) {
  return SizedBox(width: value);
}

String capitalize(val) {
  return "${val[0].toUpperCase()}${val.substring(1)}";
}

Future<bool> checkInternet() async {
  var connectivityResult = await (Connectivity().checkConnectivity());
  if (connectivityResult == ConnectivityResult.mobile) {
    return true;
  } else if (connectivityResult == ConnectivityResult.wifi) {
    return true;
  } else {
    return false;
  }
}

newFormatDate(value) {
  final df = DateFormat('YYYY-MM-DD HH:MM:SS');
  return df.format(DateTime.parse(value));
}

formatDateOnly(value) {
  final df = DateFormat('dd-MM-yyyy');
  return df.format(DateTime.parse(value));
}

formatDateTime(value) {
  final df = DateFormat('d MMMM, y hh:mm a');
  return df.format(DateTime.parse(value));
}

formatTimeOnly(value) {
  final df = DateFormat('hh:mm a');
  return df.format(DateTime.parse(value));
}

Future<bool> checkSession() async {
  await Future.delayed(const Duration(milliseconds: 2000), () {});
  return true;
}

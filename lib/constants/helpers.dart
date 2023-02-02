import 'package:another_flushbar/flushbar.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
import 'package:send_me/_lib.dart';

appPrint(dynamic value) {
  if (kDebugMode) {
    print(value);
  }
}

customYMargin(double value) {
  return SizedBox(height: value);
}

customXMargin(double value) {
  return SizedBox(width: value);
}

showToast(String message) {
  Fluttertoast.showToast(
      msg: message,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.SNACKBAR,
      webPosition: "center",
      timeInSecForIosWeb: 5,
      backgroundColor: AppColors.green,
      textColor: Colors.white,
      fontSize: 16.0);
}

showFlushBar({String title = '', String message = '', BuildContext? context}) {
  Flushbar(
    backgroundColor: AppColors.grey,
    titleColor: Colors.black,
    title: title,
    flushbarPosition: FlushbarPosition.TOP,
    messageColor: Colors.black,
    message: message,
    duration: Duration(seconds: 5),
  ).show(context!);
}

showErrorToast(String message) {
  Fluttertoast.showToast(
      msg: message,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.SNACKBAR,
      webPosition: "center",
      webBgColor: "#e74c3c",
      timeInSecForIosWeb: 5,
      // backgroundColor: AppColors.red,
      textColor: Colors.white,
      fontSize: 16.0);
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

// _showDialog(ProgressRequest request) {
//   var isConfirmationDialog = request.cancelTitle!.isNotEmpty;
//   var dialogType = request.buttonTitle!.isNotEmpty;

//   if (dialogType) {
//     showDialog(
//       context: context,
//       builder: (context) => AlertDialog(
//         title: Text(request.title!),
//         content: Text(request.description!),
//         actions: <Widget>[
//           if (isConfirmationDialog)
//             TextButton(
//               child: Text(request.cancelTitle!),
//               onPressed: () {
//                 _progressService
//                     .dialogComplete(ProgressResponse(confirmed: false));
//               },
//             ),
//           TextButton(
//             child: Text(request.buttonTitle!),
//             onPressed: () {
//               _progressService
//                   .dialogComplete(ProgressResponse(confirmed: true));
//             },
//           ),
//         ],
//       ),
//     );
//   }
// }

newFormatDate(value) {
  final df = new DateFormat('YYYY-MM-DD HH:MM:SS');
  return df.format(DateTime.parse(value));
}

formatDateOnly(value) {
  final df = new DateFormat('dd-MM-yyyy');
  return df.format(DateTime.parse(value));
}

formatDateTime(value) {
  final df = new DateFormat('d MMMM, y hh:mm a');
  return df.format(DateTime.parse(value));
}

formatTimeOnly(value) {
  final df = new DateFormat('hh:mm a');
  return df.format(DateTime.parse(value));
}

Future<bool> checkSession() async {
  await Future.delayed(Duration(milliseconds: 2000), () {});
  return true;
}

class Status {
  static final sent = 'sent';
  static final delivered = 'delivered';
  static final read = 'read';
}

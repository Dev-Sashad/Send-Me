import 'dart:developer';
import 'package:another_flushbar/flushbar.dart';
import 'package:flutter_animated_dialog/flutter_animated_dialog.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:send_me/_lib.dart';
import 'package:url_launcher/url_launcher.dart';

lunchUrl(String url) async {
  if (await canLaunchUrl(Uri.parse(url))) {
    await launchUrl(Uri.parse(url));
  }
}

appPrint(value) {
  if (kDebugMode) {
    log(value.toString());
  }
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
    duration: const Duration(seconds: 5),
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

Future<void> showOkayDialog({String message = ''}) {
  return showAnimatedDialog(
      barrierDismissible: false,
      context: context,
      animationType: DialogTransitionType.fadeScale,
      curve: Curves.fastOutSlowIn,
      duration: const Duration(milliseconds: 500),
      builder: (context) {
        return OkDialog(CustomText(
          message,
          textType: TextType.mediumText,
          textAlign: TextAlign.center,
          maxLines: 3,
        ));
      });
}

slideUpdialogshow(Widget widget, {BuildContext? con}) {
  return showAnimatedDialog(
      barrierDismissible: false,
      context: context,
      animationType: DialogTransitionType.slideFromBottomFade,
      curve: Curves.fastOutSlowIn,
      duration: const Duration(milliseconds: 500),
      builder: (context) => widget);
}

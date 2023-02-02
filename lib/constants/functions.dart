import 'dart:developer';
import 'package:flutter_animated_dialog/flutter_animated_dialog.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
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

showOkayDialog({String message = ''}) {
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

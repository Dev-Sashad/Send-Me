import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:send_me/_lib.dart';

class SnackBarService {
  final GlobalKey<ScaffoldMessengerState> _scaffoldMessengerKey =
      GlobalKey<ScaffoldMessengerState>();
  GlobalKey<ScaffoldMessengerState> get scaffoldMessengerKey =>
      _scaffoldMessengerKey;

  showSuccessSnackBar({String? title, String? message}) {
    Get.snackbar(
      "",
      "",
      snackPosition: SnackPosition.BOTTOM,
      snackStyle: SnackStyle.FLOATING,
      titleText: Text(
        title ?? "",
        style: const TextStyle(
          color: Colors.white,
          fontSize: 15,
          fontWeight: FontWeight.w600,
        ),
      ),
      messageText: Text(
        message ?? "",
        style: const TextStyle(
          color: Colors.white,
          fontSize: 15,
          fontWeight: FontWeight.w400,
        ),
      ),
      margin: const EdgeInsets.only(
          bottom: kBottomNavigationBarHeight, left: 8, right: 8),
      padding: const EdgeInsets.only(bottom: 4, left: 16, right: 16),
      borderRadius: 4,
      backgroundColor: AppColors.primaryColor,
      colorText: AppColors.white,
    );
  }
}

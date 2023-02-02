import 'dart:async';
import 'package:flutter/material.dart';
import 'package:send_me/core/local_data_request/local_data_request.dart';
import 'package:send_me/core/local_data_request/local_url.dart';
import 'package:send_me/core/services/navigation_service.dart';
import 'package:send_me/core/services/notification_service.dart';
import '../../_lib.dart';

class SplashScreen extends StatefulWidget {
  SplashScreen({Key? key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  final NotificationHelper _notificationHelper = locator<NotificationHelper>();
  final LocalDataRequest _localDataRequest = locator<LocalDataRequest>();
  final NavigationService _navigationService = locator<NavigationService>();

  rememberMe() async {
    var count = await _localDataRequest.getInt(AppLocalUrl.appLunchTimes);
    var loggedIn = await _localDataRequest.getBool(AppLocalUrl.isLoggedIn);
    var _username = await _localDataRequest.getString(AppLocalUrl.email);
    var _firstname = await _localDataRequest.getString(AppLocalUrl.fName);
    Map<String, dynamic> _args = {"firstName": _firstname, "email": _username};

    await Future.delayed(const Duration(seconds: 3)).then((v) {
      appPrint('logged in $loggedIn');
      if (count != null && count > 0) {
        return _navigationService.navigateReplacementTo(loginViewRoute);
      } else {
        return _navigationService.navigateReplacementTo(onboardingViewRoute);
      }
    });
  }

  init() {
    _notificationHelper.initialize();
    _notificationHelper.createChannel();
    _notificationHelper.init();
    _notificationHelper.getFcmToken();
    _notificationHelper.onMessage(context);
    _notificationHelper.onMessageOpenApp();
    rememberMe();
  }

  @override
  void initState() {
    super.initState();
    init();
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: AppColors.primaryColor,
      body: Center(
          child: CustomText(
        AppStrings.appTitle,
        textType: TextType.headerText,
        color: AppColors.white,
      )),
    );
  }
}

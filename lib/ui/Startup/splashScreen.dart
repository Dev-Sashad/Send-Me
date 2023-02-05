import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:send_me/_lib.dart';
import 'package:send_me/core/local_data_request/local_data_request.dart';
import 'package:send_me/core/local_data_request/local_url.dart';
import 'package:send_me/core/repository/auth_repo.dart';
import 'package:send_me/core/services/auth_data_service.dart';
import 'package:send_me/core/services/navigation_service.dart';
import 'package:send_me/core/services/notification_service.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  final NotificationHelper _notificationHelper = locator<NotificationHelper>();
  final LocalDataRequest _localDataRequest = locator<LocalDataRequest>();
  final NavigationService _navigationService = locator<NavigationService>();
  final AuthRepo _authRepo = locator<AuthRepo>();
  final AuthService _authService = locator<AuthService>();

  rememberMe() async {
    var loggedIn = await _localDataRequest.getBool(AppLocalUrl.isLoggedIn);
    final resposne = await _authRepo.getCurrentUser();
    await Future.delayed(const Duration(seconds: 1)).then((v) {
      appPrint('logged in $loggedIn');
      if (loggedIn && resposne.status!) {
        _authService.newUser = resposne.data;
        return _navigationService.navigateReplacementTo(dashboardViewRoute);
      } else {
        return _navigationService.navigateReplacementTo(loginViewRoute);
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

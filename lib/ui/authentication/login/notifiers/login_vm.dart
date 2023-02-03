import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:send_me/core/local_data_request/local_data_request.dart';
import 'package:send_me/core/local_data_request/local_url.dart';
import 'package:send_me/core/repository/auth_repo.dart';
import 'package:send_me/core/services/auth_data_service.dart';
import 'package:send_me/core/services/navigation_service.dart';
import '../../../../_lib.dart';

class LoginVm extends BaseModel {
  LoginVm(this._read);
  final Ref _read;
  final NavigationService _navigationService = locator<NavigationService>();
  final AuthRepo _authRepo = locator<AuthRepo>();
  final AuthService _authService = locator<AuthService>();
  final LocalDataRequest _localDataRequest = locator<LocalDataRequest>();

  bool _passVisible = true;
  bool get passVisible => _passVisible;
  setPassVisibility() {
    _passVisible = !_passVisible;
    notifyListeners();
  }

  pop() {
    _navigationService.pop();
  }

  setAppLunchCount() async {
    int? count = await _localDataRequest.getInt(AppLocalUrl.appLunchTimes);
    if (count != null && count > 0) {
      int newCount = count + 1;
      _localDataRequest.setInt(AppLocalUrl.appLunchTimes, newCount);
    } else {
      _localDataRequest.setInt(AppLocalUrl.appLunchTimes, 1);
    }
  }

  submit({required String email, required String password}) async {
    setBusy(true);
    final response = await _authRepo.signIn(email: email, password: password);
    if (response.status!) {
      User _user = response.data;
      _localDataRequest.setBool(AppLocalUrl.isLoggedIn, true);
      _authService.newUser = _user;
      await setAppLunchCount();
      notifyListeners();
      setBusy(false);
      _navigationService.navigateReplacementTo(dashboardViewRoute);
    } else {
      setBusy(false);
      showOkayDialog(message: response.message!);
    }
  }

  forgotPass(BuildContext context) {
    slideUpdialogshow(const ForgotPassword(), con: context);
  }

  register() {
    FocusScope.of(context).unfocus();
    _navigationService.navigateTo(registerViewRoute);
  }
}

final loginVm = ChangeNotifierProvider.autoDispose<LoginVm>(
  (ref) => LoginVm(ref),
);

import 'package:flutter/material.dart';
import 'package:send_me/core/local_data_request/local_data_request.dart';
import 'package:send_me/core/local_data_request/local_url.dart';
import 'package:send_me/core/repository/auth_repo.dart';
import 'package:send_me/core/services/navigation_service.dart';

import '../../../../_lib.dart';

class RegisterVm extends BaseModel {
  RegisterVm(this._read);
  final Ref _read;
  final NavigationService _navigationService = locator<NavigationService>();
  final LocalDataRequest _localDataRequest = locator<LocalDataRequest>();
  final AuthRepo _authRepo = locator<AuthRepo>();
  TextEditingController fullNameCtrl = TextEditingController();
  TextEditingController emailCtrl = TextEditingController();
  TextEditingController phoneNoCtrl = TextEditingController();
  TextEditingController passwordCtrl = TextEditingController();
  TextEditingController confirmPasswordCtrl = TextEditingController();
  final controller = PageController(keepPage: true);

  clearControllers() {
    fullNameCtrl.dispose();
    emailCtrl.dispose();
    passwordCtrl.dispose();
    phoneNoCtrl.dispose();
    confirmPasswordCtrl.clear();
  }

  bool _passVisible = false;
  bool get passVisible => _passVisible;
  setPassVisibility() {
    _passVisible = !_passVisible;
    notifyListeners();
  }

  String _code = "+234";
  String get code => _code;
  setCode(String value) {
    _code = value;
    notifyListeners();
  }

  String _number = "";
  String get number => _number;

  setNumber(String value) {
    if (value.startsWith('0')) {
      _number = code + value.substring(1);
    } else {
      _number = code + value;
    }
    notifyListeners();
  }

  int _currentIndex = 0;
  int get currentIndex => _currentIndex;
  setCurrentIndex(int value) {
    _currentIndex = value;
    notifyListeners();
  }

  proceed() {
    controller.jumpToPage(_currentIndex + 1);
    _currentIndex = _currentIndex + 1;
    notifyListeners();
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

  back() {
    if (_currentIndex > 0) {
      controller.jumpToPage(_currentIndex - 1);
      _currentIndex = _currentIndex - 1;
      notifyListeners();
    } else {
      close();
    }
  }

  submit() async {
    setBusy(true);
    final response = await _authRepo.signUp(
      email: emailCtrl.text.trim(),
      phoneNumber: number,
      password: confirmPasswordCtrl.text.trim(),
      userName: fullNameCtrl.text,
    );

    if (response.status!) {
      setBusy(false);
    } else {
      setBusy(false);
      showOkayDialog(message: response.message!);
    }
  }

  close() {
    _navigationService.pop();
  }

  navigateHome() {
    _navigationService.navigateReplacementTo(dashboardViewRoute);
  }
}

final registerVm = ChangeNotifierProvider.autoDispose<RegisterVm>(
  (ref) => RegisterVm(ref),
);

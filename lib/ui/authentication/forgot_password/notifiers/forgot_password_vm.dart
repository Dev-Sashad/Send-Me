import 'package:flutter/material.dart';
import 'package:send_me/_lib.dart';
import 'package:send_me/core/repository/auth_repo.dart';
import 'package:send_me/core/services/navigation_service.dart';

class ForgotPasswordVm extends BaseModel {
  ForgotPasswordVm(this._read);
  final Ref _read;
  final AuthRepo _authRepo = locator<AuthRepo>();
  final NavigationService _navigationService = locator<NavigationService>();

  String _email = '';
  String get email => _email;
  setEmail(String value) {
    _email = value;
    notifyListeners();
  }

  bool _passVisible = false;
  bool get passVisible => _passVisible;
  setPassVisibility() {
    _passVisible = !_passVisible;
    notifyListeners();
  }

  sendResetPasswordLink({required BuildContext context}) async {
    setBusy(true);
    final response = await _authRepo.forgotPassword(email: email);
    if (response.status!) {
      setBusy(false);
      showDialog(
          barrierDismissible: false,
          context: context,
          builder: (context) {
            return ResetPassSuccess();
          });
    } else {
      setBusy(false);
      showOkayDialog(message: response.message!);
    }
  }

  changePassword(
      {required String oldPassword, required String newPassword}) async {
    setBusy(true);
    final response = await _authRepo.resetPassword(
        oldPassword: oldPassword, newPassword: newPassword);
    if (response.status!) {
      setBusy(false);
      showDialog(
          barrierDismissible: false,
          context: context,
          builder: (context) {
            return ResetPassSuccess();
          });
    } else {
      setBusy(false);
      showOkayDialog(message: response.message!);
    }
  }

  pop() {
    _navigationService.pop();
  }

  navigaToLogin() {
    for (int i = 0; i <= 3; i++) {
      pop();
    }
  }
}

final forgotPasswordVm = ChangeNotifierProvider.autoDispose<ForgotPasswordVm>(
  (ref) => ForgotPasswordVm(ref),
);

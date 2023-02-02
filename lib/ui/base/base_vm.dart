import 'package:flutter/material.dart';
import 'package:send_me/core/repository/auth_repo.dart';
import 'package:send_me/core/services/auth_data_service.dart';
import '../../_lib.dart';

class BaseModel extends ChangeNotifier {
  final ProgressService _dialogService = locator<ProgressService>();

  final AuthRepo _authRepo = locator<AuthRepo>();
  final AuthService _authService = locator<AuthService>();
  Map<String, String> _headers = {};
  Map<String, String> get headers => _headers;

  bool _busy = false;
  bool get busy => _busy;

  void setBusy(bool value) {
    _busy = value;
    notifyListeners();
    if (value == true) {
      _dialogService.showDialog();
    } else {
      _dialogService.dialogComplete();
    }
  }
}

final userNameFromBank = StateProvider.autoDispose((ref) => '');

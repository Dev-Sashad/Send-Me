import 'package:flutter/material.dart';
import '../../_lib.dart';

class BaseModel extends ChangeNotifier {
  final ProgressService _dialogService = locator<ProgressService>();
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

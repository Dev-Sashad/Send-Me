import 'package:flutter/material.dart';
import 'package:send_me/_lib.dart';
import 'package:send_me/core/local_data_request/local_data_request.dart';
import 'package:send_me/core/local_data_request/local_url.dart';

class ThemeNotifier extends ChangeNotifier {
  ThemeNotifier() {
    setThemeMode();
  }
  final LocalDataRequest _dataRequest = locator<LocalDataRequest>();

  ThemeMode _themeMode = ThemeMode.light;
  ThemeMode get themeMode => _themeMode;

  setThemeMode() async {
    String value = await _dataRequest.getString(AppLocalUrl.themeMode) ??
        ThemeMode.light.name.toLowerCase();
    if (value == ThemeMode.light.name.toLowerCase()) {
      _themeMode = ThemeMode.light;
    } else {
      _themeMode = ThemeMode.dark;
    }
    notifyListeners();
  }
}

final themeVm = ChangeNotifierProvider.autoDispose<ThemeNotifier>(
  (ref) => ThemeNotifier(),
);

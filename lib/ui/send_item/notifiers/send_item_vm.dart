import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:send_me/core/local_data_request/local_data_request.dart';
import 'package:send_me/core/services/auth_data_service.dart';
import 'package:send_me/core/services/navigation_service.dart';
import '../../../_lib.dart';

class SendItemVm extends BaseModel {
  SendItemVm(this._read);
  final Ref _read;
  final TextEditingController pkAddCtrl = TextEditingController();
  final TextEditingController dpAddressCtrl = TextEditingController();
  final TextEditingController numberCtrl = TextEditingController();
  final NavigationService _navigationService = locator<NavigationService>();
  final LocalDataRequest _dataRequest = locator<LocalDataRequest>();
  final AuthService _authService = locator<AuthService>();

  //User _user;
  User get user => _authService.user!;

  bool _estimated = false;
  bool get estimated => _estimated;
  setEstimated(bool value) {
    _estimated = value;
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

  estimate() {}

  submit({String? pickUp, String? dropOff}) {}
}

final sendItemVm = ChangeNotifierProvider<SendItemVm>(
  (ref) => SendItemVm(ref),
);

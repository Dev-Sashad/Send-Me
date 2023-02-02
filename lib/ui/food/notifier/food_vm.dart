import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:send_me/core/local_data_request/local_data_request.dart';
import 'package:send_me/core/services/auth_data_service.dart';
import 'package:send_me/core/services/navigation_service.dart';
import '../../../_lib.dart';

class FoodVm extends BaseModel {
  FoodVm(this._read) {
    getFoods();
  }
  final Ref _read;
  final TextEditingController pkAddCtrl = TextEditingController();
  final TextEditingController dpAddressCtrl = TextEditingController();
  final TextEditingController numberCtrl = TextEditingController();
  final NavigationService _navigationService = locator<NavigationService>();
  final LocalDataRequest _dataRequest = locator<LocalDataRequest>();
  final AuthService _authService = locator<AuthService>();

  //User _user;
  User get user => _authService.user!;
  List _food = [];
  List get food => _food;
  getFoods() {}
}

final foodVm = ChangeNotifierProvider<FoodVm>(
  (ref) => FoodVm(ref),
);

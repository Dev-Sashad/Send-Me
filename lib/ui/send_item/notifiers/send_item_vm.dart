import 'dart:math';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_google_places/flutter_google_places.dart';
import 'package:geoflutterfire/geoflutterfire.dart';
import 'package:google_maps_webservice/places.dart';
import 'package:send_me/core/model/booking_model.dart';
import 'package:send_me/core/repository/firestore_repo.dart';
import 'package:send_me/core/services/auth_data_service.dart';
import 'package:send_me/core/services/navigation_service.dart';
import 'package:uuid/uuid.dart';
import '../../../_lib.dart';

class SendItemVm extends BaseModel {
  SendItemVm(this._read);
  final Ref _read;
  final TextEditingController pkAddCtrl = TextEditingController();
  final TextEditingController dpAddressCtrl = TextEditingController();
  final TextEditingController numberCtrl = TextEditingController();
  final TextEditingController weightCtrl = TextEditingController();
  final NavigationService _navigationService = locator<NavigationService>();
  final FireStoreRepo _fireStoreRepo = locator<FireStoreRepo>();
  final AuthService _authService = locator<AuthService>();
  final GoogleMapsPlaces _places =
      GoogleMapsPlaces(apiKey: AppInfo.placeApiKey);
  GeoFirePoint? pickUpGeolocation;
  GeoFirePoint? dropOffGeolocation;
  Geoflutterfire geo = Geoflutterfire();

  //User _user;
  User get user => _authService.user!;
  double fee = 0.0;

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

  setPickUp(PlaceDetails p) {
    pkAddCtrl.text = p.formattedAddress!;
    pickUpGeolocation = geo.point(
        latitude: p.geometry!.location.lat,
        longitude: p.geometry!.location.lng);
    notifyListeners();
  }

  setDropOff(PlaceDetails p) {
    dpAddressCtrl.text = p.formattedAddress!;
    dropOffGeolocation = geo.point(
        latitude: p.geometry!.location.lat,
        longitude: p.geometry!.location.lng);
    notifyListeners();
  }

  double calculateDistance(lat1, lon1, lat2, lon2) {
    var p = 0.017453292519943295;
    var c = cos;
    var a = 0.5 -
        c((lat2 - lat1) * p) / 2 +
        c(lat1 * p) * c(lat2 * p) * (1 - c((lon2 - lon1) * p)) / 2;
    return double.parse((12742 * asin(sqrt(a))).toStringAsFixed(5));
  }

  estimateCost() {
    double distance = calculateDistance(
        pickUpGeolocation!.latitude,
        pickUpGeolocation!.longitude,
        dropOffGeolocation!.latitude,
        dropOffGeolocation!.longitude);
    fee = 1 * distance * int.parse(weightCtrl.text);
    setEstimated(true);
    notifyListeners();
  }

  void onError(PlacesAutocompleteResponse response) {
    showOkayDialog(message: response.errorMessage ?? "An error occured");
  }

  Future<Prediction?> getPrediction() async {
    Prediction? p = await PlacesAutocomplete.show(
      onError: onError,
      context: context,
      apiKey: AppInfo.placeApiKey,
      mode: Mode.fullscreen,
      logo: const Icon(
        Icons.send,
        size: 50,
        color: AppColors.primaryColor,
      ),
      language: "en",
      components: [
        Component(
          Component.country,
          "Ng",
        ),
      ],
    );
    return p;
  }

  Future<PlaceDetails> displayPredict(
      Prediction p, BuildContext context) async {
    PlacesDetailsResponse detail =
        await _places.getDetailsByPlaceId(p.placeId!);
    return detail.result;
  }

  submit({String? pickUp, String? dropOff}) async {
    try {
      setBusy(true);
      final uuid = const Uuid().v4();
      BookingModel data = BookingModel(
          pickUp: pkAddCtrl.text,
          dropOff: dpAddressCtrl.text,
          weight: int.parse(weightCtrl.text),
          recieverNo: number,
          uid: user.uid,
          deliveryStatus: 'pending',
          referenceId: uuid);
      final result = await _fireStoreRepo.submitBooking(data: data);
      if (result.status!) {
        setBusy(false);
        showOkayDialog(message: result.message!)
            .then((value) => _navigationService.pop());
      } else {
        setBusy(false);
        showOkayDialog(message: result.message!);
      }
    } catch (e) {
      setBusy(false);
      showOkayDialog(message: 'an error occured. Try again');
    }
  }
}

final sendItemVm = ChangeNotifierProvider<SendItemVm>(
  (ref) => SendItemVm(ref),
);

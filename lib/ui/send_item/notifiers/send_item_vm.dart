import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_google_places/flutter_google_places.dart';
import 'package:geoflutterfire/geoflutterfire.dart';
import 'package:google_maps_webservice/places.dart';
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
  final GoogleMapsPlaces _places =
      GoogleMapsPlaces(apiKey: AppInfo.placeApiKey);
  GeoFirePoint? geoLocation;
  Geoflutterfire geo = Geoflutterfire();

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

  void onError(PlacesAutocompleteResponse response) {
    showOkayDialog(message: response.errorMessage ?? "An error occured");
  }

  Future<Prediction?> getPrediction() async {
    Prediction? p = await PlacesAutocomplete.show(
      onError: onError,
      context: context,
      apiKey: AppInfo.placeApiKey,
      mode: Mode.overlay,
      logo: Row(
        children: [],
        mainAxisAlignment: MainAxisAlignment.center,
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

  Future<String> displayPredict(Prediction p, BuildContext context) async {
    PlacesDetailsResponse detail =
        await _places.getDetailsByPlaceId(p.placeId!);
    double lat = detail.result.geometry!.location.lat;
    double lng = detail.result.geometry!.location.lng;

    geoLocation = geo.point(latitude: lat, longitude: lng);
    return detail.result.formattedAddress!;
  }

  estimate() {}

  submit({String? pickUp, String? dropOff}) {}
}

final sendItemVm = ChangeNotifierProvider<SendItemVm>(
  (ref) => SendItemVm(ref),
);

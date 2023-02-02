import 'package:shared_preferences/shared_preferences.dart';

class LocalDataRequest {
  late SharedPreferences _pref;
  LocalDataRequest() {
    initPref();
  }

  initPref() async {
    _pref = await SharedPreferences.getInstance();
  }

  setString(String key, String value) async {
    await initPref();
    _pref.setString(key, value);
  }

  setBool(String key, bool value) async {
    await initPref();
    _pref.setBool(key, value);
  }

  setInt(String key, int value) async {
    await initPref();
    _pref.setInt(key, value);
  }

// get a local value for storage
  getString(String key) async {
    try {
      await initPref();
      var value = _pref.getString(key);
      if (value != null) {
        return value;
      } else {
        return "";
      }
    } catch (e) {
      return "";
    }
  }

  getInt(String key) async {
    try {
      await initPref();
      var value = _pref.getInt(key);
      if (value != null) {
        return value;
      } else {
        return 0;
      }
    } catch (e) {
      return 0;
    }
  }

  getBool(String key) async {
    try {
      await initPref();
      var value = _pref.getBool(key);
      if (value != null) {
        return value;
      } else {
        return false;
      }
    } catch (e) {
      return false;
    }
  }

  // remove a value

  remove(String key) async {
    await initPref();
    _pref.remove(key);
  }

  removeAll() async {
    await initPref();
    _pref.clear();
  }
}

import 'package:shared_preferences/shared_preferences.dart';

class Settings {
  static SharedPreferences _storage;

  static void init() async {
    if (_storage == null)
      _storage = await SharedPreferences.getInstance();
  }

  static bool showPersons() {
    _check();
    return _storage.containsKey("showPersons") ? _storage.getBool("showPersons") : true;
  }

  static void setShowPersons(bool value) {
    _check();
    _storage.setBool("showPersons", value);
  }

  static void _check() {
    if (_storage == null)
      throw new Exception("Call Settings.init() in main app widget");
  }
}

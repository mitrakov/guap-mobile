import 'package:shared_preferences/shared_preferences.dart';

class Settings {
  static SharedPreferences _storage;
  static const String _showPersonsKey = "showPersons";
  static const String _currencyRatesKey = "currencyRate";

  static void init() async {
    if (_storage == null)
      _storage = await SharedPreferences.getInstance();
  }

  static bool showPersons() {
    _check();
    return _storage.containsKey(_showPersonsKey) ? _storage.getBool(_showPersonsKey) : true;
  }

  static void setShowPersons(bool value) {
    _check();
    _storage.setBool(_showPersonsKey, value);
  }

  static double getCurrencyRate(String currency) {
    _check();
    if (_storage.containsKey("$_currencyRatesKey$currency"))
      return _storage.getDouble("$_currencyRatesKey$currency");
    switch (currency) {          // data by Google Finance 2023-03-19
      case "USD": return 1;
      case "EUR": return 1.0776;
      case "RUB": return 0.0130;
      case "AMD": return 0.0026;
      case "THB": return 0.0293;
      default:    return 1;      // default no-op multiplicator
    }
  }

  static void setCurrencyRate(String currency, double value) {
    _check();
    _storage.setDouble("$_currencyRatesKey$currency", value);
  }

  static void _check() {
    if (_storage == null)
      throw new Exception("Call Settings.init() in main app widget");
  }
}

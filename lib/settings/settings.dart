import 'package:shared_preferences/shared_preferences.dart';

class Settings {
  static SharedPreferences? _storage;
  static const String _showPersonsKey = "showPersons";
  static const String _currencyRatesKey = "currencyRate";

  static void init() async {
    if (_storage == null)
      _storage = await SharedPreferences.getInstance();
  }

  static bool showPersons() {
    _check();
    return (_storage!.containsKey(_showPersonsKey) ? _storage!.getBool(_showPersonsKey) : true) ?? true; // TODO update for null-safety
  }

  static void setShowPersons(bool value) {
    _check();
    _storage!.setBool(_showPersonsKey, value);
  }

  static double getCurrencyRate(String currency) {
    _check();
    if (_storage!.containsKey("$_currencyRatesKey$currency"))
      return _storage!.getDouble("$_currencyRatesKey$currency") ?? 1;
    switch (currency) {          // data by Google Finance 2023-03-19
      case "RUB": return 0.010862;
      case "USD": return 1;
      case "EUR": return 1.103144;
      case "KGS": return 0.01141;
      case "AMD": return 0.002588;
      case "THB": return 0.029253;
      default:    return 1;      // default no-op multiplicator
    }
  }

  static void setCurrencyRate(String currency, double value) {
    _check();
    _storage!.setDouble("$_currencyRatesKey$currency", value);
  }

  static void _check() {
    if (_storage == null)
      throw new Exception("Call Settings.init() in main app widget");
  }
}

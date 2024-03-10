import 'package:shared_preferences/shared_preferences.dart';

class Settings {
  static SharedPreferences? _storage;
  static const String _showPersonsKey = "showPersons";
  static const String _currencyRatesKey = "currencyRate";

  static void init() async {
    _storage ??= await SharedPreferences.getInstance();
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
    switch (currency) {          // data by Forbes 2024-03-10
      case "RUB": return 0.010995;
      case "USD": return 1;
      case "EUR": return 1.09435;
      case "GBP": return 1.2858;
      case "KGS": return 0.01141;
      case "AMD": return 0.002481;
      case "THB": return 0.028287;
      case "INR": return 0.012084;
      default:    return 1;      // default no-op multiplicator
    }
  }

  static void setCurrencyRate(String currency, double value) {
    _check();
    _storage!.setDouble("$_currencyRatesKey$currency", value);
  }

  static void _check() {
    if (_storage == null)
      throw Exception("Call Settings.init() in main app widget");
  }
}

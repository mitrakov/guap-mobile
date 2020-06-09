import 'package:guap_mobile/redux/ajax.dart';

class GlobalItemStore {
  static final Ajax ajax = Ajax();
  static final Map<String, List<String>> _store = {};

  static Future<List<String>> get(String category) async {
    if (_store.containsKey(category)) return _store[category];

    final items = await ajax.fetchItems(category);
    _store.putIfAbsent(category, () => items);
    return items;
  }
}

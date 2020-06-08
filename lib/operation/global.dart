import 'package:guap_mobile/operation/operation.dart';
import 'package:guap_mobile/redux/ajax.dart';

class GlobalOperationStore {
  static final Ajax ajax = Ajax();
  static final Map<int, Operation> _store = {};

  static Future<Operation> get(int id) async {
    if (_store.containsKey(id)) return _store[id];

    final operation = await ajax.fetchOperation(id);
    _store.putIfAbsent(id, () => operation);
    return operation;
  }
}

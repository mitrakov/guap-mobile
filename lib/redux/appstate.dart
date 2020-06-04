import 'package:guap_mobile/category/category.dart';
import 'package:guap_mobile/operation/operation.dart';

class AppState {
  final Map<int, Operation> _operationsCache = {}; // TODO
  final List<Category> _categories = [];
  final Map<String, List<String>> _items = {};
  final List<String> _persons = [];
  String lastError;

  void addOperation(int id, Operation operation) {
    _operationsCache.putIfAbsent(id, () => operation);
  }

  void setCategories(Iterable<Category> categories) {
    _categories.addAll(categories);
  }

  void addItems(String category, List<String> items) {
    _items.putIfAbsent(category, () => items);
  }

  void setPersons(Iterable<String> persons) {
    _persons.addAll(persons);
  }
}

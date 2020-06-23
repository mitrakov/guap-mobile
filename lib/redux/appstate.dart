import 'package:guap_mobile/category/category.dart';
import 'package:guap_mobile/category/redux.dart';
import 'package:guap_mobile/item/redux.dart';
import 'package:guap_mobile/operation/redux.dart';
import 'package:guap_mobile/person/redux.dart';

class AppState {
  final CategoryState categoryState;
  final ItemState itemState;
  final OperationsState operationsState;
  final PersonsState personsState;
  final String categoryToDisplay; // this CANNOT be used to determine item's category!
  final String lastError;

  AppState({
    this.categoryState = const CategoryState(),
    this.itemState = const ItemState(),
    this.operationsState = const OperationsState(),
    this.personsState = const PersonsState(),
    this.categoryToDisplay = '',
    this.lastError = '',
  }) {
   print("Creating Appstate: categories ${categoryState.categories.length}, items ${itemState.items.length}, operations ${operationsState.operations.length}, persons ${personsState.persons.length}, $categoryToDisplay, $lastError");
  }

  AppState withCategories(List<Category> categories) {
    return AppState(
      categoryState: CategoryState(categories: categories),
      itemState: this.itemState,
      operationsState: this.operationsState,
      personsState: this.personsState,
      categoryToDisplay: this.categoryToDisplay,
      lastError: this.lastError,
    );
  }

  AppState withItems(List<String> items) {
    return AppState(
      categoryState: this.categoryState,
      itemState: ItemState(items: items),
      operationsState: this.operationsState,
      personsState: this.personsState,
      categoryToDisplay: this.categoryToDisplay,
      lastError: this.lastError,
    );
  }

  AppState withOperations(List<int> operations, {String category}) {
    return AppState(
      categoryState: this.categoryState,
      itemState: this.itemState,
      operationsState: OperationsState(operations: operations),
      personsState: this.personsState,
      categoryToDisplay: category ?? this.categoryToDisplay,
      lastError: this.lastError,
    );
  }

  AppState withPersons(List<String> persons) {
    return AppState(
      categoryState: this.categoryState,
      itemState: this.itemState,
      operationsState: this.operationsState,
      personsState: PersonsState(persons: persons),
      categoryToDisplay: this.categoryToDisplay,
      lastError: this.lastError,
    );
  }

  AppState withCurrentCategory(String category) {
    return AppState(
      categoryState: this.categoryState,
      itemState: this.itemState,
      operationsState: this.operationsState,
      personsState: this.personsState,
      categoryToDisplay: category,
      lastError: this.lastError,
    );
  }

  AppState withLastError(String error) {
    return AppState(
      categoryState: this.categoryState,
      itemState: this.itemState,
      operationsState: this.operationsState,
      personsState: this.personsState,
      categoryToDisplay: this.categoryToDisplay,
      lastError: error,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
          other is AppState &&
              runtimeType == other.runtimeType &&
              categoryState == other.categoryState &&
              itemState == other.itemState &&
              operationsState == other.operationsState &&
              personsState == other.personsState &&
              categoryToDisplay == other.categoryToDisplay &&
              lastError == other.lastError;

  @override
  int get hashCode => categoryState.hashCode ^ itemState.hashCode ^ operationsState.hashCode ^ personsState.hashCode ^ categoryToDisplay.hashCode ^ lastError.hashCode;
}

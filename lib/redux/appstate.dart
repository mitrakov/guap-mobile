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

  AppState copy({
    List<Category>? categories,
    List<String>? items,
    List<int>? operations,
    List<String>? persons,
    String? categoryToDisplay,
    String? lastError,
  }) {

    return AppState(
      categoryState: categories != null ? CategoryState(categories: categories) : this.categoryState,
      itemState: items != null ? ItemState(items: items) : this.itemState,
      operationsState: operations != null ? OperationsState(operations: operations) : this.operationsState,
      personsState: persons != null ? PersonsState(persons: persons) : this.personsState,
      categoryToDisplay: categoryToDisplay ?? this.categoryToDisplay,
      lastError: lastError ?? this.lastError,
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
              lastError == other.lastError
  ;

  @override
  int get hashCode => categoryState.hashCode ^ itemState.hashCode ^ operationsState.hashCode ^ personsState.hashCode ^ categoryToDisplay.hashCode ^ lastError.hashCode;
}

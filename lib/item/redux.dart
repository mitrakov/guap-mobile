import 'package:flutter/foundation.dart';
import 'package:redux/redux.dart';
import 'package:redux_thunk/redux_thunk.dart';
import 'package:guap_mobile/item/item.dart';
import 'package:guap_mobile/operation/global.dart';
import 'package:guap_mobile/redux/appstate.dart';
import 'package:guap_mobile/redux/actions.dart';
import 'package:guap_mobile/redux/ajax.dart';

class ItemState {
  final List<String> items;

  const ItemState({this.items = const []});

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
          other is ItemState && runtimeType == other.runtimeType && listEquals(items, other.items);

  @override
  int get hashCode => items.hashCode;
}

class ItemsFetchedAction {
  final List<String> items;
  ItemsFetchedAction(this.items);
}

class ItemsThunk {
  static ThunkAction<AppState> fetchItems(String category) {
    return (Store<AppState> store) async {
      try {
        store.dispatch(ItemsFetchedAction(await Ajax.fetchItems(category)));
      } catch(e) {
        store.dispatch(ErrorAction(e.toString()));
      }
    };
  }

  static ThunkAction<AppState> addItem(String item, String category) {
    return (Store<AppState> store) {
      try {
        Ajax.addItem(AddItemRequest(item, category)).then((_) => store.dispatch(fetchItems(category)));
      } catch(e) {
        store.dispatch(ErrorAction(e.toString()));
      }
    };
  }

  static ThunkAction<AppState> changeItem(String oldName, String newName, String newCategoryName) {
    return (Store<AppState> store) async {
      try {
        Ajax.changeItem(ChangeItemRequest(oldName, newName, newCategoryName)).then((_) {
          store.dispatch(fetchItems(newCategoryName));
          GlobalOperationStore.invalidateAll(); // recreate all operations to update items names
        });
      } catch(e) {
        store.dispatch(ErrorAction(e.toString()));
      }
    };
  }

  static ThunkAction<AppState> removeItem(String item, String category) {
    return (Store<AppState> store) async {
      try {
        Ajax.removeItem(RemoveItemRequest(item)).then((_) => store.dispatch(fetchItems(category)));
      } catch(e) {
        store.dispatch(ErrorAction(e.toString()));
      }
    };
  }
}

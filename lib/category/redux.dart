import 'package:flutter/foundation.dart' as f;
import 'package:optional/optional.dart';
import 'package:redux/redux.dart';
import 'package:redux_thunk/redux_thunk.dart';
import 'package:guap_mobile/category/category.dart';
import 'package:guap_mobile/operation/global.dart';
import 'package:guap_mobile/redux/appstate.dart';
import 'package:guap_mobile/redux/actions.dart';
import 'package:guap_mobile/redux/ajax.dart';

typedef CategoryListFunc = void Function(List<Category> list, Optional<Category> parent, int level);

class CategoryState {
  final List<Category> categories;
  const CategoryState({this.categories = const []});

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
          other is CategoryState &&
              runtimeType == other.runtimeType &&
              f.listEquals(categories, other.categories);

  @override
  int get hashCode => categories.hashCode;

  List<CategoryItem> asPlainList() {
    final result = <CategoryItem>[];

    late CategoryListFunc f;
    f = (List<Category> lst, Optional<Category> parent, int level) {
      lst.forEach((c) {
        result.add(CategoryItem(c, parent, level));
        f(c.items, Optional.of(c), level + 1);
      });
    };

    f(categories, Optional.empty(), 0);
    return result;
  }
}

class CategoriesFetchedAction {
  final List<Category> categories;
  CategoriesFetchedAction(this.categories);
}

class CategoryThunk {
  static ThunkAction<AppState> fetchCategories() {
    return (Store<AppState> store) async {
      try {
        store.dispatch(CategoriesFetchedAction(await Ajax.fetchCategoriesTree()));
      } catch(e) {
        store.dispatch(ErrorAction(e.toString()));
      }
    };
  }

  static ThunkAction<AppState> changeCategory(String oldName, String newName, String parent) {
    return (Store<AppState> store) async {
      try {
        Ajax.changeCategory(ChangeCategoryRequest(oldName, newName, parent)).then((_) {
          store.dispatch(fetchCategories());
          GlobalOperationStore.invalidateAll(); // recreate all operations to update category names
        });
      } catch(e) {
        store.dispatch(ErrorAction(e.toString()));
      }
    };
  }

  static ThunkAction<AppState> removeCategory(String name) {
    return (Store<AppState> store) async {
      try {
        Ajax.removeCategory(RemoveCategoryRequest(name)).then((_) => store.dispatch(fetchCategories()));
      } catch(e) {
        store.dispatch(ErrorAction(e.toString()));
      }
    };
  }
}

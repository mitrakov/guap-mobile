import 'package:flutter/foundation.dart' as f;
import 'package:redux/redux.dart';
import 'package:redux_thunk/redux_thunk.dart';
import 'package:guap_mobile/category/category.dart';
import 'package:guap_mobile/operation/global.dart';
import 'package:guap_mobile/redux/actions.dart';
import 'package:guap_mobile/redux/ajax.dart';

typedef CategoryListFunc = void Function(List<Category> list, int level);

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
    final result = new List<CategoryItem>();

    CategoryListFunc f;
    f = (List<Category> lst, int level) {
      lst.forEach((c) {
        result.add(CategoryItem(c, level));
        f(c.items, level + 1);
      });
    };

    f(categories, 0);
    return result;
  }
}

class CategoriesFetchedAction {
  final List<Category> categories;
  CategoriesFetchedAction(this.categories);
}

class CategoryThunk {
  static ThunkAction fetchCategories() {
    return (Store store) async {
      try {
        store.dispatch(CategoriesFetchedAction(await Ajax.fetchCategoriesTree()));
      } catch(e) {
        store.dispatch(ErrorAction(e.toString()));
      }
    };
  }

  static ThunkAction changeCategory(String oldName, String newName, String parentNullable) {
    return (Store store) async {
      try {
        Ajax.changeCategory(ChangeCategoryRequest(oldName, newName, parentNullable)).then((_) {
          store.dispatch(fetchCategories());
          GlobalOperationStore.invalidateAll(); // recreate all operations to update category names
        });
      } catch(e) {
        store.dispatch(ErrorAction(e.toString()));
      }
    };
  }

  static ThunkAction removeCategory(String name) {
    return (Store store) async {
      try {
        Ajax.removeCategory(RemoveCategoryRequest(name)).then((_) => store.dispatch(fetchCategories()));
      } catch(e) {
        store.dispatch(ErrorAction(e.toString()));
      }
    };
  }
}

import 'package:guap_mobile/category/category.dart';
import 'package:redux/redux.dart';
import 'package:redux_thunk/redux_thunk.dart';
import 'package:guap_mobile/redux/ajax.dart';

class CategoryState {
  final List<Category> categories;
  const CategoryState({this.categories = const []});
}

class CategoriesFetchedAction {
  final List<Category> categories;
  CategoriesFetchedAction(this.categories);
}

class CategoriesFetchErrorAction {
  final String error;
  CategoriesFetchErrorAction(this.error);
}

class CategoryThunk {
  static ThunkAction fetchCategories() {
    return (Store store) async {
      try {
        store.dispatch(CategoriesFetchedAction(await Ajax.fetchCategoriesTree()));
      } catch(e) {
        store.dispatch(CategoriesFetchErrorAction(e.toString()));
      }
    };
  }
}

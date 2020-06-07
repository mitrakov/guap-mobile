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
  static final Ajax ajax = Ajax();

  static ThunkAction fetchCategories() {
    return (Store store) async {
      try {
        store.dispatch(CategoriesFetchedAction(await ajax.fetchCategoriesTree()));
      } catch(e) {
        store.dispatch(CategoriesFetchErrorAction(e.toString()));
      }
    };
  }
}

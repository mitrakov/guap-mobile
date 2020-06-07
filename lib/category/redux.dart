import 'package:guap_mobile/category/category.dart';
import 'package:redux/redux.dart';
import 'package:redux_thunk/redux_thunk.dart';
import 'package:guap_mobile/redux/ajax.dart';

class CategoryState {
  final List<Category> categories;
  final String error;

  CategoryState({this.categories = const [], this.error = ''});
}

class CategoriesFetchedAction {
  final List<Category> categories;

  CategoriesFetchedAction(this.categories);
}

class FetchErrorAction {
  final String error;
  FetchErrorAction(this.error);
}

class CategoryReducer {
  static CategoryState categoriesFetchedReducer(CategoryState state, CategoriesFetchedAction action) {
    return CategoryState(categories: action.categories);
  }
  static CategoryState fetchErrorReducer(CategoryState state, FetchErrorAction action) {
    return CategoryState(error: action.error);
  }

  static Reducer<CategoryState> reducer = combineReducers<CategoryState>([
    TypedReducer<CategoryState, CategoriesFetchedAction>(categoriesFetchedReducer),
    TypedReducer<CategoryState, FetchErrorAction>(fetchErrorReducer)
  ]);
}

class CategoryThunk {
  static final Ajax ajax = Ajax();

  static ThunkAction fetchCategories() {
    return (Store store) async {
      try {
        store.dispatch(CategoriesFetchedAction(await ajax.fetchCategoriesTree()));
      } catch(e) {
        store.dispatch(FetchErrorAction(e.toString()));
      }
    };
  }
}

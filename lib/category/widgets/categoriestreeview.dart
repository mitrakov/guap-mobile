import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:guap_mobile/category/redux.dart';
import 'package:guap_mobile/operation/redux.dart';
import 'package:guap_mobile/redux/appstate.dart';

class CategoriesLeftView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, CategoryState> (
      distinct: true,
      converter: (store) => store.state.categoryState,
      builder: (context1, state) {
        print("Rebiulding categories");
        if (state.categories.isEmpty)
          StoreProvider.of<AppState>(context1).dispatch(CategoryThunk.fetchCategories());
        return Expanded(
          child: ListView.builder(
            itemCount: state.categories.length,
            itemBuilder: (context2, i) {
              final item = state.categories[i].labelUtf8;
              return ListTile(title: Text(item), onTap: () {
                StoreProvider.of<AppState>(context2).dispatch(OperationsThunk.fetchOperations(item));
                Navigator.pop(context2);
              });
            }
          )
        );
      }
    );
  }
}

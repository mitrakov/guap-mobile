import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:guap_mobile/category/redux.dart';
import 'package:redux/redux.dart';
import 'package:redux_thunk/redux_thunk.dart';

void main() {
  final store = new Store<CategoryState>(
      CategoryReducer.reducer,
      initialState: CategoryState(),
      middleware: [thunkMiddleware]
  );

  runApp(MyApp(store: store));
}

class MyApp extends StatelessWidget {
  final Store<CategoryState> store;

  const MyApp({Key key, this.store}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StoreProvider<CategoryState>(store: store, child: MaterialApp(
        title: "Guap",
        home: Scaffold(appBar: AppBar(
            title: Text("Guap application")),
            body: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                RaisedButton(child: Text("Push me!"), onPressed: () => store.dispatch(CategoryThunk.fetchCategories())),
                StoreConnector<CategoryState, CategoryState>(
                  converter: (store) => store.state,
                  builder: (context, state) {
                    return Expanded(child: ListView.builder(
                        itemCount: state.error.isNotEmpty ? 1 : state.categories.length,
                        itemBuilder: (ctxt, i) {
                          final item = state.error.isNotEmpty ? state.error : state.categories[i].label;
                          return ListTile(title: Text(item));
                        })
                    );
                  }
                )
              ],
            )
        )
    ));
  }
}

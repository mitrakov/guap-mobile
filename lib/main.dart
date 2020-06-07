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
        home: MyScaffold(store: store)
    ));
  }
}

class MyScaffold extends StatelessWidget {
  final Store<CategoryState> store;

  const MyScaffold({Key key, this.store}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: AppBar(
        title: Text("Guap application")),
        drawer: MyDrawer(store: store),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[RaisedButton(child: Text("Hello!"), onPressed: () => print(1))],
        )
    );
  }
}

class CategoriesTreeView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StoreConnector<CategoryState, CategoryState>(
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
    );
  }
}

class MyDrawer extends StatefulWidget {
  final Store<CategoryState> store;

  const MyDrawer({Key key, this.store}) : super(key: key);

  State<StatefulWidget> createState() => MyDrawerState(store);
}

class MyDrawerState extends State<MyDrawer> {
  final Store<CategoryState> store;

  MyDrawerState(this.store);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: <Widget>[
          DrawerHeader(
            decoration: BoxDecoration(color: Colors.blue),
            child: Text("Hey", style: TextStyle(color: Colors.white, fontSize: 24)),
          ),
          CategoriesTreeView()
        ],
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    if (store.state.categories.isEmpty)
      store.dispatch(CategoryThunk.fetchCategories());
  }
}

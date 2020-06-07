import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:guap_mobile/category/redux.dart';
import 'package:guap_mobile/operation/redux.dart';
import 'package:guap_mobile/redux/appstate.dart';
import 'package:guap_mobile/redux/reducers.dart';
import 'package:redux/redux.dart';
import 'package:redux_thunk/redux_thunk.dart';

void main() {
  final store = new Store<AppState>(
      AppReducer.reducer,
      initialState: AppState(),
      middleware: [thunkMiddleware]
  );

  runApp(MyApp(store: store));
}

class MyApp extends StatelessWidget {
  final Store<AppState> store;

  const MyApp({Key key, this.store}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StoreProvider<AppState>(store: store, child: MaterialApp(
        title: "Guap",
        home: MyScaffold()
    ));
  }
}

class MyScaffold extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, String> (
      distinct: true,
      converter: (store) => store.state.lastError,
      builder: (context, state) {
        print("Rebiulding scaffold");
        return Scaffold(appBar: AppBar(
            title: Text("Guap application")),
            drawer: MyDrawer(),
            body: Column(children: <Widget>[
              Text(state.isEmpty ? "No errors": state),
              Expanded(child: OperationsView())
            ],)
        );
      },
    );
  }
}

class OperationsView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, OperationsState> (
      distinct: true,
      converter: (store) => store.state.operationsState,
      builder: (context, state) {
        print("Rebiulding operations");
        return Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            RaisedButton(child: Text("Fetch operations"), onPressed: () =>
                StoreProvider.of<AppState>(context).dispatch(OperationsThunk.fetchOperations())),
            Expanded(child: ListView.builder(
                itemCount: state.operations.length,
                itemBuilder: (ctxt, i) {
                  final item = state.operations[i].toString();
                  return ListTile(title: Text(item));
                })
            )
          ],
        );
      },
    );
  }
}

class CategoriesTreeView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, CategoryState>(
        distinct: true,
        converter: (store) => store.state.categoryState,
        builder: (context, state) {
          print("Rebiulding categories");
          if (state.categories.length == 0)
            StoreProvider.of<AppState>(context).dispatch(CategoryThunk.fetchCategories());
          return Expanded(child: ListView.builder(
              itemCount: state.categories.length,
              itemBuilder: (ctxt, i) {
                final item = state.categories[i].label;
                return ListTile(title: Text(item));
              })
          );
        }
    );
  }
}

class MyDrawer extends StatefulWidget {
  State<StatefulWidget> createState() => MyDrawerState();
}

class MyDrawerState extends State<MyDrawer> {
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
}

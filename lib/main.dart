import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:guap_mobile/category/redux.dart';
import 'package:guap_mobile/myview.dart';
import 'package:guap_mobile/operation/redux.dart';
import 'package:guap_mobile/operation/widget.dart';
import 'package:guap_mobile/redux/appstate.dart';
import 'package:guap_mobile/redux/reducers.dart';
import 'package:guap_mobile/widget/addoperation.dart';
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
    if (store.state.categoryState.categories.length == 0)
      store.dispatch(CategoryThunk.fetchCategories());
    return StoreProvider<AppState>(store: store, child: MaterialApp(
        title: "Guap",
        initialRoute: "/main",
        routes: {
          "/main": (context1) => MyScaffold(),
          "/chooseCategory": (context1) => Scaffold(
              appBar: AppBar(title: Text("Guap application")),
              body: MyTreeView(store.state.categoryState.categories)
          )
        },
        onGenerateRoute: (routeSettings) {
          if (routeSettings.name == "/addOperation") {
            return MaterialPageRoute(builder: (context1) => Scaffold(
                appBar: AppBar(title: Text("Guap application")),
                body: AddOperationScreen(routeSettings.arguments.toString())
            ));
          }
          return null;
        },
    ));
  }
}

class MyScaffold extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, String> (
      distinct: true,
      converter: (store) => store.state.lastError,
      builder: (context1, state) {
        print("Rebiulding scaffold");
        return Scaffold(
          appBar: AppBar(
            title: Text("Guap application")),
            drawer: MyDrawer(),
            floatingActionButton: FloatingActionButton(
              child: Icon(Icons.add),
              tooltip: "Add operation",
              onPressed: () => Navigator.pushNamed(context1, "/chooseCategory"),
            ),
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
      builder: (context1, state) {
        print("Rebiulding operations");
        return Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Expanded(child: ListView.builder(
                itemCount: state.operations.length,
                itemBuilder: (context2, i) => OperationTile(state.operations[i], ValueKey(state.operations[i]))
              )
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
        builder: (context1, state) {
          print("Rebiulding categories");
          final store = StoreProvider.of<AppState>(context1);
          if (state.categories.length == 0)
            store.dispatch(CategoryThunk.fetchCategories());
          return Expanded(child: ListView.builder(
              itemCount: state.categories.length,
              itemBuilder: (context2, i) {
                final item = state.categories[i].label;
                return ListTile(title: Text(item), onTap: () {
                  store.dispatch(OperationsThunk.fetchOperations(item));
                  Navigator.pop(context2);
                });
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

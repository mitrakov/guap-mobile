import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:guap_mobile/category/redux.dart';
import 'package:guap_mobile/mainscaffold.dart';
import 'package:guap_mobile/myview.dart';
import 'package:guap_mobile/operation/widgets/operationscaffold.dart';
import 'package:guap_mobile/person/redux.dart';
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
  store.dispatch(CategoryThunk.fetchCategories());
  store.dispatch(PersonsThunk.fetchPersons());

  runApp(MyApp(store: store));
}

class MyApp extends StatelessWidget {
  final Store<AppState> store;

  const MyApp({Key key, this.store}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    const mainRoute = "/main";
    return StoreProvider<AppState>(store: store, child: MaterialApp(
        title: "Guap",
        initialRoute: mainRoute,
        routes: {
          mainRoute: (context1) => MainScaffold(),
          "/chooseCategory": (context1) => Scaffold(
              appBar: AppBar(title: Text("Guap application")),
              body: MyTreeView(store.state.categoryState.categories)
          )
        },
        onGenerateRoute: (routeSettings) {
          if (routeSettings.name == "/addOperation")
            return MaterialPageRoute(builder: (context1) =>
                OperationScaffold(routeSettings.arguments.toString()));
          return null;
        },
    ));
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:guap_mobile/login/loginscreen.dart';
import 'package:guap_mobile/mainscaffold.dart';
import 'package:guap_mobile/category/widgets/categorieschooser.dart';
import 'package:guap_mobile/operation/widgets/operationscaffold.dart';
import 'package:guap_mobile/redux/appstate.dart';
import 'package:guap_mobile/redux/reducers.dart';
import 'package:redux/redux.dart';
import 'package:redux_thunk/redux_thunk.dart';

void main() {
  final store = new Store<AppState>(AppReducer.reducer, initialState: AppState(), middleware: [thunkMiddleware]);
  runApp(MyApp(store));
}

class MyApp extends StatelessWidget {
  final Store<AppState> store;

  const MyApp(this.store, {Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StoreProvider<AppState> (
      store: store,
      child: MaterialApp(
        title: "Guap",
        initialRoute: "/login",
        routes: {
          "/login": (context1) => LoginScreen(),
          "/main": (context1) => MainScaffold(),
          "/chooseCategory": (context1) => Scaffold(
            appBar: AppBar(title: Text("Guap application")),
            body: CategoriesChooser()
          )
        },
        onGenerateRoute: (routeSettings) {
          if (routeSettings.name == "/addOperation")
            return MaterialPageRoute(builder: (context1) =>
                OperationScaffold(routeSettings.arguments.toString()));
          return null;
        },
      )
    );
  }
}

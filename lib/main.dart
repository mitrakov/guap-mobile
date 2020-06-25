import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:guap_mobile/login/loginscreen.dart';
import 'package:guap_mobile/login/passcodechecker.dart';
import 'package:guap_mobile/login/passcodesetter.dart';
import 'package:guap_mobile/mainscaffold.dart';
import 'package:guap_mobile/category/widgets/categorieschooser.dart';
import 'package:guap_mobile/operation/widgets/operationscaffold.dart';
import 'package:guap_mobile/redux/appstate.dart';
import 'package:guap_mobile/redux/reducers.dart';
import 'package:optional/optional.dart';
import 'package:redux/redux.dart';
import 'package:redux_thunk/redux_thunk.dart';
import 'package:tuple/tuple.dart';

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
        initialRoute: "/checkPasscode",
        routes: {
          "/checkPasscode": (context1) => PasscodeChecker(),
          "/login": (context1) => LoginScreen(),
          "/setPasscode": (context1) => PasscodeSetter(),
          "/main": (context1) => MainScaffold(),
        },
        onGenerateRoute: (routeSettings) {
          if (routeSettings.name == "/operation")
            return MaterialPageRoute(builder: (context1) {
              final Tuple2<String, Optional<int>> args = routeSettings.arguments;
              final category = args.item1;
              final idOpt = args.item2;
              return AddOperationScaffold(category, idOpt);
            });
          if (routeSettings.name == "/chooseCategory")
            return MaterialPageRoute(builder: (context1) => Scaffold(
              appBar: AppBar(title: Text("Guap application")),
              body: CategoriesChooser(routeSettings.arguments)
            ));
          return null;
        },
      )
    );
  }
}

// TODO
// save all downloaded dependencies
// options to Joplin
//

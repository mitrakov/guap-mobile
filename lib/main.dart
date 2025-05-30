import 'package:optional/optional.dart';
import 'package:tuple/tuple.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';
import 'package:redux_thunk/redux_thunk.dart';
import 'package:guap_mobile/chart/widgets/piechart.dart';
import 'package:guap_mobile/chart/widgets/timechart.dart';
import 'package:guap_mobile/item/widgets/itemeditor.dart';
import 'package:guap_mobile/login/widgets/loginscreen.dart';
import 'package:guap_mobile/login/widgets/passcodechecker.dart';
import 'package:guap_mobile/login/widgets/passcodesetter.dart';
import 'package:guap_mobile/mainscaffold.dart';
import 'package:guap_mobile/category/widgets/categorieschooser.dart';
import 'package:guap_mobile/category/widgets/categoryeditor.dart';
import 'package:guap_mobile/operation/widgets/operationscaffold.dart';
import 'package:guap_mobile/operation/operation.dart';
import 'package:guap_mobile/person/widgets/personeditor.dart';
import 'package:guap_mobile/redux/appstate.dart';
import 'package:guap_mobile/redux/reducers.dart';
import 'package:guap_mobile/settings/settings.dart';
import 'package:guap_mobile/settings/settingswidget.dart';
import 'package:guap_mobile/query/widgets/aggregate.dart';

void main() {
  final store = new Store<AppState>(AppReducer.reducer, initialState: AppState(), middleware: [thunkMiddleware]);
  runApp(MyApp(store));
}

class MyApp extends StatelessWidget {
  final Store<AppState> store;

  const MyApp(this.store, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Settings.init();
    return StoreProvider<AppState> (
      store: store,
      child: MaterialApp(
        title: "Guap",
        initialRoute: "/checkPasscode",
        routes: {
          "/checkPasscode": (context) => PasscodeChecker(),
          "/login": (context) => LoginScreen(),
          "/setPasscode": (context) => PasscodeSetter(),
          "/main": (context) => MainScaffold(),
          "/persons": (context) => Scaffold(
            appBar: AppBar(title: Text("Guap application")),
            body: PersonEditor(),
          ),
          "/categories": (context) => Scaffold(
            appBar: AppBar(title: Text("Guap application")),
            body: CategoryEditor(),
          ),
          "/settings": (context) => Scaffold(
            appBar: AppBar(title: Text("Guap application")),
            body: SettingsWidget(),
          ),
          "/chart/pie": (context) => Scaffold(
            appBar: AppBar(title: Text("Guap application")),
            body: PieChart(),
          ),
          "/chart/time": (context) => Scaffold(
            appBar: AppBar(title: Text("Guap application")),
            body: TimeChart(),
          ),
          "/query/aggregate": (context) => Scaffold(
            appBar: AppBar(title: Text("Guap application")),
            body: QueryAggregateScreen(),
          )
        },
        onGenerateRoute: (routeSettings) {
          if (routeSettings.name == "/operation")
            return MaterialPageRoute(builder: (context1) {
              final args = routeSettings.arguments as Tuple2<String, Optional<Operation>>;
              final category = args.item1;
              final operationOpt = args.item2;
              return AddOperationScaffold(category, operationOpt);
            });
          if (routeSettings.name == "/chooseCategory")
            return MaterialPageRoute(builder: (context1) {
              final args = routeSettings.arguments as Tuple2<Optional<Operation>, String>;
              final operationIdOpt = args.item1;
              final nextRoute = args.item2;
              return Scaffold(
                appBar: AppBar(title: Text("Guap application")),
                body: CategoriesChooser(operationIdOpt, nextRoute),
              );
            });
          if (routeSettings.name == "/items")
            return MaterialPageRoute(builder: (context1) {
              final args = routeSettings.arguments as Tuple2<String, Optional<Operation>>;
              final category = args.item1;
              return Scaffold(
                appBar: AppBar(title: Text("Guap application")),
                body: ItemEditor(category),
              );
            });
          return null;
        },
      )
    );
  }
}

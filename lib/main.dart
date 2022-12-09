import 'package:optional/optional.dart';
import 'package:tuple/tuple.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';
import 'package:redux_thunk/redux_thunk.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
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
import 'package:guap_mobile/redux/actions.dart';
import 'package:guap_mobile/redux/appstate.dart';
import 'package:guap_mobile/redux/reducers.dart';
import 'package:guap_mobile/settings/settings.dart';
import 'package:guap_mobile/settings/settingswidget.dart';

void main() {
  final store = new Store<AppState>(AppReducer.reducer, initialState: AppState(), middleware: [thunkMiddleware]);
  runApp(MyApp(store));
}

class MyApp extends StatelessWidget {
  final Store<AppState> store;

  const MyApp(this.store, {Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Settings.init();
    initMessaging(store);
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
          "/persons": (context1) => Scaffold(
            appBar: AppBar(title: Text("Guap application")),
            body: PersonEditor(),
          ),
          "/categories": (context1) => Scaffold(
            appBar: AppBar(title: Text("Guap application")),
            body: CategoryEditor(),
          ),
          "/settings": (context1) => Scaffold(
            appBar: AppBar(title: Text("Guap application")),
            body: SettingsWidget(),
          ),
          "/chart/pie": (context1) => Scaffold(
            appBar: AppBar(title: Text("Guap application")),
            body: PieChart(),
          ),
          "/chart/time": (context1) => Scaffold(
            appBar: AppBar(title: Text("Guap application")),
            body: TimeChart(),
          ),
        },
        onGenerateRoute: (routeSettings) {
          if (routeSettings.name == "/operation")
            return MaterialPageRoute(builder: (context1) {
              final Tuple2<String, Optional<Operation>> args = routeSettings.arguments;
              final category = args.item1;
              final operationOpt = args.item2;
              return AddOperationScaffold(category, operationOpt);
            });
          if (routeSettings.name == "/chooseCategory")
            return MaterialPageRoute(builder: (context1) {
              final Tuple2<Optional<Operation>, String> args = routeSettings.arguments;
              final operationIdOpt = args.item1;
              final nextRoute = args.item2;
              return Scaffold(
                appBar: AppBar(title: Text("Guap application")),
                body: CategoriesChooser(operationIdOpt, nextRoute),
              );
            });
          if (routeSettings.name == "/items")
            return MaterialPageRoute(builder: (context1) {
              final Tuple2<String, Optional<Operation>> args = routeSettings.arguments;
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

  void initMessaging(Store<AppState> store) async {
    await Firebase.initializeApp();
    final messaging = FirebaseMessaging.instance;
    NotificationSettings settings = await messaging.requestPermission(
      alert: true,
      announcement: false,
      badge: true,
      carPlay: true,
      criticalAlert: false,
      provisional: false,
      sound: true,
    );
    final token = await messaging.getAPNSToken();
    print("User granted permission: ${settings.authorizationStatus}; Token is: $token");
    store.dispatch(TokenAction(token));
  }
}

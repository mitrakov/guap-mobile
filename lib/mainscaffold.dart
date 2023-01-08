import 'package:tuple/tuple.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:guap_mobile/category/widgets/categoriesdrawer.dart';
import 'package:guap_mobile/operation/operation.dart';
import 'package:guap_mobile/operation/widgets/operationview.dart';
import 'package:guap_mobile/redux/actions.dart';
import 'package:guap_mobile/redux/appstate.dart';
import 'package:optional/optional.dart';

class MainScaffold extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, Tuple2<String, String>> (
      distinct: true,
      converter: (store) => Tuple2(store.state.lastError, store.state.token),
      builder: (context1, state) {
        print("Rebiulding scaffold");
        final error = state.item1;
        final token = state.item2;
        if (error.contains("(http code 401)")) relogin(context1);
        return Scaffold (
          appBar: AppBar(
            title: Text("Guap application"),
            actions: <Widget>[_popupMenuCharts(context1), _popupMenuSettings(context1)],
          ),
          drawer: CategoriesDrawer(),
          floatingActionButton: FloatingActionButton(
            child: Icon(Icons.add),
            tooltip: "Add operation",
            onPressed: () => Navigator.pushNamed(context1, "/chooseCategory", arguments: Tuple2(Optional<Operation>.empty(), "/operation")),
          ),
          body: Column(children: <Widget>[
            Text(error.isEmpty ? "Token: $token": error),
            Expanded(child: OperationsView()),
          ])
        );
      }
    );
  }

  void relogin(BuildContext context) {
    Future.delayed(Duration(seconds: 0), () {
      StoreProvider.of<AppState>(context).dispatch(ThunkActions.resetAll());
      Navigator.popAndPushNamed(context, "/login");
    });
  }

  Widget _popupMenuSettings(BuildContext context) {
    return PopupMenuButton<String>(
      icon: Icon(Icons.settings),
      onSelected: (route) => Navigator.pushNamed(context, route, arguments: Tuple2(Optional<Operation>.empty(), "/items")),
      itemBuilder: (context1) => [
        PopupMenuItem<String>(
          value: "/persons",
          child: Text("Persons"),
        ),
        PopupMenuItem<String>(
          value: "/chooseCategory",
          child: Text("Items"),
        ),
        PopupMenuItem<String>(
          value: "/categories",
          child: Text("Categories"),
        ),
        PopupMenuItem<String>(
          value: "/settings",
          child: Text("Settings"),
        ),
      ],
    );
  }

  Widget _popupMenuCharts(BuildContext context) {
    return PopupMenuButton<String>(
      icon: Icon(Icons.insert_chart),
      onSelected: (route) => Navigator.pushNamed(context, route),
      itemBuilder: (context1) => [
        PopupMenuItem<String>(
          value: "/chart/pie",
          child: Text("Pie chart"),
        ),
        PopupMenuItem<String>(
          value: "/chart/time",
          child: Text("Time chart"),
        ),
        PopupMenuItem<String>(
          value: "/query/aggregate",
          child: Text("Aggregation"),
        ),
      ],
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:guap_mobile/category/widgets/categoriesdrawer.dart';
import 'package:guap_mobile/operation/widgets/operationview.dart';
import 'package:guap_mobile/redux/actions.dart';
import 'package:guap_mobile/redux/appstate.dart';
import 'package:optional/optional.dart';

class MainScaffold extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, String> (
      distinct: true,
      converter: (store) => store.state.lastError,
      builder: (context1, state) {
        print("Rebiulding scaffold");
        if (state.contains("(http code 401)")) relogin(context1);
        return Scaffold (
          appBar: AppBar(
            title: Text("Guap application"),
            actions: <Widget>[
              IconButton(icon: Icon(Icons.settings), onPressed: () => Navigator.pushNamed(context1, "/persons"))
            ],
          ),
          drawer: CategoriesDrawer(),
          floatingActionButton: FloatingActionButton(
            child: Icon(Icons.add),
            tooltip: "Add operation",
            onPressed: () => Navigator.pushNamed(context1, "/chooseCategory", arguments: Optional<int>.empty()),
          ),
          body: Column(children: <Widget>[
            Text(state.isEmpty ? "No errors": state),
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
}

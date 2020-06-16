import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:guap_mobile/category/widgets/categoriesdrawer.dart';
import 'package:guap_mobile/operation/widgets/operationview.dart';
import 'package:guap_mobile/redux/appstate.dart';

class MainScaffold extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, String> (
      distinct: true,
      converter: (store) => store.state.lastError,
      builder: (context1, state) {
        print("Rebiulding scaffold");
        return Scaffold (
          appBar: AppBar(title: Text("Guap application")),
          drawer: CategoriesDrawer(),
          floatingActionButton: FloatingActionButton(
            child: Icon(Icons.add),
            tooltip: "Add operation",
            onPressed: () => Navigator.pushNamed(context1, "/chooseCategory")
          ),
          body: Column(children: <Widget>[
            Text(state.isEmpty ? "No errors": state),
            Expanded(child: OperationsView())
          ])
        );
      }
    );
  }
}

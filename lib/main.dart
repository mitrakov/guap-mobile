import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';
import 'package:redux_thunk/redux_thunk.dart';
import 'package:guap_mobile/redux/appstate.dart';
import 'package:guap_mobile/redux/reducers.dart';
import 'package:guap_mobile/redux/thunks.dart';

void main() {
  final store = new Store<AppState>(
      AppReducer.reducer,
      initialState: AppState(persons: [], lastError: ""),
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
        home: Scaffold(appBar: AppBar(
            title: Text("Guap application")),
            body: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                RaisedButton(child: Text("Push me!"), onPressed: () => store.dispatch(Thunk.fetchPersons())),
                StoreConnector<AppState, AppState>(
                  converter: (store) => store.state,
                  builder: (context, state) {
                    return Expanded(child: ListView.builder(
                        itemCount: state.lastError.isNotEmpty ? 1 : state.persons.length,
                        itemBuilder: (ctxt, i) {
                          final item = state.lastError.isNotEmpty ? state.lastError : state.persons[i];
                          return ListTile(title: Text(item));
                        })
                    );
                  }
                )
              ],
            )
        )
    ));
  }
}

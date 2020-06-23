import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:guap_mobile/operation/redux.dart';
import 'package:guap_mobile/operation/widgets/operationtile.dart';
import 'package:guap_mobile/redux/appstate.dart';

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
            Expanded(
              child: ListView.builder(
                itemCount: state.operations.length,
                itemBuilder: (context2, i) {
                  final operationId = state.operations[i];
                  return OperationTile(operationId, ValueKey(operationId));
                }
              )
            )
          ]
        );
      }
    );
  }
}

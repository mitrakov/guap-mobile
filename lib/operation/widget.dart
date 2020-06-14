import 'package:flutter/material.dart';
import 'package:guap_mobile/operation/global.dart';
import 'package:guap_mobile/operation/operation.dart';

class OperationTile extends StatefulWidget {
  final int id;
  const OperationTile(this.id, Key key) : super(key: key);
  State<StatefulWidget> createState() => OperationTileState(id);
}

class OperationTileState extends State<OperationTile> {
  final int id;
  Future<Operation> future;

  OperationTileState(this.id);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Operation>(
      future: future,
      builder: (context2, snapshot) {
        if (snapshot.hasData)
          return ListTile(
            title: Text(snapshot.data.itemUtf8),
            subtitle: Text(snapshot.data.timeUtf8),
            trailing: Text(snapshot.data.summa.toString(), style: TextStyle(fontSize: 22)),
          );
        if (snapshot.hasError)
          return Text("${snapshot.error}");
        return CircularProgressIndicator();
      },
    );
  }

  @override
  void initState() {
    super.initState();
    future = GlobalOperationStore.get(id);
  }
}

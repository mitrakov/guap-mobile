import 'package:flutter/material.dart';
import 'package:guap_mobile/operation/global.dart';
import 'package:guap_mobile/operation/operation.dart';

class OperationTile extends StatelessWidget {
  final int id;

  const OperationTile(this.id, Key key) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Operation>(
      future: GlobalOperationStore.get(id), // it's ok to run future here because it's cached
      builder: (context1, snapshot) {
        if (snapshot.hasData)
          return ListTile(
            title: Text(snapshot.data.itemUtf8),
            subtitle: Text(snapshot.data.timeUtf8),
            trailing: Text("${snapshot.data.summa} ₽", style: TextStyle(fontSize: 22)),
          );
        if (snapshot.hasError)
          return Text("${snapshot.error}");
        return CircularProgressIndicator();
      },
    );
  }
}

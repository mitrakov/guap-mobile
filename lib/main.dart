import 'package:flutter/material.dart';
import 'package:guap_mobile/lake.dart';
import 'package:guap_mobile/request.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: "Guap",
        home: Scaffold(appBar: AppBar(
            title: Text("Guap application")),
            body: Column(
              children: <Widget>[
                Operations(),
                Text("fjos"),
                Text("fjos1"),
                Text("fjos"),
                Lake()
              ],
            )
        )
    );
  }
}

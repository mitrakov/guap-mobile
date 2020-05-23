import 'package:flutter/material.dart';

class MyWidget extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => MyWidgetState();
}

class MyWidgetState extends State<MyWidget> {
  int counter = 41;
  bool like = true;

  @override
  Widget build(BuildContext context) {
    return Row(children: <Widget>[
      IconButton(icon: Icon(like ? Icons.star : Icons.star_border, color: Colors.red,), onPressed: toggle),
      SizedBox(width: 18, child: Text("$counter"))
    ]);
  }

  void toggle() {
    setState(() {
      counter += like ? -1 : 1;
      like = !like;
    });
  }
}

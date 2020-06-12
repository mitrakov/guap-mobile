import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:guap_mobile/item/itemschooser.dart';
import 'package:guap_mobile/person/personChooser.dart';

class AddOperationScreen extends StatelessWidget {
  final String category;

  const AddOperationScreen(this.category, {Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(children: <Widget>[
      ItemsChooser(category),
      TextField(
        decoration: InputDecoration(
            border: OutlineInputBorder(),
            labelText: "Input sum"
        ),
      ),
      PersonChooser(),
      TextField(
        decoration: InputDecoration(
            border: OutlineInputBorder(),
            labelText: "Choose the date"
        ),
      ),
    ],);
  }
}

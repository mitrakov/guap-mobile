import 'package:flutter/material.dart';

class Buttons extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final colour = Theme.of(context).primaryColor;
    return Row(children: <Widget>[
      makeButton(Icons.phone, "CALL", colour),
      makeButton(Icons.near_me, "ROUTE", colour),
      makeButton(Icons.share, "SHARE", colour),
    ], mainAxisAlignment: MainAxisAlignment.spaceEvenly);
  }

  Widget makeButton(IconData iconData, String label, Color colour) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Icon(iconData, color: colour),
        Container(
          margin: EdgeInsets.only(top: 8),
          child: Text(label, style: TextStyle(fontSize: 12, fontWeight: FontWeight.w400, color: colour))
        )
      ]
    );
  }
}

import 'package:flutter/material.dart';

class Lake extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final colour = Theme.of(context).primaryColor;
    return Row(
      children: <Widget>[
        SizedBox(width: 100, height: 500, child: ListView(children: <Widget>[
          makeButton("label", colour),
          makeButton("rerre", colour),
          makeButton("grgvx", colour),
          makeButton("gffwe", colour),
          makeButton("apple", colour),
          makeButton("stand", colour),
          makeButton("gorem", colour),
          makeButton("fafee", colour),
          makeButton("vivid", colour),
        ]),),
        SizedBox(width: 100, height: 500, child: ListView(children: <Widget>[
          makeButton("label", colour),
          makeButton("rerre", colour),
          makeButton("grgvx", colour),
          makeButton("gffwe", colour),
          makeButton("apple", colour),
          makeButton("stand", colour),
          makeButton("gorem", colour),
          makeButton("fafee", colour),
          makeButton("vivid", colour),
        ]),)
      ],
    );
  }

  Widget makeButton(String label, Color colour) {
    return Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Icon(Icons.near_me, color: colour),
          Container(
              margin: EdgeInsets.only(top: 8),
              child: Text(label, style: TextStyle(fontSize: 12, fontWeight: FontWeight.w400, color: colour))
          )
        ]
    );
  }
}

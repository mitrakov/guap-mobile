import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:guap_mobile/mywidget.dart';

class Header extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(20),
      child: Row(
        children: <Widget>[
          Expanded(
            child: Column(
              children: <Widget>[
                Container(
                  padding: EdgeInsets.only(bottom: 8),
                  child: Text("Oeschinen Lake Campground", style: TextStyle(fontWeight: FontWeight.bold)),
                ),
                Text("Kandersteg, Switherland", style: TextStyle(color: Colors.grey[500]))
              ],
              crossAxisAlignment: CrossAxisAlignment.start
            )
          ),
          MyWidget()
        ]
      )
    );
  }
}

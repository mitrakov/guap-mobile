import 'package:flutter/material.dart';
import 'package:guap_mobile/category/widgets/categoriestreeview.dart';

class CategoriesDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer (
      child: Column(children: <Widget>[
        Container(
          height: 100,
          width: double.infinity,
          child: DrawerHeader(
            decoration: BoxDecoration(color: Colors.blue),
            child: Text("Categories", style: TextStyle(color: Colors.white, fontSize: 24)),
          ),
        ),
        CategoriesLeftView(),
      ])
    );
  }
}

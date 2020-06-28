import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:guap_mobile/category/category.dart';
import 'package:guap_mobile/category/redux.dart';
import 'package:guap_mobile/redux/appstate.dart';

class CategoryEditor extends StatelessWidget {
  final TextEditingController changeCategoryCtrl = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, CategoryState>(
      distinct: true,
      converter: (store) => store.state.categoryState,
      builder: (context1, state) {
        if (state.categories.isEmpty)
          StoreProvider.of<AppState>(context1).dispatch(CategoryThunk.fetchCategories());
        final categories = state.asPlainList();
        return ListView.builder(
          itemCount: categories.length,
          itemBuilder: (context2, i) => _createTile(context2, categories[i]),
        );
      },
    );
  }

  Widget _createTile(BuildContext context, CategoryItem item) {
    final String category = "${" " * 4 * item.level}${item.category.labelUtf8}";
    final String parent = item.parentOpt.map((c) => "${c.labelUtf8}").orElseGet(() => null);
    return Slidable(
      actionPane: SlidableDrawerActionPane(),
      actionExtentRatio: 0.2,
      child: ListTile(
        title: Text(category),
        leading: Icon(Icons.screen_lock_landscape),
      ),
      secondaryActions: <Widget>[
        IconSlideAction(
          caption: "Edit",
          color: Colors.grey[400],
          icon: Icons.mode_edit,
          onTap: () => _changeCategoryDialog(context, item.category.labelUtf8, parent).show(),
        ),
        IconSlideAction(
          caption: "Delete",
          color: Colors.red[400],
          icon: Icons.delete,
          onTap: () => StoreProvider.of<AppState>(context).dispatch(CategoryThunk.removeCategory(item.category.labelUtf8)),
        ),
      ]
    );
  }

  Alert _changeCategoryDialog(BuildContext context, String curName, String parentNullable) {
    changeCategoryCtrl.text = curName;
    return Alert(
      context: context,
      title: "Rename category",
      content: Column(
        children: <Widget>[
          TextField(
            controller: changeCategoryCtrl,
            decoration: InputDecoration(icon: Icon(Icons.category), labelText: "Category name"),
          )
        ],
      ),
      buttons: [
        DialogButton(
          child: Text("Rename", style: TextStyle(color: Colors.white, fontSize: 20)),
          onPressed: () {
            final newName = changeCategoryCtrl.text;
            if (newName.isNotEmpty && newName != curName) {
              StoreProvider.of<AppState>(context).dispatch(CategoryThunk.changeCategory(curName, newName, parentNullable));
              Navigator.pop(context);
            }
          }
        ),
      ],
    );
  }
}

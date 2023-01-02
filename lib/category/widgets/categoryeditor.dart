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
    final String categoryText = "${" " * 6 * item.level}${item.category.labelUtf8}";
    final String parent = item.parentOpt.map((c) => "${c.labelUtf8}").orElse("");
    return Slidable(
      actionPane: SlidableDrawerActionPane(),
      actionExtentRatio: 0.2,
      child: ListTile(
        title: Text(categoryText),
        leading: Icon(item.level == 0 ? Icons.screen_lock_landscape : Icons.stop),
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
          onTap: () => _removeCategoryDialog(context, item.category.labelUtf8).show(),
        ),
      ]
    );
  }

  Alert _changeCategoryDialog(BuildContext context, String curName, String parent) {
    changeCategoryCtrl.text = curName;
    return Alert(
      context: context,
      title: "Rename category",
      closeFunction: () => {},
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
              StoreProvider.of<AppState>(context).dispatch(CategoryThunk.changeCategory(curName, newName, parent));
              Navigator.pop(context);
            }
          }
        ),
      ],
    );
  }

  Alert _removeCategoryDialog(BuildContext context, String category) {
    return Alert(
      context: context,
      title: "Are you sure to remove category $category?",
      closeFunction: () => {},
      buttons: [
        DialogButton(
          child: Text("Cancel", style: TextStyle(color: Colors.white, fontSize: 20)),
          onPressed: () => Navigator.pop(context),
        ),
        DialogButton(
          color: Colors.grey[300],
          child: Text("Delete", style: TextStyle(color: Colors.deepOrange[800], fontSize: 20, fontWeight: FontWeight.w600)),
          onPressed: () {
            StoreProvider.of<AppState>(context).dispatch(CategoryThunk.removeCategory(category));
            Navigator.pop(context);
          },
        ),
      ],
    );
  }
}

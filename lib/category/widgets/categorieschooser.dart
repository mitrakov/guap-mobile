import 'package:flutter/material.dart';
import 'package:flutter_treeview/tree_view.dart';
import 'package:guap_mobile/category/category.dart';

class CategoriesChooser extends StatelessWidget {
  final List<Category> categories;

  CategoriesChooser(this.categories, {Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    TreeViewController ctrl = TreeViewController(children: categories.map(toNode).toList());

    return TreeView (
      controller: ctrl,
      allowParentSelect: true,
      supportParentDoubleTap: false,
      //onExpansionChanged: _expandNodeHandler,
      onNodeTap: (key) {
        Navigator.pushNamed(context, "/addOperation", arguments: key);
        //setState(() {
          //ctrl = ctrl.copyWith(selectedKey: key);
        //});
      },
      theme: treeViewTheme
    );
  }

  Node<Category> toNode(Category category) {
    return Node (
      key: category.labelUtf8,
      label: category.labelUtf8,
      children: category.items.map(toNode).toList(),
      expanded: true,
      icon: NodeIcon.fromIconData(category.items.isEmpty ? Icons.stop : Icons.folder),
      data: category
    );
  }

  final TreeViewTheme treeViewTheme = TreeViewTheme(
    expanderTheme: ExpanderThemeData(
      type: ExpanderType.caret,
      modifier: ExpanderModifier.none,
      position: ExpanderPosition.start,
      color: Colors.black54,
      size: 24,
    ),
    labelStyle: TextStyle(
      fontSize: 16,
      letterSpacing: 0.3,
    ),
    parentLabelStyle: TextStyle(
      fontSize: 16,
      letterSpacing: 0.1,
      fontWeight: FontWeight.w800,
      color: Colors.black87,
    ),
    iconTheme: IconThemeData(
      size: 20,
      color: Colors.grey.shade800,
    ),
    colorScheme: ColorScheme.light(surface: Colors.grey),
  );
}

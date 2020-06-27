import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:flutter_treeview/tree_view.dart';
import 'package:guap_mobile/category/category.dart';
import 'package:guap_mobile/category/redux.dart';
import 'package:guap_mobile/item/redux.dart';
import 'package:guap_mobile/redux/appstate.dart';
import 'package:optional/optional.dart';
import 'package:tuple/tuple.dart';

class CategoriesChooser extends StatelessWidget {
  final Optional<int> operationIdOpt;
  final String nextRoute;

  CategoriesChooser(this.operationIdOpt, this.nextRoute, {Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, CategoryState>(
      distinct: true,
      converter: (store) => store.state.categoryState,
      builder: (context1, state) {
        final store = StoreProvider.of<AppState>(context1);
        if (state.categories.isEmpty)
          store.dispatch(CategoryThunk.fetchCategories());
        TreeViewController ctrl = TreeViewController(children: state.categories.map(toNode).toList());
        return TreeView (
          controller: ctrl,
          allowParentSelect: true,
          supportParentDoubleTap: false,
          //onExpansionChanged: _expandNodeHandler,
          onNodeTap: (key) {
            store.dispatch(ItemsThunk.fetchItems(key));
            Navigator.pushNamed(context, nextRoute, arguments: Tuple2(key, operationIdOpt));
            //setState(() {
            //ctrl = ctrl.copyWith(selectedKey: key);
            //});
          },
          theme: treeViewTheme,
        );
      }
    );
  }

  Node<Category> toNode(Category category) {
    return Node (
      key: category.labelUtf8,
      label: category.labelUtf8,
      children: category.items.map(toNode).toList(),
      expanded: true,
      icon: NodeIcon.fromIconData(category.items.isEmpty ? Icons.stop : Icons.folder),
      data: category,
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
      fontWeight: FontWeight.w600,
      color: Colors.black87,
    ),
    iconTheme: IconThemeData(
      size: 20,
      color: Colors.grey.shade800,
    ),
    colorScheme: ColorScheme.light(surface: Colors.grey),
  );
}

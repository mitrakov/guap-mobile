import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:guap_mobile/item/redux.dart';
import 'package:guap_mobile/redux/appstate.dart';

class ItemsChooser extends StatefulWidget { // we need Stateful widget for DropdownButton
  final TextEditingController ctrl;
  const ItemsChooser(this.ctrl, {Key? key}) : super(key: key);
  State<StatefulWidget> createState() => ItemsChooserState(ctrl);
}

class ItemsChooserState extends State<ItemsChooser> {
  final TextEditingController ctrl;

  ItemsChooserState(this.ctrl);

  @override
  Widget build(BuildContext context) {
    print("Rebiulding items chooser");
    return StoreConnector<AppState, ItemState>(
      distinct: true,
      converter: (store) => store.state.itemState,
      builder: (context1, state) => DropdownButton<String>(
        value: ctrl.text.isEmpty ? null : ctrl.text, // hack: DropdownButtons cannot hold empty values, only NULLs 🙄
        hint: Text("Choose the value"),
        icon: Icon(Icons.keyboard_arrow_down),
        items: state.items.map((item) => DropdownMenuItem(value: item, child: Text(item))).toList(),
        elevation: 16,
        onChanged: (String? newValue) {
          setState(() {
            ctrl.text = newValue ?? "";
          });
        }
      )
    );
  }
}

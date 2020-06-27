import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:guap_mobile/item/redux.dart';
import 'package:guap_mobile/redux/appstate.dart';

class ItemsChooser extends StatefulWidget {
  final ValueChanged<String> callback;
  const ItemsChooser(this.callback, {Key key}) : super(key: key);
  State<StatefulWidget> createState() => ItemsChooserState(callback);
}

class ItemsChooserState extends State<ItemsChooser> {
  final ValueChanged<String> callback;
  String currentValue;

  ItemsChooserState(this.callback);

  @override
  Widget build(BuildContext context) {
    print("Rebiulding items chooser");
    return StoreConnector<AppState, ItemState>(
      distinct: true,
      converter: (store) => store.state.itemState,
      builder: (context1, state) => DropdownButton(
        value: currentValue,
        hint: Text("Choose the value"),
        icon: Icon(Icons.keyboard_arrow_down),
        items: state.items.map((item) => DropdownMenuItem(value: item, child: Text(item))).toList(),
        elevation: 16,
        onChanged: (String newValue) {
          setState(() {
            callback(newValue);
            currentValue = newValue;
          });
        }
      )
    );
  }
}
